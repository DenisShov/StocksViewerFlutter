import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../core/error/failure_message_resolver.dart';
import '../../../../core/ui/app_keys.dart';
import '../../../../core/ui/error_view.dart';
import '../../../../core/ui/shimmer_block.dart';
import '../../../../core/ui/type_chip.dart';
import '../../../../core/utils/value_formatter.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/candle.dart';
import '../../domain/entities/period.dart';
import '../../domain/entities/stock_overview.dart';
import '../chart/candle_chart.dart';
import '../providers/stock_detail_provider.dart';
import '../providers/stock_detail_state.dart';
import '../widgets/period_selector.dart';

class StockDetailScreen extends ConsumerWidget {
  const StockDetailScreen({required this.ticker, super.key});

  final String ticker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(stockDetailProvider(ticker));
    final notifier = ref.read(stockDetailProvider(ticker).notifier);
    final overviewSlice = state.overview;
    final overview = overviewSlice is SliceData<StockOverview>
        ? overviewSlice.value
        : null;
    final l10n = AppLocalizations.of(context);

    ref.listen(stockDetailProvider(ticker), (previous, next) {
      final failure = next.favoriteWriteFailure;
      if (failure != null && failure != previous?.favoriteWriteFailure) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(FailureMessageResolver(l10n).resolve(failure)),
          ),
        );
      }
    });

    return Scaffold(
      key: AppKeys.stockDetailScreen,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          key: AppKeys.backButton,
          tooltip: l10n.backButtonSemanticLabel,
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          overview?.ticker ?? '',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            key: AppKeys.favoriteToggle,
            tooltip: state.isFavorite
                ? l10n.removeFromFavoritesLabel
                : l10n.addToFavoritesLabel,
            onPressed: overview == null ? null : notifier.toggleFavorite,
            icon: Icon(
              state.isFavorite ? Icons.star : Icons.star_border,
              color: overview == null
                  ? Theme.of(
                      context,
                    ).colorScheme.onSurfaceVariant.withValues(alpha: 0.38)
                  : state.isFavorite
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
      body: switch (overviewSlice) {
        SliceLoading<StockOverview>() => const _DetailSkeleton(),
        SliceError<StockOverview>(:final failure) => ErrorView(
          message: FailureMessageResolver(l10n).resolve(failure),
          onRetry: notifier.retryAll,
        ),
        SliceData<StockOverview>(:final value) => _LoadedDetail(
          overview: value,
          state: state,
          onToggleAbout: notifier.toggleAbout,
          onRetryCandles: notifier.retryCandles,
          onPeriodSelected: notifier.selectPeriod,
        ),
      },
    );
  }
}

class _LoadedDetail extends StatelessWidget {
  const _LoadedDetail({
    required this.overview,
    required this.state,
    required this.onToggleAbout,
    required this.onRetryCandles,
    required this.onPeriodSelected,
  });

  final StockOverview overview;
  final StockDetailState state;
  final VoidCallback onToggleAbout;
  final VoidCallback onRetryCandles;
  final ValueChanged<Period> onPeriodSelected;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sections = <Widget>[
      _CompanyHeader(overview: overview, imageUrl: state.brandingImageUrl),
      if (_hasMarketData) _MarketData(overview: overview),
      if ((overview.description ?? '').isNotEmpty)
        _AboutSection(
          description: overview.description!,
          expanded: state.aboutExpanded,
          onTap: onToggleAbout,
        ),
      _ContactInformation(overview: overview),
      _ChartSection(
        state: state,
        onRetry: onRetryCandles,
        onPeriodSelected: onPeriodSelected,
        emptyMessage: l10n.noChartDataText,
      ),
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (var index = 0; index < sections.length; index++) ...[
            if (index > 0) const SizedBox(height: 24),
            sections[index],
          ],
        ],
      ),
    );
  }

  bool get _hasMarketData =>
      (overview.marketCap != null && overview.totalEmployees != null) ||
      (overview.sicDescription ?? '').isNotEmpty;
}

class _CompanyHeader extends StatelessWidget {
  const _CompanyHeader({required this.overview, required this.imageUrl});

