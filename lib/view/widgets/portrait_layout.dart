import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:settings/view/pages/page_items.dart';
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
  late int _index;
  late TextEditingController _searchController;
  final filteredItems = <PageItem>[];
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    _searchController = TextEditingController();
    _index = widget.index;
    super.initState();
  }

  void portraitOnTap(int index) {
    _navigator.push(pageRoute(index));
    widget.onSelected(index);
    setState(() => _index = index);
  }

  MaterialPageRoute pageRoute(int index) {
    return MaterialPageRoute(
      builder: (context) {
        final page = widget.pages[_index];
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: kAppBarHeight,
            title: Text(page.title,
                style: const TextStyle(fontWeight: FontWeight.normal)),
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
    filterItems(_searchController);
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
                    child: const Icon(YaruIcons.search),
                    onPressed: () => openSearchDialog(),
                  ),
                  appBar: AppBar(
                    toolbarHeight: kAppBarHeight,
                    title: const Text('Settings',
                        style: TextStyle(fontWeight: FontWeight.normal)),
                  ),
                  body: PageItemListView(
                    index: _index,
                    onTap: portraitOnTap,
                    pages: widget.pages,
                  ),
                );
              },
            ),
            if (_index != -1) pageRoute(_index)
          ];
        },
      ),
    );
  }

  void filterItems(TextEditingController controller) {
    filteredItems.clear();
    for (PageItem pageItem in widget.pages) {
      if (pageItem.title
          .toLowerCase()
          .contains(controller.value.text.toLowerCase())) {
        filteredItems.add(pageItem);
      }
    }
  }

  void portraitOnTapForDialog(int index) {
    final tappedItem = filteredItems[index];
    late int matchedIndex;
    for (var pageItem in widget.pages) {
      if (pageItem.title == tappedItem.title) {
        matchedIndex = widget.pages.indexOf(pageItem);
      }
    }

    Navigator.of(context).pop();
    portraitOnTap(matchedIndex);
  }

  void openSearchDialog() {
    filterItems(_searchController);
    showDialog(
        context: context,
        builder: (_) => StatefulBuilder(builder: (context, setState) {
              return SingleChildScrollView(
                child: AlertDialog(
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Close'))
                  ],
                  content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextField(
                          onChanged: (value) {
                            filterItems(_searchController);
                            setState(() {});
                          },
                          controller: _searchController,
                          autofocus: true,
                        ),
                        SizedBox(
                          width: 300,
                          height: MediaQuery.of(context).size.height / 2,
                          child: PageItemListView(
                              pages: filteredItems,
                              index: _index,
                              onTap: portraitOnTapForDialog),
                        ),
                      ]),
                ),
              );
            })).then((value) => setState(() {
          _searchController.clear();
        }));
  }
}
