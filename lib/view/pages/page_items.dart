import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/accessibility/accessibility_page.dart';
import 'package:settings/view/pages/appearance/appearance_page.dart';
import 'package:settings/view/pages/bluetooth/bluetooth_page.dart';
import 'package:settings/view/pages/connections/connections_page.dart';
import 'package:settings/view/pages/info/info_page.dart';
import 'package:settings/view/pages/keyboard/keyboard_page.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_page.dart';
import 'package:settings/view/pages/multitasking/multi_tasking_page.dart';
import 'package:settings/view/pages/notifications/notifications_page.dart';
import 'package:settings/view/pages/power/power_page.dart';
import 'package:settings/view/pages/removable_media/removable_media_page.dart';
import 'package:settings/view/pages/sound/sound_page.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_page.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

final pageItems = <YaruPageItem>[
  const YaruPageItem(
    title: 'Connections',
    iconData: YaruIcons.network,
    builder: ConnectionsPage.create,
  ),
  const YaruPageItem(
    title: 'Bluetooth',
    iconData: YaruIcons.bluetooth,
    builder: BluetoothPage.create,
  ),
  const YaruPageItem(
    title: 'Wallpaper',
    iconData: YaruIcons.desktop_wallpaper,
    builder: WallpaperPage.create,
  ),
  const YaruPageItem(
    title: 'Appearance',
    iconData: YaruIcons.desktop_panel_look,
    builder: AppearancePage.create,
  ),
  const YaruPageItem(
      title: 'Multi-tasking',
      builder: MultiTaskingPage.create,
      iconData: YaruIcons.windows),
  const YaruPageItem(
    title: 'Notifications',
    iconData: YaruIcons.notification,
    builder: NotificationsPage.create,
  ),
  YaruPageItem(
    title: 'Search',
    iconData: YaruIcons.search,
    builder: (_) => const Center(child: Text('Search')),
  ),
  YaruPageItem(
    title: 'Apps',
    iconData: YaruIcons.app_grid,
    builder: (_) => const Center(child: Text('Apps')),
  ),
  YaruPageItem(
    title: 'Security',
    iconData: YaruIcons.lock,
    builder: (_) => const Center(child: Text('Security')),
  ),
  YaruPageItem(
    title: 'Online Accounts',
    iconData: YaruIcons.desktop_online_accounts,
    builder: (_) => const Center(child: Text('Online Accounts')),
  ),
  YaruPageItem(
    title: 'Sharing',
    iconData: YaruIcons.share,
    builder: (_) => const Center(child: Text('Sharing')),
  ),
  const YaruPageItem(
    title: 'Sound',
    iconData: YaruIcons.audio,
    builder: SoundPage.create,
  ),
  const YaruPageItem(
    title: 'Power',
    iconData: YaruIcons.power,
    builder: PowerPage.create,
  ),
  YaruPageItem(
    title: 'Displays',
    iconData: YaruIcons.desktop_display,
    builder: (_) => const Center(child: Text('Displays')),
  ),
  const YaruPageItem(
    title: 'Mouse and touchpad',
    iconData: YaruIcons.input_mouse,
    builder: MouseAndTouchpadPage.create,
  ),
  const YaruPageItem(
    title: 'Keyboard',
    iconData: YaruIcons.input_keyboard,
    builder: KeyboardPage.create,
  ),
  YaruPageItem(
    title: 'Printers',
    iconData: YaruIcons.printer,
    builder: (_) => const Center(child: Text('Printers')),
  ),
  const YaruPageItem(
    title: 'Removable Media',
    iconData: YaruIcons.media_removable,
    builder: RemovableMediaPage.create,
  ),
  YaruPageItem(
    title: 'Color',
    iconData: YaruIcons.colors,
    builder: (_) => const Center(child: Text('Color')),
  ),
  YaruPageItem(
    title: 'Region and language',
    iconData: YaruIcons.localization,
    builder: (_) => const Center(child: Text('Region and language')),
  ),
  const YaruPageItem(
    title: 'Accessibility',
    iconData: YaruIcons.accessibility,
    builder: AccessibilityPage.create,
  ),
  YaruPageItem(
    title: 'Users',
    iconData: YaruIcons.users,
    builder: (_) => const Center(child: Text('Users')),
  ),
  YaruPageItem(
    title: 'Preferred Apps',
    iconData: YaruIcons.star,
    builder: (_) => const Center(child: Text('Preferred Apps')),
  ),
  YaruPageItem(
    title: 'Date and time',
    iconData: YaruIcons.clock,
    builder: (_) => const Center(child: Text('Date and time')),
  ),
  const YaruPageItem(
    title: 'Info',
    iconData: YaruIcons.information,
    builder: InfoPage.create,
  ),
];
