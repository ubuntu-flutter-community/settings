import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/appearance/appearance_page.dart';
import 'package:settings/view/pages/info/info_page.dart';
import 'package:settings/view/pages/keyboard_shortcuts_page/keyboard_shortcuts_page.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_page.dart';
import 'package:settings/view/pages/notifications_page.dart/notifications_page.dart';
import 'package:settings/view/pages/sound/sound_page.dart';
import 'package:settings/view/widgets/menu_item.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

final menuItems = <MenuItem>[
  const MenuItem(
      name: 'WIFI',
      iconData: YaruIcons.network_wireless,
      details: Text('WIFI')),
  const MenuItem(
      name: 'Network', iconData: YaruIcons.network, details: Text('Network')),
  const MenuItem(
      name: 'Bluetooth',
      iconData: YaruIcons.bluetooth,
      details: Text('Bluetooth')),
  const MenuItem(
      name: 'Wallpaper',
      iconData: YaruIcons.desktop_wallpaper,
      details: Text('Wallpaper')),
  const MenuItem(
      name: 'Appearance',
      iconData: YaruIcons.desktop_panel_look,
      details: AppearancePage()),
  const MenuItem(
      name: 'Notifications',
      iconData: YaruIcons.notification,
      details: NotificationsPage()),
  const MenuItem(
      name: 'Search', iconData: YaruIcons.search, details: Text('Search')),
  const MenuItem(
      name: 'Apps', iconData: YaruIcons.app_grid, details: Text('Apps')),
  const MenuItem(
      name: 'Security', iconData: YaruIcons.lock, details: Text('Security')),
  const MenuItem(
      name: 'Online Accounts',
      iconData: YaruIcons.desktop_online_accounts,
      details: Text('Online Accounts')),
  const MenuItem(
      name: 'Sharing', iconData: YaruIcons.share, details: Text('Sharing')),
  const MenuItem(
      name: 'Sound', iconData: YaruIcons.audio, details: SoundPage()),
  const MenuItem(
      name: 'Energy', iconData: YaruIcons.power, details: Text('Energy')),
  const MenuItem(
      name: 'Displays',
      iconData: YaruIcons.desktop_display,
      details: Text('Displays')),
  const MenuItem(
      name: 'Mouse and touchpad',
      iconData: YaruIcons.input_mouse,
      details: MouseAndTouchpadPage()),
  const MenuItem(
      name: 'Keyboard shortcuts',
      iconData: YaruIcons.input_keyboard,
      details: KeyboardShortcutsPage()),
  const MenuItem(
      name: 'Printers', iconData: YaruIcons.printer, details: Text('Printers')),
  const MenuItem(
      name: 'Shared devices',
      iconData: YaruIcons.media_removable,
      details: Text('Shared devices')),
  const MenuItem(
      name: 'Color', iconData: YaruIcons.colors, details: Text('Color')),
  const MenuItem(
      name: 'Region and language',
      iconData: YaruIcons.localization,
      details: Text('Region and language')),
  const MenuItem(
      name: 'Accessability',
      iconData: YaruIcons.accessibility,
      details: Text('Accessability')),
  const MenuItem(
      name: 'Users', iconData: YaruIcons.users, details: Text('Users')),
  const MenuItem(
      name: 'Preferred Apps',
      iconData: YaruIcons.star,
      details: Text('Preferred Apps')),
  const MenuItem(
      name: 'Date and time',
      iconData: YaruIcons.clock,
      details: Text('Date and time')),
  const MenuItem(
      name: 'Info', iconData: YaruIcons.information, details: InfoPage()),
];
