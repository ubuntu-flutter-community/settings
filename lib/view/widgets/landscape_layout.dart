import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settings/view/pages/page_items.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

import 'constants.dart';
import 'page_item.dart';

class LandscapeLayout extends StatefulWidget {
  const LandscapeLayout({
    Key? key,
    required this.index,
    required this.pages,
    required this.onSelected,
  }) : super(key: key);

  final int index;
  final List<PageItem> pages;
  final ValueChanged<int> onSelected;

  @override
  State<LandscapeLayout> createState() => _LandscapeLayoutState();
}

class _LandscapeLayoutState extends State<LandscapeLayout> {
  late int _index;
  late ScrollController _contentScrollController;
  late TextEditingController _searchController;
  late bool _searchActive;
  final _filteredItems = <PageItem>[];

  @override
  void initState() {
    _index = widget.index;
    _contentScrollController = ScrollController();
    _searchController = TextEditingController();
    _searchActive = false;
    super.initState();
  }

  void landscapeOnTap(int index) {
    _searchActive = false;

    final tappedItem = _filteredItems[index];
    late int matchedIndex;
    for (var pageItem in widget.pages) {
      if (pageItem.title == tappedItem.title) {
        matchedIndex = widget.pages.indexOf(pageItem);
      }
    }

    widget.onSelected(matchedIndex);
    setState(() => _index = matchedIndex);
    _filteredItems.clear();
    _searchController.clear();
  }

  void filterItems(TextEditingController controller) {
    _filteredItems.clear();
    for (PageItem pageItem in widget.pages) {
      if (pageItem.title
          .toLowerCase()
          .contains(controller.value.text.toLowerCase())) {
        _filteredItems.add(pageItem);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    filterItems(_searchController);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: kAppBarHeight,
            child: Row(
              children: [
                SizedBox(
                  width: kLeftPaneWidth,
                  child: AppBar(
                    leading: _searchActive
                        ? null
                        : InkWell(
                            child: const Icon(YaruIcons.search),
                            onTap: () => {
                              setState(() {
                                _searchActive = true;
                              })
                            },
                          ),
                    title: _searchActive
                        ? RawKeyboardListener(
                            onKey: (event) {
                              if (event.logicalKey ==
                                  LogicalKeyboardKey.escape) {
                                setState(() {
                                  _searchActive = false;
                                  _searchController.clear();
                                  _filteredItems.clear();
                                });
                                return;
                              }
                            },
                            focusNode: FocusNode(),
                            child: SizedBox(
                              height: kAppBarHeight - 12,
                              child: TextField(
                                controller: _searchController,
                                autofocus: true,
                                onChanged: (value) {
                                  filterItems(_searchController);
                                  setState(() {});
                                },
                              ),
                            ),
                          )
                        : const Text('Settings',
                            style: TextStyle(fontWeight: FontWeight.w100)),
                  ),
                ),
                Expanded(
                  child: AppBar(
                    title: Text(widget.pages[_index].title,
                        style: const TextStyle(fontWeight: FontWeight.normal)),
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: kLeftPaneWidth,
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          width: 1,
                          color: Colors.black.withOpacity(0.1),
                        ),
                      ),
                    ),
                    child: PageItemListView(
                      index: _index,
                      onTap: landscapeOnTap,
                      pages: _filteredItems.isEmpty
                          ? widget.pages
                          : _filteredItems,
                    ),
                  ),
                ),
                Expanded(
                    child: SingleChildScrollView(
                  controller: _contentScrollController,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: widget.pages[_index].builder(context),
                    ),
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
