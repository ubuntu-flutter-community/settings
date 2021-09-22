import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:settings/view/pages/accessibility/accessibility_model.dart';
import 'package:settings/view/pages/accessibility/accessibility_page.dart';
import 'package:settings/view/pages/appearance/appearance_model.dart';
import 'package:settings/view/pages/appearance/appearance_page.dart';
import 'package:settings/view/pages/info/info_model.dart';
import 'package:settings/view/pages/info/info_page.dart';
import 'package:settings/view/pages/keyboard_shortcuts_page/keyboard_shortcuts_page.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_model.dart';
import 'package:settings/view/pages/mouse_and_touchpad/mouse_and_touchpad_page.dart';
import 'package:settings/view/pages/notifications_page.dart/notifications_model.dart';
import 'package:settings/view/pages/notifications_page.dart/notifications_page.dart';
import 'package:settings/view/pages/sound/sound_model.dart';
import 'package:settings/view/pages/sound/sound_page.dart';
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
  PageItem(
    title: 'Wallpaper',
    iconData: YaruIcons.desktop_wallpaper,
    builder: (_) => const Text('Wallpaper'),
  ),
  PageItem(
    title: 'Appearance',
    iconData: YaruIcons.desktop_panel_look,
    builder: (_) => ChangeNotifierProvider<AppearanceModel>(
      create: (_) => AppearanceModel(),
      child: const AppearancePage(),
    ),
  ),
  PageItem(
    title: 'Notifications',
    iconData: YaruIcons.notification,
    builder: (_) => ChangeNotifierProvider<NotificationsModel>(
      create: (_) => NotificationsModel(),
      child: const NotificationsPage(),
    ),
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
  PageItem(
    title: 'Sound',
    iconData: YaruIcons.audio,
    builder: (_) => ChangeNotifierProvider<SoundModel>(
      create: (_) => SoundModel(),
      child: const SoundPage(),
    ),
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
  PageItem(
    title: 'Mouse and touchpad',
    iconData: YaruIcons.input_mouse,
    builder: (_) => ChangeNotifierProvider<MouseAndTouchpadModel>(
      create: (_) => MouseAndTouchpadModel(),
      child: const MouseAndTouchpadPage(),
    ),
  ),
  PageItem(
    title: 'Keyboard shortcuts',
    iconData: YaruIcons.input_keyboard,
    builder: (_) => const KeyboardShortcutsPage(),
  ),
  PageItem(
    title: 'Printers',
    iconData: YaruIcons.printer,
    builder: (_) => const Text('Printers'),
  ),
  PageItem(
    title: 'Shared devices',
    iconData: YaruIcons.media_removable,
    builder: (_) => const Text('Shared devices'),
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
  PageItem(
    title: 'Accessibility',
    iconData: YaruIcons.accessibility,
    builder: (_) => ChangeNotifierProvider<AccessibilityModel>(
      create: (_) => AccessibilityModel(),
      child: const AccessibilityPage(),
    ),
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
  PageItem(
      title: 'Info',
      iconData: YaruIcons.information,
      builder: (_) => ChangeNotifierProvider<InfoModel>(
            create: (_) => InfoModel(),
            child: const InfoPage(),
          )),
];
