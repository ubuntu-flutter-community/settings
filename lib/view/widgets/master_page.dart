import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:settings/view/pages/menu_items.dart';
import 'package:settings/view/widgets/detail_page.dart';
import 'package:settings/view/widgets/detail_route.dart';
import 'package:settings/view/widgets/menu_item.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class MasterPage extends StatefulWidget {
  const MasterPage({Key? key}) : super(key: key);

  @override
  MasterPageState createState() => MasterPageState();
}

class MasterPageState extends State<MasterPage> {
  late MenuItem selectedMenuItem;

  @override
  void initState() {
    super.initState();
    selectedMenuItem = menuItems.first;
    // goToDetail(menuItems.indexOf(selectedMenuItem));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50.0),
        child: AppBar(
          title: const Text(
            'Settings',
            style: TextStyle(fontWeight: FontWeight.normal),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Search'),
                  content: TextField(
                    autofocus: true,
                  ),
                );
              })
        },
        child: Icon(YaruIcons.search),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndTop,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(color: Colors.black.withOpacity(0.1)),
            ),
          ),
          child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(
                    right: 8,
                    left: 8,
                    bottom: 8,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(4.0)),
                      color: menuItems[index] == selectedMenuItem
                          ? Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.07)
                          : null,
                    ),
                    child: ListTile(
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        ),
                        leading: Icon(
                          menuItems[index].iconData,
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.8),
                        ),
                        selected: menuItems[index] == selectedMenuItem,
                        title: Text(
                          menuItems[index].name,
                          style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: Theme.of(context).colorScheme.onSurface),
                        ),
                        onTap: () {
                          setState(() => goToDetail(index));
                        }),
                  ),
                );
              }),
        ),
      ),
    );
  }

  void goToDetail(int index) {
    selectedMenuItem = menuItems[index];
    while (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    Navigator.of(context).push(
      DetailRoute(
        builder: (context) => DetailPage(
          item: selectedMenuItem,
        ),
      ),
    );
  }
}