  final StockOverview overview;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final resolvedImageUrl = imageUrl;
    final type = ValueFormatter.formatType(overview.type ?? '');
    final placeholder = Container(
      width: 72,
      height: 72,
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        color: Theme.of(context).colorScheme.onSurfaceVariant,
      ),
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Semantics(
          label: AppLocalizations.of(context).logoSemanticLabel,
          image: true,
          child: ClipOval(
            child: resolvedImageUrl == null
                ? placeholder
                : CachedNetworkImage(
                    imageUrl: resolvedImageUrl,
                    width: 72,
                    height: 72,
                    fit: BoxFit.cover,
                    fadeInDuration: const Duration(milliseconds: 250),
                    placeholder: (_, _) => placeholder,
                    errorWidget: (_, _, _) => placeholder,
                  ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                overview.name ?? overview.ticker,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (type.isNotEmpty) ...[
                const SizedBox(height: 4),
                SizedBox(height: 30, child: TypeChip.emphasized(label: type)),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _MarketData extends StatelessWidget {
  const _MarketData({required this.overview});

  final StockOverview overview;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final bothStats =
        overview.marketCap != null && overview.totalEmployees != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          l10n.marketDataHeading,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 12),
        if (bothStats)
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  label: l10n.marketCapLabel,
                  value: ValueFormatter.formatMarketCap(overview.marketCap)!,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  label: l10n.employeesLabel,
                  value: ValueFormatter.formatEmployees(
                    overview.totalEmployees,
                  )!,
                ),
              ),
            ],
          ),
        if (bothStats && (overview.sicDescription ?? '').isNotEmpty)
          const SizedBox(height: 12),
        if ((overview.sicDescription ?? '').isNotEmpty)
          _StatCard(label: l10n.sectorLabel, value: overview.sicDescription!),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _AboutSection extends StatelessWidget {
  const _AboutSection({
    required this.description,
    required this.expanded,
    required this.onTap,
  });

  final String description;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    return InkWell(
      key: AppKeys.aboutToggle,
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.aboutHeading, style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            description,
            maxLines: expanded ? null : 4,
            overflow: expanded ? TextOverflow.visible : TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              height: 22 / 14,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              expanded ? l10n.showLessLabel : l10n.readMoreLabel,
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ContactInformation extends StatelessWidget {
  const _ContactInformation({required this.overview});

  final StockOverview overview;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final address = ValueFormatter.formatAddress(
      address1: overview.address?.address1,
      city: overview.address?.city,
      state: overview.address?.state,
      postalCode: overview.address?.postalCode,
    );
    final date = ValueFormatter.formatListedDate(overview.listDate) ?? '';
    final rows = <Widget>[
      if (address.isNotEmpty)
        _ContactRow(icon: Icons.location_on, text: address),
      if ((overview.homepageUrl ?? '').isNotEmpty)
        _ContactRow(
          icon: Icons.language,
          text: overview.homepageUrl!,
          onTap: () {
            final uri = Uri.tryParse(overview.homepageUrl!);
            if (uri != null) {
              launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
        ),
      if (date.isNotEmpty) _ContactRow(icon: Icons.calendar_today, text: date),
      if ((overview.cik ?? '').isNotEmpty)
        _ContactRow(icon: Icons.info, text: '${l10n.cikLabel} ${overview.cik}'),
    ];

    if (rows.isEmpty) return const SizedBox.shrink();
    return Column(children: rows);
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.text, this.onTap});

  final IconData icon;
  final String text;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final content = Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 16),
          Expanded(
            child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
          ),
        ],
      ),
    );
    return onTap == null ? content : InkWell(onTap: onTap, child: content);
  }
}

class _ChartSection extends StatelessWidget {
  const _ChartSection({
    required this.state,
    required this.onRetry,
    required this.onPeriodSelected,
    required this.emptyMessage,
  });

  final StockDetailState state;
  final VoidCallback onRetry;
  final ValueChanged<Period> onPeriodSelected;
  final String emptyMessage;

  @override
  Widget build(BuildContext context) {
    final candles = state.candles;
    final chart = switch (candles) {
      SliceLoading() => const ShimmerBlock(
        key: AppKeys.loadingPlaceholder,
        height: 500,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      SliceError(:final failure) => SizedBox(
        height: candleChartHeight,
        child: ErrorView(
          message: FailureMessageResolver(
            AppLocalizations.of(context),
          ).resolve(failure),
          onRetry: onRetry,
        ),
      ),
      SliceData<List<Candle>>(:final value) when value.isEmpty => SizedBox(
        height: candleChartHeight,
        child: Center(
          child: Text(
            emptyMessage,
            key: AppKeys.emptyStateMessage,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      SliceData<List<Candle>>(:final value) => CandleChart(candles: value),
    };
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        chart,
        const SizedBox(height: 16),
        PeriodSelector(
          period: state.period,
          onPeriodSelected: onPeriodSelected,
        ),
      ],
    );
  }
}

class _DetailSkeleton extends StatelessWidget {
  const _DetailSkeleton();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      key: AppKeys.loadingPlaceholder,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          Row(
            children: [
              ShimmerBlock(
                width: 72,
                height: 72,
                borderRadius: BorderRadius.all(Radius.circular(36)),
              ),
              SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBlock(width: 150, height: 24),
                    SizedBox(height: 8),
                    ShimmerBlock(width: 80, height: 30),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24),
          ShimmerBlock(height: 120),
          SizedBox(height: 24),
          ShimmerBlock(height: 120),
          SizedBox(height: 24),
          ShimmerBlock(height: 180),
          SizedBox(height: 24),
          ShimmerBlock(height: 500),
        ],
      ),
    );
  }
}
