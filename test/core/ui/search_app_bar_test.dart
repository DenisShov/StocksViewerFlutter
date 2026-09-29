import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:glados/glados.dart' show Any, StringAnys, any;
import 'package:stocks_viewer_flutter/core/ui/app_keys.dart';
import 'package:stocks_viewer_flutter/core/ui/search_app_bar.dart';
import 'package:stocks_viewer_flutter/l10n/generated/app_localizations.dart';

/// Pumps a [SearchAppBar] with `searchActive: true` inside a
/// `MaterialApp`/`Scaffold` test harness and returns the resulting
/// [TextField] widget, keyed [AppKeys.searchField].
Future<TextField> _pumpActiveSearchAppBar(
  WidgetTester tester, {
  String initialText = '',
  ValueChanged<String>? onSearchTextChanged,
  VoidCallback? onSearchClose,
}) async {
  final controller = TextEditingController(text: initialText);
  final focusNode = FocusNode();

  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        appBar: SearchAppBar(
          title: 'Stocks',
          searchActive: true,
          controller: controller,
          focusNode: focusNode,
          onSearchOpen: () {},
          onSearchClose: onSearchClose ?? () {},
          onSearchTextChanged: onSearchTextChanged ?? (_) {},
        ),
      ),
    ),
  );

  return tester.widget<TextField>(find.byKey(AppKeys.searchField));
}

/// Returns the ambient `DefaultTextStyle` at the location of the search
/// `TextField`. This is the style the `TextField` falls back to whenever it
/// has no explicit `style` of its own - i.e. the AppBar's title style.
TextStyle _ambientAppBarTitleStyle(WidgetTester tester) {
  final element = tester.element(find.byKey(AppKeys.searchField));
  return DefaultTextStyle.of(element).style;
}

void main() {
  group('SearchAppBar bug condition - search input text style', () {
    testWidgets(
      'isBugCondition: active TextField has no explicit style (baseline)',
      (tester) async {
        final textField = await _pumpActiveSearchAppBar(tester);

        // FUNCTION isBugCondition(input):
        //   RETURN input.searchActive == true AND
        //          input.renderedTextField.style IS NULL
        //
        // On unfixed code this passes, confirming the bug condition holds.
        expect(
          textField.style,
          isNull,
          reason:
              'Bug condition: the active-search TextField has no explicit '
              'style and therefore falls back to the ambient AppBar title '
              'style (small, non-bold).',
        );
      },
    );

    testWidgets(
      'expectedBehavior: active TextField renders large, bold input text',
      (tester) async {
        final textField = await _pumpActiveSearchAppBar(tester);
        final appBarTitleStyle = _ambientAppBarTitleStyle(tester);

        // Property 1 (Bug Condition / Expected Behavior) from design.md:
        //   result.textField.style != null
        //   AND result.textField.style.fontSize > appBarTitleStyle.fontSize
        //   AND result.textField.style.fontWeight == FontWeight.bold
        //
        // This assertion encodes the FIXED behavior and is expected to FAIL
        // on unfixed code, since `style` is currently null.
        expect(
          textField.style,
          isNotNull,
          reason:
              'Expected behavior: the active-search TextField should have '
              'an explicit style with an increased font size and bold '
              'weight, but it currently has none.',
        );
        expect(
          textField.style!.fontSize,
          greaterThan(appBarTitleStyle.fontSize ?? 0),
        );
        expect(textField.style!.fontWeight, FontWeight.bold);
      },
    );

    testWidgets(
      'baseline: inactive title style is available for later preservation checks',
      (tester) async {
        final controller = TextEditingController();
        final focusNode = FocusNode();

        await tester.pumpWidget(
          MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: Scaffold(
              appBar: SearchAppBar(
                title: 'Stocks',
                searchActive: false,
                controller: controller,
                focusNode: focusNode,
                onSearchOpen: () {},
                onSearchClose: () {},
                onSearchTextChanged: (_) {},
              ),
            ),
          ),
        );

        expect(find.text('Stocks'), findsOneWidget);
        expect(find.byKey(AppKeys.searchActionButton), findsOneWidget);
      },
    );

    // Concrete edge cases called out in design.md: empty, max-length (100),
    // and unicode query text. The bug is deterministic (missing `style` on
    // the TextField), so these confirm the missing style is independent of
    // the typed text content.
    testWidgets('style is null regardless of query text: empty', (
      tester,
    ) async {
      final textField = await _pumpActiveSearchAppBar(tester, initialText: '');
      expect(textField.style, isNull);
    });

    testWidgets('style is null regardless of query text: max-length (100)', (
      tester,
    ) async {
      final textField = await _pumpActiveSearchAppBar(
        tester,
        initialText: 'a' * 100,
      );
      expect(textField.style, isNull);
    });

    testWidgets('style is null regardless of query text: unicode', (
      tester,
    ) async {
      final textField = await _pumpActiveSearchAppBar(
        tester,
        initialText: 'テスラ 🚀 Tesla™ ñ',
      );
      expect(textField.style, isNull);
    });

    // Scoped property-based check (per tasks.md): the bug is deterministic,
    // so we generate random typed query strings (via glados' `any` generators)
    // purely to confirm the missing style is independent of text content.
    testWidgets(
      'style stays null for a range of glados-generated query strings',
      (tester) async {
        final random = Random(42);
        final queries = <String>[
          '', // empty
          'a' * 100, // max-length
          ...List.generate(
            10,
            (i) => any.letterOrDigits(random, 10 + i).value,
          ),
        ];

        for (final query in queries) {
          final textField = await _pumpActiveSearchAppBar(
            tester,
            initialText: query,
          );
          expect(
            textField.style,
            isNull,
            reason: 'Expected style to be null (bug present) for query '
                '"$query", regardless of content.',
          );
        }
      },
    );
  });
}
