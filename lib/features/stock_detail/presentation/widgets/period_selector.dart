import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:stocks_viewer_flutter/core/ui/app_keys.dart';
import 'package:stocks_viewer_flutter/features/stock_detail/domain/entities/period.dart';
import 'package:stocks_viewer_flutter/l10n/generated/app_localizations.dart';

/// The Design_System-adjacent widget rendering the chart timespan segmented
/// control (Requirement 12 AC 1-9, Requirement 21 AC 7, AC 10).
///
/// Presentation-only: the currently selected [period] and the
/// [onPeriodSelected] callback are owned by the caller (eventually
/// `StockDetailNotifier`), so this widget holds no notion of which period is
/// selected in its own state - selection is derived solely from [period],
/// which keeps exactly one button selected at any time (Requirement 12 AC 9).
class PeriodSelector extends StatefulWidget {
  const PeriodSelector({
    required this.period,
    required this.onPeriodSelected,
    super.key,
  });

  /// The currently selected Period. Drives which button renders selected.
  final Period period;

  /// Invoked with the tapped button's Period whenever a button is tapped.
  final ValueChanged<Period> onPeriodSelected;

  @override
  State<PeriodSelector> createState() => _PeriodSelectorState();
}

class _PeriodSelectorState extends State<PeriodSelector>
    with TickerProviderStateMixin {
  // Damping ratio 0.5, stiffness 200, mass 1.0 (Requirement 12 AC 8).
  static final SpringDescription _spring = SpringDescription.withDampingRatio(
    mass: 1.0,
    stiffness: 200.0,
    ratio: 0.5,
  );

  late final Map<Period, AnimationController> _scaleControllers = {
    for (final period in Period.values)
      period: AnimationController(vsync: this, value: 1.0),
  };

  @override
  void didUpdateWidget(covariant PeriodSelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.period != widget.period) {
      _scaleControllers[oldWidget.period]!.animateWith(
        SpringSimulation(_spring, 1.05, 1.0, 0),
      );
      _scaleControllers[widget.period]!.animateWith(
        SpringSimulation(_spring, 1.0, 1.05, 0),
      );
    }
  }

  @override
  void dispose() {
    for (final controller in _scaleControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  String _labelFor(AppLocalizations l10n, Period period) {
    switch (period) {
      case Period.day:
        return l10n.periodDay;
      case Period.week:
        return l10n.periodWeek;
      case Period.month:
        return l10n.periodMonth;
      case Period.quartal:
        return l10n.periodQuartal;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return Container(
      key: AppKeys.periodSelector,
      width: double.infinity,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (var i = 0; i < Period.values.length; i++) ...[
            if (i > 0) const SizedBox(width: 4),
            Expanded(
              child: _PeriodButton(
                period: Period.values[i],
                label: _labelFor(l10n, Period.values[i]),
                isSelected: widget.period == Period.values[i],
                scale: _scaleControllers[Period.values[i]]!,
                colorScheme: colorScheme,
                textTheme: textTheme,
                onTap: () => widget.onPeriodSelected(Period.values[i]),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PeriodButton extends StatelessWidget {
  const _PeriodButton({
    required this.period,
    required this.label,
    required this.isSelected,
    required this.scale,
    required this.colorScheme,
    required this.textTheme,
    required this.onTap,
  });

  final Period period;
  final String label;
  final bool isSelected;
  final Animation<double> scale;
  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final targetBackground = isSelected
        ? colorScheme.primary
        : Colors.transparent;
    final targetTextColor = isSelected
        ? colorScheme.onPrimary
        : colorScheme.onSurface;

    return Semantics(
      key: AppKeys.periodButton(period.name),
      selected: isSelected,
      button: true,
      child: ScaleTransition(
        scale: scale,
        child: ConstrainedBox(
          constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
          child: TweenAnimationBuilder<Color?>(
            tween: ColorTween(end: targetBackground),
            duration: const Duration(milliseconds: 300),
            builder: (context, backgroundColor, child) {
              return Material(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(8),
                child: InkWell(
                  onTap: onTap,
                  borderRadius: BorderRadius.circular(8),
                  child: child,
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Center(
                child: TweenAnimationBuilder<Color?>(
                  tween: ColorTween(end: targetTextColor),
                  duration: const Duration(milliseconds: 300),
                  builder: (context, textColor, child) {
                    return Text(
                      label,
                      textAlign: TextAlign.center,
                      style: textTheme.labelLarge?.copyWith(
                        color: textColor,
                        fontWeight: isSelected
                            ? FontWeight.w700
                            : FontWeight.w400,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
