import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/accessibility/accessibility_page.dart';
import 'package:settings/view/pages/appearance/appearance_page.dart';
import 'package:settings/view/pages/info/info_page.dart';
import 'package:settings/view/pages/keyboard_shortcuts/keyboard_shortcuts_page.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_page.dart';
import 'package:settings/view/pages/removable_media/removable_media_page.dart';
import 'package:settings/view/pages/notifications/notifications_page.dart';
import 'package:settings/view/pages/sound/sound_page.dart';
import 'package:settings/view/pages/wallpaper/wallpaper_page.dart';
import 'package:settings/view/widgets/page_item.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

final pageItems = <PageItem>[
  PageItem(
    title: 'WIFI',
    iconData: YaruIcons.network_wireless,
    builder: (_) => const Text('WIFI'),
  ),
  PageItem(
    title: 'Network',
    iconData: YaruIcons.network,
    builder: (_) => const Text('Network'),
  ),
  PageItem(
    title: 'Bluetooth',
    iconData: YaruIcons.bluetooth,
    builder: (_) => const Text('Bluetooth'),
  ),
  const PageItem(
    title: 'Wallpaper',
    iconData: YaruIcons.desktop_wallpaper,
    builder: WallpaperPage.create,
  ),
  const PageItem(
    title: 'Appearance',
    iconData: YaruIcons.desktop_panel_look,
    builder: AppearancePage.create,
  ),
  const PageItem(
    title: 'Notifications',
    iconData: YaruIcons.notification,
    builder: NotificationsPage.create,
  ),
  PageItem(
    title: 'Search',
    iconData: YaruIcons.search,
    builder: (_) => const Text('Search'),
  ),
  PageItem(
    title: 'Apps',
    iconData: YaruIcons.app_grid,
    builder: (_) => const Text('Apps'),
  ),
  PageItem(
    title: 'Security',
    iconData: YaruIcons.lock,
    builder: (_) => const Text('Security'),
  ),
  PageItem(
    title: 'Online Accounts',
    iconData: YaruIcons.desktop_online_accounts,
    builder: (_) => const Text('Online Accounts'),
  ),
  PageItem(
    title: 'Sharing',
    iconData: YaruIcons.share,
    builder: (_) => const Text('Sharing'),
  ),
  const PageItem(
    title: 'Sound',
    iconData: YaruIcons.audio,
    builder: SoundPage.create,
  ),
  PageItem(
    title: 'Energy',
    iconData: YaruIcons.power,
    builder: (_) => const Text('Energy'),
  ),
  PageItem(
    title: 'Displays',
    iconData: YaruIcons.desktop_display,
    builder: (_) => const Text('Displays'),
  ),
  const PageItem(
    title: 'Mouse and touchpad',
    iconData: YaruIcons.input_mouse,
    builder: MouseAndTouchpadPage.create,
  ),
  const PageItem(
    title: 'Keyboard shortcuts',
    iconData: YaruIcons.input_keyboard,
    builder: KeyboardShortcutsPage.create,
  ),
  PageItem(
    title: 'Printers',
    iconData: YaruIcons.printer,
    builder: (_) => const Text('Printers'),
  ),
  const PageItem(
    title: 'Removable Media',
    iconData: YaruIcons.media_removable,
    builder: RemovableMediaPage.create,
  ),
  PageItem(
    title: 'Color',
    iconData: YaruIcons.colors,
    builder: (_) => const Text('Color'),
  ),
  PageItem(
    title: 'Region and language',
    iconData: YaruIcons.localization,
    builder: (_) => const Text('Region and language'),
  ),
  const PageItem(
    title: 'Accessibility',
    iconData: YaruIcons.accessibility,
    builder: AccessibilityPage.create,
  ),
  PageItem(
    title: 'Users',
    iconData: YaruIcons.users,
    builder: (_) => const Text('Users'),
  ),
  PageItem(
    title: 'Preferred Apps',
    iconData: YaruIcons.star,
    builder: (_) => const Text('Preferred Apps'),
  ),
  PageItem(
    title: 'Date and time',
    iconData: YaruIcons.clock,
    builder: (_) => const Text('Date and time'),
  ),
  const PageItem(
    title: 'Info',
    iconData: YaruIcons.information,
    builder: InfoPage.create,
  ),
];
