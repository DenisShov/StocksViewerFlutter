import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/error/failure_message_resolver.dart';
import '../../../../core/ui/app_keys.dart';
import '../../../../core/ui/error_view.dart';
import '../../../../core/ui/stock_list_card.dart';
import '../../../../core/utils/value_formatter.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/favorites_provider.dart';
import '../providers/favorites_state.dart';

class FavoritesScreen extends ConsumerWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoritesProvider);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      key: AppKeys.favoritesScreen,
      appBar: AppBar(centerTitle: true, title: Text(l10n.favoritesTitle)),
      body: switch (state) {
        FavoritesPending() => Center(child: Text(l10n.favoritesLoadingText)),
        FavoritesEmpty() => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Center(
            child: Text(
              l10n.favoritesEmptyText,
              key: AppKeys.emptyStateMessage,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        FavoritesError(:final failure) => ErrorView(
          message: FailureMessageResolver(l10n).resolve(failure),
          onRetry: ref.read(favoritesProvider.notifier).retry,
        ),
        FavoritesLoaded(:final favorites) => ListView.separated(
          key: AppKeys.favoritesList,
          padding: const EdgeInsets.only(top: 16, bottom: 16),
          itemCount: favorites.length,
          separatorBuilder: (_, _) => const SizedBox(height: 16),
          itemBuilder: (context, index) {
            final favorite = favorites[index];
            return StockListCard(
              key: ValueKey(favorite.ticker),
              ticker: favorite.ticker,
              name: favorite.name.isEmpty ? favorite.ticker : favorite.name,
              type: ValueFormatter.formatType(favorite.type),
              onTap: (ticker) => context.push(
                '/favorites/detail/${Uri.encodeComponent(ticker)}',
              ),
            );
          },
        ),
      },
    );
  }
}
