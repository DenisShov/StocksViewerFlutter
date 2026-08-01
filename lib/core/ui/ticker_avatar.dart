import 'package:flutter/material.dart';

class TickerAvatar extends StatelessWidget {
  const TickerAvatar({required this.ticker, super.key});

  final String ticker;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 56,
      height: 56,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colorScheme.secondaryContainer,
      ),
      child: Text(
        ticker,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: colorScheme.onSecondaryContainer,
          fontSize: ticker.length > 3 ? 12 : 14,
        ),
      ),
    );
  }
}
