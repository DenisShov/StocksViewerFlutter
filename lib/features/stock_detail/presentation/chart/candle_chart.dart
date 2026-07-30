// The Candle_Chart itself: an `SfCartesianChart` wrapped to a fixed
// 400-pixel height, configured per the Syncfusion mapping table in the
// design document (Requirement 11).
//
// `syncfusion_flutter_charts` is a commercial package. Using it requires
// either a Syncfusion Community License or a paid commercial licence;
// this needs a licence-eligibility review before shipping (task 1.1).
//
// The chart's own tooltip and trackball tooltip are both disabled here;
// the five-line marker (Requirement 11 AC 11 through AC 13, AC 15, AC 17,
// AC 18) is a separate custom overlay built on top of this widget by a
// later task, since no built-in Syncfusion option meets that
// specification (see the design document's "Two places where
// Syncfusion's built-in options do not reach the requirement").
library;

import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../core/theme/candle_colors.dart';
import '../../../../core/ui/app_keys.dart';
import '../../domain/entities/candle.dart';
import 'candle_axis_range.dart';
import 'candle_vm.dart';

/// The chart's fixed height (Requirement 11 AC 1).
const double candleChartHeight = 400;

/// How many of the most recent candles are visible in the initial
/// viewport, used to compute the initial horizontal scroll window
/// (Requirement 11 AC 3).
const int candleChartInitialVisibleCount = 30;

/// Renders [candles] as a candlestick chart.
///
/// Precondition: [candles] must be non-empty; callers render the
/// "no chart data" message instead of this widget for an empty list
/// (Requirement 10 AC 8).
class CandleChart extends StatelessWidget {
  const CandleChart({super.key, required this.candles});

  final List<Candle> candles;

  @override
  Widget build(BuildContext context) {
    final candleColors = Theme.of(context).extension<CandleColors>()!;
    final data = candles.map(CandleVm.fromCandle).toList(growable: false);
    final range = CandleAxisRange.from(candles);
    final count = data.length;
    final visibleMinimum = math.max(0, count - candleChartInitialVisibleCount)
        .toDouble();
    final visibleMaximum = (count - 1).toDouble();

    return SizedBox(
      height: candleChartHeight,
      child: SfCartesianChart(
        key: AppKeys.candleChart,
        primaryXAxis: CategoryAxis(
          interval: 2,
          // Raised so the auto-interval heuristic never overrides the
          // explicit `interval: 2` above (Requirement 11 AC 8).
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

  /// Computes the widest available width for a single horizontal axis
  /// label, so `AxisLabelIntersectAction.trim` (Requirement 11 AC 21) has
  /// a fixed budget to ellipsize against rather than relying on the
  /// package's own auto-sizing, which does not guarantee one line per
  /// label at every candle count (Requirement 11 AC 20).
  ///
  /// Every candle is a potential label position once `interval` combines
  /// with panning/zooming, so the budget is sized off the widest
  /// formatted label rather than the plot width divided by the labelled
  /// count, keeping the same label legible regardless of scroll offset.
  double _maximumLabelWidth(List<CandleVm> data) {
    if (data.isEmpty) return 0;
    final longest = data
        .map((candle) => candle.label.length)
        .reduce(math.max);
    // Matches the Android_Original's practice of sizing off character
    // count for a fixed-width estimate; ~7 logical pixels per character
    // of a `labelLarge`-scale label keeps `MMM dd yyyy` (11 characters)
    // fully visible while still enforcing a budget for narrower fonts.
    return longest * 7.0;
  }
}
