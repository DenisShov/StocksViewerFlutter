import 'package:flutter/material.dart';
import 'package:stocks_viewer_flutter/core/ui/app_keys.dart';
import 'package:stocks_viewer_flutter/l10n/generated/app_localizations.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    required this.title,
    required this.searchActive,
    required this.controller,
    required this.focusNode,
    required this.onSearchOpen,
    required this.onSearchClose,
    required this.onSearchTextChanged,
    super.key,
  });

  final String title;
  final bool searchActive;
  final TextEditingController controller;
  final FocusNode focusNode;
  final VoidCallback onSearchOpen;
  final VoidCallback onSearchClose;
  final ValueChanged<String> onSearchTextChanged;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (!searchActive) {
      return AppBar(
        centerTitle: true,
        title: Text(title),
        actions: [
          IconButton(
            key: AppKeys.searchActionButton,
            icon: const Icon(Icons.search),
            tooltip: l10n.searchActionSemanticLabel,
            onPressed: onSearchOpen,
          ),
        ],
      );
    }

    return AppBar(
      leading: IconButton(
        key: AppKeys.closeSearchButton,
        icon: const Icon(Icons.arrow_back),
        tooltip: l10n.closeSearchSemanticLabel,
        onPressed: onSearchClose,
      ),
      title: TextField(
        key: AppKeys.searchField,
        controller: controller,
        focusNode: focusNode,
        maxLines: 1,
        maxLength: 100,
        onChanged: onSearchTextChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.transparent,
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          counterText: '',
          hintText: l10n.searchStocksHint,
        ),
      ),
    );
  }
}
