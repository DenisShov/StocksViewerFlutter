import 'package:flutter/material.dart';

import 'app_keys.dart';
import 'ticker_avatar.dart';
import 'type_chip.dart';

/// The Design_System widget rendering a single ticker row, shared by the
/// Stocks_List_Screen and the Favorites_Screen (Requirement 4 AC 1, AC 2,
/// AC 3, AC 8, AC 9, AC 10, AC 13, AC 18, AC 22; Requirement 21 AC 7, AC 8).
///
/// Takes primitive parameters rather than a feature entity so that
/// `lib/core/ui/` stays free of feature entities.
class StockListCard extends StatelessWidget {
  const StockListCard({
    required this.ticker,
    required this.name,
    required this.type,
    required this.onTap,
    super.key,
  });

  final String ticker;
  final String name;
  final String type;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Semantics(
        key: AppKeys.stockListCard(ticker),
        container: true,
        button: true,
        excludeSemantics: true,
        label: type.isEmpty ? '$ticker, $name' : '$ticker, $name, $type',
        child: Card(
          elevation: 2,
          color: colorScheme.surfaceContainerLow,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          clipBehavior: Clip.antiAlias,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minWidth: 48, minHeight: 48),
            child: InkWell(
              onTap: () => onTap(ticker),
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TickerAvatar(ticker: ticker),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                            style: textTheme.titleMedium?.copyWith(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                          if (type.isNotEmpty) ...[
                            const SizedBox(height: 4),
                            TypeChip(label: type),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
