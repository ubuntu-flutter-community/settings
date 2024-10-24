import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/accessibility/accessibility_page.dart';
import 'package:settings/view/pages/accounts/accounts_page.dart';
import 'package:settings/view/pages/appearance/appearance_page.dart';
import 'package:settings/view/pages/apps/apps_page.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_page.dart';
import 'package:settings/view/pages/color/color_page.dart';
import 'package:settings/view/pages/connections/connections_page.dart';
import 'package:settings/view/pages/date_and_time/date_time_page.dart';
import 'package:settings/view/pages/default_apps/default_apps_page.dart';
import 'package:settings/view/pages/displays/displays_page.dart';
import 'package:settings/view/pages/info/info_page.dart';
import 'package:settings/view/pages/keyboard/keyboard_page.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_page.dart';
import 'package:settings/view/pages/multitasking/multi_tasking_page.dart';
import 'package:settings/view/pages/notifications/notifications_page.dart';
import 'package:settings/view/pages/online_accounts/online_accounts_page.dart';
import 'package:settings/view/pages/power/power_page.dart';
import 'package:settings/view/pages/privacy/privacy_page.dart';
import 'package:settings/view/pages/region_and_language/region_and_language_page.dart';
import 'package:settings/view/pages/removable_media/removable_media_page.dart';
import 'package:settings/view/pages/search/search_page.dart';
import 'package:settings/view/pages/settings_page_item.dart';
import 'package:settings/view/pages/sound/sound_page.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_page.dart';
import 'package:yaru/yaru.dart';

List<SettingsPageItem> getPageItems(BuildContext context) => [
      SettingsPageItem(
        titleBuilder: ConnectionsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.network),
        builder: ConnectionsPage.create,
        searchMatches: ConnectionsPage.searchMatches,
        title: context.l10n.connectionsPageTitle,
        hasAppBar: false,
      ),
      SettingsPageItem(
        titleBuilder: BluetoothPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.bluetooth),
        builder: BluetoothPage.create,
        searchMatches: BluetoothPage.searchMatches,
        title: context.l10n.bluetoothPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: WallpaperPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.wallpaper),
        builder: WallpaperPage.create,
        searchMatches: WallpaperPage.searchMatches,
        title: context.l10n.wallpaperPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: AppearancePage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.panel_look),
        builder: AppearancePage.create,
        searchMatches: AppearancePage.searchMatches,
        title: context.l10n.appearancePageTitle,
      ),
      SettingsPageItem(
        titleBuilder: PrivacyPage.createTitle,
        builder: PrivacyPage.create,
        searchMatches: PrivacyPage.searchMatches,
        iconBuilder: (context, selected) => const Icon(YaruIcons.lock),
        title: context.l10n.privacyPageTitle,
        hasAppBar: false,
      ),
      SettingsPageItem(
        titleBuilder: MultiTaskingPage.createTitle,
        builder: MultiTaskingPage.create,
        iconBuilder: (context, selected) => const Icon(YaruIcons.windows),
        searchMatches: MultiTaskingPage.searchMatches,
        title: context.l10n.multiTaskingPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: NotificationsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.bell),
        builder: NotificationsPage.create,
        searchMatches: NotificationsPage.searchMatches,
        title: context.l10n.notificationsPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: SearchPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.search),
        builder: SearchPage.create,
        searchMatches: SearchPage.searchMatches,
        title: context.l10n.searchPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: AppsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.app_grid),
        builder: AppsPage.create,
        searchMatches: AppsPage.searchMatches,
        title: context.l10n.appsPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: OnlineAccountsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.cloud),
        builder: OnlineAccountsPage.create,
        searchMatches: OnlineAccountsPage.searchMatches,
        title: context.l10n.onlineAccountsPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: SoundPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.music_note),
        builder: SoundPage.create,
        searchMatches: SoundPage.searchMatches,
        title: context.l10n.soundPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: PowerPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.power),
        builder: PowerPage.create,
        searchMatches: PowerPage.searchMatches,
        title: context.l10n.powerPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: DisplaysPage.createTitle,
        iconBuilder: (context, selected) =>
            const Icon(YaruIcons.display_layout),
        builder: DisplaysPage.create,
        searchMatches: DisplaysPage.searchMatches,
        title: context.l10n.displaysPageTitle,
        hasAppBar: false,
      ),
      SettingsPageItem(
        titleBuilder: MouseAndTouchpadPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.mouse),
        builder: MouseAndTouchpadPage.create,
        searchMatches: MouseAndTouchpadPage.searchMatches,
        title: context.l10n.mouseAndTouchPadPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: KeyboardPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.keyboard),
        builder: KeyboardPage.create,
        searchMatches: KeyboardPage.searchMatches,
        title: context.l10n.keyboardPageTitle,
        hasAppBar: false,
      ),
      SettingsPageItem(
        titleBuilder: (context) => const Text('Printers'),
        iconBuilder: (context, selected) => const Icon(YaruIcons.printer),
        builder: (_) => const Center(child: Text('Printers')),
        title: context.l10n.printersPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: RemovableMediaPage.createTitle,
        iconBuilder: (context, selected) =>
            const Icon(YaruIcons.drive_removable_media),
        builder: RemovableMediaPage.create,
        searchMatches: RemovableMediaPage.searchMatches,
        title: context.l10n.removableMediaPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: ColorPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.colors),
        builder: ColorPage.create,
        searchMatches: ColorPage.searchMatches,
        title: 'Colors', //TODO: localize
      ),
      SettingsPageItem(
        titleBuilder: RegionAndLanguagePage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.localization),
        builder: RegionAndLanguagePage.create,
        searchMatches: RegionAndLanguagePage.searchMatches,
        title: context.l10n.regionAndLanguagePageTitle,
      ),
      SettingsPageItem(
        titleBuilder: AccessibilityPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.human),
        builder: AccessibilityPage.create,
        searchMatches: AccessibilityPage.searchMatches,
        title: context.l10n.accessibilityPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: AccountsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.users),
        builder: AccountsPage.create,
        searchMatches: AccountsPage.searchMatches,
        title: context.l10n.usersPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: DefaultAppsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.star),
        builder: DefaultAppsPage.create,
        searchMatches: DefaultAppsPage.searchMatches,
        title: context.l10n.defaultAppsPageTitle,
      ),
      SettingsPageItem(
        titleBuilder: DateTimePage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.clock),
        builder: DateTimePage.create,
        searchMatches: DateTimePage.searchMatches,
        title: context.l10n.dateAndTimePageTitle,
      ),
      SettingsPageItem(
        titleBuilder: InfoPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.information),
        builder: InfoPage.create,
        searchMatches: InfoPage.searchMatches,
        title: context.l10n.infoPageTitle,
      ),
    ];
