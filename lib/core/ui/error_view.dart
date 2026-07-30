import 'package:flutter/material.dart';
import 'package:stocks_viewer_flutter/core/ui/app_keys.dart';
import 'package:stocks_viewer_flutter/l10n/generated/app_localizations.dart';

/// The Design_System widget rendering a full-surface error message with a
/// retry control (Requirement 4 AC 16, AC 17, AC 18, AC 20, AC 21, AC 23,
/// AC 24).
class ErrorView extends StatelessWidget {
  const ErrorView({required this.message, required this.onRetry, super.key});

  /// Already resolved by the Failure_Message_Resolver.
  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final l10n = AppLocalizations.of(context);

    return LayoutBuilder(
      key: AppKeys.errorView,
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 80,
                      color: colorScheme.error,
                      key: AppKeys.errorViewIcon,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.errorGenericHeadline,
                      textAlign: TextAlign.center,
                      style: textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                      key: AppKeys.errorViewHeadline,
                    ),
                    if (message.isNotEmpty) const SizedBox(height: 12),
                    if (message.isNotEmpty)
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        maxLines: null,
                        overflow: TextOverflow.clip,
                        style: textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        key: AppKeys.errorViewMessage,
                      ),
                    const SizedBox(height: 24),
                    FilledButton(
                      onPressed: onRetry,
                      key: AppKeys.errorViewRetryButton,
                      child: Text(l10n.retryButtonLabel),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
