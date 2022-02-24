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
import 'package:settings/view/pages/sound/sound_page.dart';
import 'package:settings/view/pages/users/users.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_page.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

List<YaruPageItem> getPageItems(BuildContext context) => [
      const YaruPageItem(
        titleBuilder: ConnectionsPage.createTitle,
        iconData: YaruIcons.network,
        builder: ConnectionsPage.create,
        searchMatches: ConnectionsPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: BluetoothPage.createTitle,
        iconData: YaruIcons.bluetooth,
        builder: BluetoothPage.create,
        searchMatches: BluetoothPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: WallpaperPage.createTitle,
        iconData: YaruIcons.desktop_wallpaper,
        builder: WallpaperPage.create,
        searchMatches: WallpaperPage.searchMatches,
      ),
      const YaruPageItem(
          titleBuilder: AppearancePage.createTitle,
          iconData: YaruIcons.desktop_panel_look,
          builder: AppearancePage.create,
          searchMatches: AppearancePage.searchMatches),
      const YaruPageItem(
        titleBuilder: PrivacyPage.createTitle,
        builder: PrivacyPage.create,
        searchMatches: PrivacyPage.searchMatches,
        iconData: YaruIcons.lock,
      ),
      const YaruPageItem(
        titleBuilder: MultiTaskingPage.createTitle,
        builder: MultiTaskingPage.create,
        iconData: YaruIcons.windows,
        searchMatches: MultiTaskingPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: NotificationsPage.createTitle,
        iconData: YaruIcons.notification,
        builder: NotificationsPage.create,
        searchMatches: NotificationsPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: SearchPage.createTitle,
        iconData: YaruIcons.search,
        builder: SearchPage.create,
        searchMatches: SearchPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: AppsPage.createTitle,
        iconData: YaruIcons.app_grid,
        builder: AppsPage.create,
        searchMatches: AppsPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: OnlineAccountsPage.createTitle,
        iconData: YaruIcons.desktop_online_accounts,
        builder: OnlineAccountsPage.create,
        searchMatches: OnlineAccountsPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: SoundPage.createTitle,
        iconData: YaruIcons.audio,
        builder: SoundPage.create,
        searchMatches: SoundPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: PowerPage.createTitle,
        iconData: YaruIcons.power,
        builder: PowerPage.create,
        searchMatches: PowerPage.searchMatches,
      ),
      YaruPageItem(
        titleBuilder: (context) => const Text('Displays'),
        iconData: YaruIcons.desktop_display,
        builder: (_) => const Center(child: Text('Displays')),
      ),
      const YaruPageItem(
        titleBuilder: MouseAndTouchpadPage.createTitle,
        iconData: YaruIcons.input_mouse,
        builder: MouseAndTouchpadPage.create,
        searchMatches: MouseAndTouchpadPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: KeyboardPage.createTitle,
        iconData: YaruIcons.input_keyboard,
        builder: KeyboardPage.create,
        searchMatches: KeyboardPage.searchMatches,
      ),
      YaruPageItem(
        titleBuilder: (context) => const Text('Printers'),
        iconData: YaruIcons.printer,
        builder: (_) => const Center(child: Text('Printers')),
      ),
      const YaruPageItem(
        titleBuilder: RemovableMediaPage.createTitle,
        iconData: YaruIcons.media_removable,
        builder: RemovableMediaPage.create,
        searchMatches: RemovableMediaPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: ColorPage.createTitle,
        iconData: YaruIcons.colors,
        builder: ColorPage.create,
        searchMatches: ColorPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: RegionAndLanguagePage.createTitle,
        iconData: YaruIcons.localization,
        builder: RegionAndLanguagePage.create,
        searchMatches: RegionAndLanguagePage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: AccessibilityPage.createTitle,
        iconData: YaruIcons.accessibility,
        builder: AccessibilityPage.create,
        searchMatches: AccessibilityPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: UsersPage.createTitle,
        iconData: YaruIcons.users,
        builder: UsersPage.create,
        searchMatches: UsersPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: DefaultAppsPage.createTitle,
        iconData: YaruIcons.star,
        builder: DefaultAppsPage.create,
        searchMatches: DefaultAppsPage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: DateTimePage.createTitle,
        iconData: YaruIcons.clock,
        builder: DateTimePage.create,
        searchMatches: DateTimePage.searchMatches,
      ),
      const YaruPageItem(
        titleBuilder: InfoPage.createTitle,
        iconData: YaruIcons.information,
        builder: InfoPage.create,
        searchMatches: InfoPage.searchMatches,
      ),
    ];
