import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/app_theme.dart';
import 'package:settings/view/pages/page_items.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class UbuntuSettingsApp extends StatefulWidget {
  const UbuntuSettingsApp({
    Key? key,
  }) : super(key: key);

  @override
  State<UbuntuSettingsApp> createState() => _UbuntuSettingsAppState();
}

class _UbuntuSettingsAppState extends State<UbuntuSettingsApp> {
  final _filteredItems = <YaruPageItem>[];
  final _searchController = TextEditingController();
  late List<YaruPageItem> pageItems = getPageItems(context);

  void _onEscape() => setState(() {
        _filteredItems.clear();
        _searchController.clear();
      });

  void _onSearchChanged(String value, BuildContext context) {
    setState(() {
      _filteredItems.clear();
      _filteredItems.addAll(pageItems.where((pageItem) {
        if (pageItem.searchMatches != null) {
          return pageItem.searchMatches!(value, context);
        }
        return false;
      }));
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => context.l10n.appTitle,
      routes: {
        Navigator.defaultRouteName: (context) {
          return YaruMasterDetailPage(
            leftPaneWidth: 280,
            pageItems: _filteredItems.isNotEmpty ? _filteredItems : pageItems,
            previousIconData: YaruIcons.go_previous,
            searchHint: context.l10n.searchHint,
            searchIconData: YaruIcons.search,
            appBar: YaruSearchAppBar(
              searchHint: context.l10n.searchHint,
              clearSearchIconData: YaruIcons.window_close,
              searchController: _searchController,
              onChanged: (v) => _onSearchChanged(v, context),
              onEscape: _onEscape,
              appBarHeight: 48,
              searchIconData: YaruIcons.search,
            ),
          );
        },
      },
      theme: context.watch<LightTheme>().value,
      darkTheme: context.watch<DarkTheme>().value,
      themeMode: context.watch<AppTheme>().value,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
    );
  }
}
