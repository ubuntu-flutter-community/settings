import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:provider/provider.dart';
import 'package:settings/app_model.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/schemas/schemas.dart';
import 'package:settings/services/settings_service.dart';
import 'package:settings/view/app_theme.dart';
import 'package:settings/view/pages/page_items.dart';
import 'package:yaru/yaru.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class UbuntuSettingsApp extends StatelessWidget {
  const UbuntuSettingsApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppTheme(Settings(schemaInterface)),
      child: YaruTheme(
        builder: (context, yaru, child) {
          return MaterialApp(
            theme: yaru.theme,
            darkTheme: yaru.darkTheme,
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => context.l10n.appTitle,
            home: App.create(context),
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates +
                [const LocaleNamesLocalizationsDelegate()],
          );
        },
      ),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  static Widget create(BuildContext context) => ChangeNotifierProvider(
        create: (_) {
          return AppModel();
        },
        child: const App(),
      );

  @override
  Widget build(BuildContext context) {
    final model = context.read<AppModel>();

    final searchQuery = context.select<AppModel, String?>((m) => m.searchQuery);
    final searchActive =
        context.select<AppModel, bool?>((value) => value.searchActive);

    final items = searchQuery?.isNotEmpty == true
        ? getPageItems(context)
            .where(
              (e) => e.title == null
                  ? false
                  : e.title!.toLowerCase().contains(searchQuery!.toLowerCase()),
            )
            .toList()
        : getPageItems(context);

    return YaruMasterDetailPage(
      layoutDelegate: const YaruMasterFixedPaneDelegate(
        paneWidth: 270,
      ),
      length: items.length,
      tileBuilder: (context, index, selected, availableWidth) => IconTheme(
        data: Theme.of(context).iconTheme.copyWith(size: 21),
        child: YaruMasterTile(
          title: items[index].titleBuilder(context),
          leading: items[index].iconBuilder(context, selected),
        ),
      ),
      pageBuilder: (context, index) => YaruDetailPage(
        body: items[index].builder(context),
        appBar: items[index].hasAppBar == false
            ? null
            : YaruWindowTitleBar(
                border: BorderSide.none,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                title: items[index].titleBuilder(context),
                leading: Navigator.of(context).canPop()
                    ? const YaruBackButton()
                    : null,
              ),
      ),
      appBar: YaruWindowTitleBar(
        border: BorderSide.none,
        backgroundColor: YaruMasterDetailTheme.of(context).sideBarColor,
        titleSpacing: 0,
        leading: YaruSearchButton(
          onPressed: () => model.setSearchActive(!(searchActive ?? false)),
        ),
        title: searchActive == true
            ? _SearchField(
                searchQuery: searchQuery,
                setSearchQuery: model.setSearchQuery,
              )
            : Text(
                context.l10n.appTitle,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.searchQuery,
    required this.setSearchQuery,
  });

  final String? searchQuery;
  final Function(String? value) setSearchQuery;

  @override
  Widget build(BuildContext context) {
    return YaruAutocomplete(
      fieldViewBuilder: (
        context,
        textEditingController,
        f,
        onFieldSubmitted,
      ) =>
          SizedBox(
        width: 200,
        child: YaruSearchField(
          text: searchQuery,
          radius: const Radius.circular(6),
          autofocus: true,
          controller: textEditingController,
          focusNode: f,
          onSubmitted: (_) => onFieldSubmitted(),
          onClear: () => setSearchQuery(''),
        ),
      ),
      optionsBuilder: (textEditingValue) {
        return getPageItems(context).where(
          (element) => element.searchMatches == null
              ? false
              : element.searchMatches!(textEditingValue.text, context),
        );
      },
      displayStringForOption: (option) => option.title ?? '',
      onSelected: (option) => setSearchQuery(option.title),
      initialValue: TextEditingValue(text: searchQuery ?? ''),
    );
  }
}
