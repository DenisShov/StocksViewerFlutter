import 'package:flutter/material.dart';
import 'package:stocks_viewer_flutter/core/ui/app_keys.dart';
import 'package:stocks_viewer_flutter/l10n/generated/app_localizations.dart';

class PagingRetryRow extends StatelessWidget {
  const PagingRetryRow({
    required this.message,
    required this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return SizedBox(
      key: AppKeys.pagingRetryRow,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                message,
                key: AppKeys.pagingRetryRowMessage,
                style: textTheme.titleMedium?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.error,
                ),
              ),
            ),
            FilledButton(
              key: AppKeys.pagingRetryButton,
              onPressed: onRetry,
              child: Text(
                l10n.retryButtonLabel,
                style: textTheme.labelLarge?.copyWith(
                  color: const Color(0xFFFFFFFF),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
