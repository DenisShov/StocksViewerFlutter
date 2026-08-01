import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_viewer_flutter/features/stock_detail/presentation/providers/stock_detail_provider.dart';

void main() {
  test(
    'ticker family instances are auto-disposed after their route leaves',
    () {
      expect(stockDetailProvider('TSLA').isAutoDispose, isTrue);
    },
  );
}
