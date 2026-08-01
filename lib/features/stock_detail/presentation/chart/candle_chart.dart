library;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/theme/candle_colors.dart';
import '../../../../core/ui/app_keys.dart';
import '../../../../core/utils/value_formatter.dart';
import '../../domain/entities/candle.dart';
import 'candle_axis_range.dart';
import 'candle_vm.dart';

const double candleChartHeight = 400;

const int candleChartInitialVisibleCount = 30;

class CandleChart extends StatelessWidget {
  const CandleChart({super.key, required this.candles});

  final List<Candle> candles;

  @override
  Widget build(BuildContext context) {
    final candleColors = Theme.of(context).extension<CandleColors>()!;
    final data = candles.map(CandleVm.fromCandle).toList(growable: false);
    final range = CandleAxisRange.from(candles);
    final count = data.length;
    final visibleMinimum = math
        .max(0, count - candleChartInitialVisibleCount)
        .toDouble();
    final visibleMaximum = (count - 1).toDouble();

    return SizedBox(
      height: candleChartHeight,
      child: SfCartesianChart(
        key: AppKeys.candleChart,
        primaryXAxis: CategoryAxis(
          interval: 2,

          maximumLabels: count,
          initialVisibleMinimum: visibleMinimum,
          initialVisibleMaximum: visibleMaximum,
          labelIntersectAction: AxisLabelIntersectAction.trim,
          maximumLabelWidth: _maximumLabelWidth(data),
          majorGridLines: const MajorGridLines(width: 0),
        ),
        primaryYAxis: NumericAxis(
          numberFormat: NumberFormat(r'$#,###', 'en_US'),
          interval: 10,
          minimum: range.minimum,
          maximum: range.maximum,
          majorGridLines: const MajorGridLines(
            width: 1,
            dashArray: <double>[4, 3],
          ),
        ),
        trackballBehavior: TrackballBehavior(
          enable: true,
          activationMode: ActivationMode.singleTap,
          lineType: TrackballLineType.vertical,
          lineDashArray: const <double>[4, 3],
          tooltipSettings: const InteractiveTooltip(enable: false),
          builder: (context, details) {
            final index = details.pointIndex;
            if (index == null || index < 0 || index >= candles.length) {
              return const SizedBox.shrink();
            }
            return _CandleMarker(candle: candles[index]);
          },
        ),
        zoomPanBehavior: ZoomPanBehavior(
          enablePanning: true,
          enablePinching: false,
          enableDoubleTapZooming: false,
          enableMouseWheelZooming: false,
          zoomMode: ZoomMode.x,
        ),
        series: <CartesianSeries<CandleVm, String>>[
          CandleSeries<CandleVm, String>(
            dataSource: data,
            xValueMapper: (candle, _) => candle.label,
            lowValueMapper: (candle, _) => candle.low,
            highValueMapper: (candle, _) => candle.high,
            openValueMapper: (candle, _) => candle.open,
            closeValueMapper: (candle, _) => candle.close,
            pointColorMapper: (candle, _) => candle.close >= candle.open
                ? candleColors.bullish
                : candleColors.bearish,
            enableSolidCandles: true,
            enableTooltip: false,
          ),
        ],
      ),
    );
  }

  double _maximumLabelWidth(List<CandleVm> data) {
    if (data.isEmpty) return 0;
    final longest = data.map((candle) => candle.label.length).reduce(math.max);

    return longest * 7.0;
  }
}

class _CandleMarker extends StatelessWidget {
  const _CandleMarker({required this.candle});

  final Candle candle;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final date = ValueFormatter.formatCandleAxisDate(
      DateTime.fromMillisecondsSinceEpoch(
        candle.timestampMs,
        isUtc: true,
      ).toLocal(),
    );
    return Container(
      key: AppKeys.candleChartMarker,
      constraints: const BoxConstraints(minWidth: 40),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 4, offset: Offset(0, 2))],
      ),
      child: Text(
        'Date: $date\n'
        'Open: \$${candle.open}\n'
        'Close: \$${candle.close}\n'
        'Low: \$${candle.low}\n'
        'High: \$${candle.high}',
        maxLines: 5,
        textAlign: TextAlign.center,
        style: theme.textTheme.bodySmall?.copyWith(
          color: theme.colorScheme.onSurface,
        ),
      ),
    );
  }
}
