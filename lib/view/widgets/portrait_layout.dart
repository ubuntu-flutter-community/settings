import 'package:flutter/material.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

import 'constants.dart';
import 'page_item.dart';

class PortraitLayout extends StatefulWidget {
  const PortraitLayout({
    Key? key,
    required this.index,
    required this.pages,
    required this.onSelected,
  }) : super(key: key);

  final int index;
  final List<PageItem> pages;
  final ValueChanged<int> onSelected;

  @override
  _PortraitLayoutState createState() => _PortraitLayoutState();
}

class _PortraitLayoutState extends State<PortraitLayout> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  MaterialPageRoute pageRoute(int index) {
    return MaterialPageRoute(
      builder: (context) {
        final page = widget.pages[index];
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: kAppBarHeight,
            title: Text('Portrait: ${page.title}'),
            leading: BackButton(
              onPressed: () {
                widget.onSelected(-1);
                _navigator.pop(context);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: page.builder(context),
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await _navigator.maybePop(),
      child: Navigator(
        key: _navigatorKey,
        onGenerateInitialRoutes: (navigator, initialRoute) {
          return [
            MaterialPageRoute(
              builder: (context) {
                return Scaffold(
                  floatingActionButton: FloatingActionButton(
                      child: const Icon(YaruIcons.search), onPressed: () {}),
                  floatingActionButtonLocation:
                      FloatingActionButtonLocation.startFloat,
                  appBar: AppBar(
                    toolbarHeight: kAppBarHeight,
                    title: const Text('Settings'),
                  ),
                  body: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView(
                      children: [
                        for (var i = 0; i < widget.pages.length; ++i)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              child: ListTile(
                                shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(4.0)),
                                ),
                                leading: Icon(widget.pages[i].iconData,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurface
                                        .withOpacity(0.8)),
                                title: Text(widget.pages[i].title),
                                onTap: () {
                                  _navigator.push(pageRoute(i));
                                  widget.onSelected(i);
                                },
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                );
              },
            ),
            if (widget.index != -1) pageRoute(widget.index)
          ];
        },
      ),
    );
  }
}
