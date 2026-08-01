import 'package:flutter/material.dart';

class TypeChip extends StatelessWidget {
  const TypeChip({required this.label, super.key}) : emphasized = false;

  const TypeChip.emphasized({required this.label, super.key})
    : emphasized = true;

  final String label;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return DecoratedBox(
      decoration: BoxDecoration(
        color: emphasized
            ? colorScheme.secondaryContainer
            : colorScheme.surfaceContainerHigh,
        borderRadius: BorderRadius.circular(emphasized ? 8 : 6),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: emphasized ? 12 : 6,
          vertical: emphasized ? 4 : 2,
        ),
        child: Text(
          label,
          style: (emphasized ? textTheme.labelLarge : textTheme.labelSmall)
              ?.copyWith(color: colorScheme.onSurfaceVariant),
        ),
      ),
    );
  }
}
