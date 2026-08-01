import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final featureRoot = Directory('lib/features');

  test('feature domain layers are independent of Flutter and outer layers', () {
    final violations = <String>[];

    for (final file in _dartFilesBelow(featureRoot, layer: 'domain')) {
      for (final import in _importsOf(file)) {
        if (_isFrameworkOrInfrastructureImport(import) ||
            import.contains('/data/') ||
            import.contains('/presentation/') ||
            import.contains('/providers/')) {
          violations.add('${file.path} imports $import');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Domain code must depend only on domain/core abstractions:\n'
          '${violations.join('\n')}',
    );
  });

  test('feature data layers do not depend on presentation or providers', () {
    final violations = <String>[];

    for (final file in _dartFilesBelow(featureRoot, layer: 'data')) {
      for (final import in _importsOf(file)) {
        if (import.contains('/presentation/') ||
            import.contains('/providers/') ||
            import.contains('flutter_riverpod')) {
          violations.add('${file.path} imports $import');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Data code must not know about presentation or DI wiring:\n'
          '${violations.join('\n')}',
    );
  });

  test('feature presentation layers do not instantiate the data layer', () {
    final violations = <String>[];

    for (final file in _dartFilesBelow(featureRoot, layer: 'presentation')) {
      for (final import in _importsOf(file)) {
        if (import.contains('/data/')) {
          violations.add('${file.path} imports $import');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Presentation must reach data through domain use cases:\n'
          '${violations.join('\n')}',
    );
  });

  test('one feature domain does not depend on another feature', () {
    final violations = <String>[];

    for (final file in _dartFilesBelow(featureRoot, layer: 'domain')) {
      final owner = _featureName(file.path);
      for (final import in _importsOf(file)) {
        final importedFeature = _featureFromPackageImport(import);
        if (importedFeature != null && importedFeature != owner) {
          violations.add('${file.path} imports $import');
        }
      }
    }

    expect(
      violations,
      isEmpty,
      reason:
          'Feature domains must remain independently reusable:\n'
          '${violations.join('\n')}',
    );
  });
}

Iterable<File> _dartFilesBelow(Directory root, {required String layer}) sync* {
  for (final entity in root.listSync(recursive: true)) {
    if (entity is! File ||
        !entity.path.endsWith('.dart') ||
        entity.path.endsWith('.g.dart')) {
      continue;
    }
    if (entity.path.split(Platform.pathSeparator).contains(layer)) {
      yield entity;
    }
  }
}

Iterable<String> _importsOf(File file) sync* {
  final importPattern = RegExp(
    r'''^\s*import\s+['"]([^'"]+)['"]''',
    multiLine: true,
  );
  for (final match in importPattern.allMatches(file.readAsStringSync())) {
    yield match.group(1)!;
  }
}

bool _isFrameworkOrInfrastructureImport(String import) =>
    import.startsWith('package:flutter/') ||
    import.contains('flutter_riverpod') ||
    import.startsWith('package:dio/') ||
    import.startsWith('package:drift/') ||
    import.startsWith('package:drift_flutter/') ||
    import.startsWith('package:cached_network_image/') ||
    import.startsWith('package:syncfusion_flutter_charts/');

String _featureName(String path) {
  final parts = path.split(Platform.pathSeparator);
  return parts[parts.indexOf('features') + 1];
}

String? _featureFromPackageImport(String import) {
  const prefix = 'package:stocks_viewer_flutter/features/';
  if (!import.startsWith(prefix)) return null;
  return import.substring(prefix.length).split('/').first;
}
