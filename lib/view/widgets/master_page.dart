import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/widgets/detail_page.dart';
import 'package:settings/view/widgets/detail_route.dart';
import 'package:settings/view/widgets/menu_item.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  MasterPageState createState() => MasterPageState();
}

class MasterPageState extends State<MasterPage> {
  final menuItems = <MenuItem>[
    const MenuItem(name: 'WIFI', iconData: Icons.wifi, details: Text('WIFI')),
    const MenuItem(
        name: 'Network',
        iconData: Icons.settings_ethernet,
        details: Text('Network')),
    const MenuItem(
        name: 'Bluetooth',
        iconData: Icons.bluetooth,
        details: Text('Bluetooth')),
    const MenuItem(
        name: 'Wallpaper',
        iconData: Icons.wallpaper,
        details: Text('Wallpaper')),
    const MenuItem(
        name: 'Appearance',
        iconData: Icons.theater_comedy,
        details: Text('Appearance')),
    const MenuItem(
        name: 'Notifications',
        iconData: Icons.notifications,
        details: Text('Notifications')),
    const MenuItem(
        name: 'Search', iconData: Icons.search, details: Text('Search')),
    const MenuItem(name: 'Apps', iconData: Icons.apps, details: Text('Apps')),
    const MenuItem(
        name: 'Security', iconData: Icons.lock, details: Text('Security')),
    const MenuItem(
        name: 'Online Accounts',
        iconData: Icons.cloud,
        details: Text('Online Accounts')),
    const MenuItem(
        name: 'Sharing', iconData: Icons.share, details: Text('Sharing')),
    const MenuItem(
        name: 'Sound', iconData: Icons.music_note, details: Text('Sound')),
    const MenuItem(
        name: 'Energy', iconData: Icons.power, details: Text('Energy')),
    const MenuItem(
        name: 'Displays', iconData: Icons.monitor, details: Text('Displays')),
    const MenuItem(
        name: 'Mouse and touchpad',
        iconData: Icons.mouse,
        details: Text('Mouse and touchpad')),
    const MenuItem(
        name: 'Keyboard shortcuts',
        iconData: Icons.keyboard,
        details: Text('Keyboard shortcuts')),
    const MenuItem(
        name: 'Printers', iconData: Icons.print, details: Text('Printers')),
    const MenuItem(
        name: 'Shared devices',
        iconData: Icons.usb,
        details: Text('Shared devices')),
    const MenuItem(
        name: 'Color',
        iconData: Icons.settings_display,
        details: Text('Color')),
    const MenuItem(
        name: 'Region and language',
        iconData: Icons.language,
        details: Text('Region and language')),
    const MenuItem(
        name: 'Accessability',
        iconData: Icons.settings_accessibility,
        details: Text('Accessability')),
    const MenuItem(
        name: 'Users',
        iconData: Icons.supervisor_account,
        details: Text('Users')),
    const MenuItem(
        name: 'Preferred Apps',
        iconData: Icons.star,
        details: Text('Preferred Apps')),
    const MenuItem(
        name: 'Date and time',
        iconData: Icons.access_time,
        details: Text('Date and time')),
    const MenuItem(name: 'Info', iconData: Icons.info, details: Text('Info')),
  ];

  late MenuItem selectedMenuItem;

  @override
  void initState() {
    selectedMenuItem = menuItems.first;
    super.initState();
    // goToDetail(menuItems.indexOf(selectedMenuItem));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 1,
          leading: const Icon(Icons.search),
          title: const Text('Settings'),
        ),
        body: Center(
          child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return ListTile(
                    leading: Icon(menuItems[index].iconData),
                    selected: menuItems[index] == selectedMenuItem,
                    title: Text(menuItems[index].name),
                    onTap: () {
                      setState(() => goToDetail(index));
                    });
              }),
        ));
  }

  void goToDetail(int index) {
    selectedMenuItem = menuItems[index];
    while (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    Navigator.of(context).push(DetailRoute(
        builder: (context) => DetailPage(
              item: selectedMenuItem,
            )));
  }
}
