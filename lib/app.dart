import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:gtk_window/gtk_window.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/page_items.dart';
import 'package:settings/view/pages/settings_page_item.dart';
import 'package:settings/view/search_app_bar.dart';
import 'package:yaru/yaru.dart';
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
  final _filteredItems = <SettingsPageItem>[];
  final _searchController = TextEditingController();
  late List<SettingsPageItem> pageItems = getPageItems(context);

  void _onEscape() => setState(() {
        _filteredItems.clear();
        _searchController.clear();
      });

  void _onSearchChanged(String value, BuildContext context) {
    setState(() {
      _filteredItems.clear();
      _filteredItems.addAll(
        pageItems.where((pageItem) {
          if (pageItem.searchMatches != null) {
            return pageItem.searchMatches!(value, context);
          }
          return false;
        }),
      );
    });
  }

  bool isExpanded = true;
  @override
  Widget build(BuildContext context) {
    return YaruTheme(
      builder: (context, yaru, child) {
        return MaterialApp(
          theme: yaru.theme,
          darkTheme: yaru.darkTheme,
          debugShowCheckedModeBanner: false,
          onGenerateTitle: (context) => context.l10n.appTitle,
          routes: {
            Navigator.defaultRouteName: (context) {
              final pages =
                  _filteredItems.isNotEmpty ? _filteredItems : pageItems;
              return YaruMasterDetailPage(
                layoutDelegate: const YaruMasterResizablePaneDelegate(
                  initialPaneWidth: 280,
                  minPaneWidth: 170,
                  minPageWidth: kYaruMasterDetailBreakpoint / 2,
                ),
                length: pages.length,
                tileBuilder: (context, index, selected) => YaruMasterTile(
                  title: pages[index].titleBuilder(context),
                  leading: pages[index].iconBuilder(context, selected),
                ),
                pageBuilder: (context, index) => YaruDetailPage(
                  body: pages[index].builder(context),
                  appBar: GTKHeaderBar(
                    middle: pages[index].titleBuilder(context),
                  ),
                ),
                appBar: GTKHeaderBar(
                  middleSpacing: 0,
                  padding: isExpanded
                      ? EdgeInsets.zero
                      : const EdgeInsets.symmetric(horizontal: 10),
                  middle: const Text('Settings'),
                  showWindowControlsButtons: !isExpanded,
                  onWindowResize: (size) {
                    if (size.width > kYaruMasterDetailBreakpoint) {
                      if (isExpanded == false) {
                        setState(() {
                          isExpanded = true;
                        });
                      }
                    } else if (isExpanded == true) {
                      setState(() {
                        isExpanded = false;
                      });
                    }
                  },
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(48),
                    child: SearchAppBar(
                      searchHint: context.l10n.searchHint,
                      clearSearchIconData: YaruIcons.window_close,
                      searchController: _searchController,
                      onChanged: (v) => _onSearchChanged(v, context),
                      onEscape: _onEscape,
                      appBarHeight: 48,
                      searchIconData: YaruIcons.search,
                    ),
                  ),
                ),
              );
            },
          },
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates +
              [const LocaleNamesLocalizationsDelegate()],
        );
      },
    );
  }
}
