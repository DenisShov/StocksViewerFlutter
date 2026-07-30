import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stocks_viewer_flutter/core/theme/app_theme.dart';
import 'package:stocks_viewer_flutter/core/ui/app_keys.dart';
import 'package:stocks_viewer_flutter/features/stock_detail/domain/entities/candle.dart';
import 'package:stocks_viewer_flutter/features/stock_detail/presentation/chart/candle_chart.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

List<Candle> _candles(int count) => List.generate(
  count,
  (i) => Candle(
    open: 100.0 + i,
    high: 110.0 + i,
    low: 90.0 + i,
    close: 105.0 + i,
    timestampMs: i * 86400000,
  ),
);

void main() {
  testWidgets('CandleChart renders a 400-pixel-tall SfCartesianChart keyed candleChart', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: const AppTheme().light,
        home: Scaffold(body: CandleChart(candles: _candles(5))),
      ),
    );
    await tester.pump(const Duration(seconds: 2));

    final sizedBox = tester.widget<SizedBox>(
      find.ancestor(
        of: find.byKey(AppKeys.candleChart),
        matching: find.byType(SizedBox),
      ),
    );
    expect(sizedBox.height, 400);
    expect(find.byKey(AppKeys.candleChart), findsOneWidget);
    expect(find.byType(SfCartesianChart), findsOneWidget);
  });

  testWidgets('CandleChart builds without throwing for a large candle count', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: const AppTheme().dark,
        home: Scaffold(body: CandleChart(candles: _candles(40))),
      ),
    );
    await tester.pump(const Duration(seconds: 2));

    expect(find.byKey(AppKeys.candleChart), findsOneWidget);
  });
}
