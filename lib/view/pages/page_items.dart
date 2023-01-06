import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/accessibility/accessibility_page.dart';
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
import 'package:settings/view/pages/users/users.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_page.dart';
import 'package:yaru_icons/yaru_icons.dart';

List<SettingsPageItem> getPageItems(BuildContext context) => [
      SettingsPageItem(
        titleBuilder: ConnectionsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.network),
        builder: ConnectionsPage.create,
        searchMatches: ConnectionsPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: BluetoothPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.bluetooth),
        builder: BluetoothPage.create,
        searchMatches: BluetoothPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: WallpaperPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.wallpaper),
        builder: WallpaperPage.create,
        searchMatches: WallpaperPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: AppearancePage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.panel_look),
        builder: AppearancePage.create,
        searchMatches: AppearancePage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: PrivacyPage.createTitle,
        builder: PrivacyPage.create,
        searchMatches: PrivacyPage.searchMatches,
        iconBuilder: (context, selected) => const Icon(YaruIcons.lock),
      ),
      SettingsPageItem(
        titleBuilder: MultiTaskingPage.createTitle,
        builder: MultiTaskingPage.create,
        iconBuilder: (context, selected) => const Icon(YaruIcons.windows),
        searchMatches: MultiTaskingPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: NotificationsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.bell),
        builder: NotificationsPage.create,
        searchMatches: NotificationsPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: SearchPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.search),
        builder: SearchPage.create,
        searchMatches: SearchPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: AppsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.app_grid),
        builder: AppsPage.create,
        searchMatches: AppsPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: OnlineAccountsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.cloud),
        builder: OnlineAccountsPage.create,
        searchMatches: OnlineAccountsPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: SoundPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.music_note),
        builder: SoundPage.create,
        searchMatches: SoundPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: PowerPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.power),
        builder: PowerPage.create,
        searchMatches: PowerPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: DisplaysPage.createTitle,
        iconBuilder: (context, selected) =>
            const Icon(YaruIcons.display_layout),
        builder: DisplaysPage.create,
        searchMatches: DisplaysPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: MouseAndTouchpadPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.mouse),
        builder: MouseAndTouchpadPage.create,
        searchMatches: MouseAndTouchpadPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: KeyboardPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.keyboard),
        builder: KeyboardPage.create,
        searchMatches: KeyboardPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: (context) => const Text('Printers'),
        iconBuilder: (context, selected) => const Icon(YaruIcons.printer),
        builder: (_) => const Center(child: Text('Printers')),
      ),
      SettingsPageItem(
        titleBuilder: RemovableMediaPage.createTitle,
        iconBuilder: (context, selected) =>
            const Icon(YaruIcons.drive_removable_media),
        builder: RemovableMediaPage.create,
        searchMatches: RemovableMediaPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: ColorPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.colors),
        builder: ColorPage.create,
        searchMatches: ColorPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: RegionAndLanguagePage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.localization),
        builder: RegionAndLanguagePage.create,
        searchMatches: RegionAndLanguagePage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: AccessibilityPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.human),
        builder: AccessibilityPage.create,
        searchMatches: AccessibilityPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: UsersPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.users),
        builder: UsersPage.create,
        searchMatches: UsersPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: DefaultAppsPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.star),
        builder: DefaultAppsPage.create,
        searchMatches: DefaultAppsPage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: DateTimePage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.clock),
        builder: DateTimePage.create,
        searchMatches: DateTimePage.searchMatches,
      ),
      SettingsPageItem(
        titleBuilder: InfoPage.createTitle,
        iconBuilder: (context, selected) => const Icon(YaruIcons.information),
        builder: InfoPage.create,
        searchMatches: InfoPage.searchMatches,
      ),
    ];
