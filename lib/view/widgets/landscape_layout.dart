import 'package:flutter/material.dart';
import 'package:settings/view/widgets/page_item_list_view.dart';
import 'package:settings/view/widgets/search_app_bar.dart';

import 'constants.dart';
import 'page_item.dart';

class LandscapeLayout extends StatefulWidget {
  const LandscapeLayout({
    Key? key,
    required this.selectedIndex,
    required this.pages,
    required this.onSelected,
  }) : super(key: key);

  final int selectedIndex;
  final List<PageItem> pages;
  final ValueChanged<int> onSelected;

  @override
  State<LandscapeLayout> createState() => _LandscapeLayoutState();
}

class _LandscapeLayoutState extends State<LandscapeLayout> {
  late int _selectedIndex;
  late ScrollController _contentScrollController;
  late TextEditingController _searchController;
  late bool _searchActive;
  final _filteredItems = <PageItem>[];

  @override
  void initState() {
    _selectedIndex = widget.selectedIndex;
    _contentScrollController = ScrollController();
    _searchController = TextEditingController();
    _searchActive = false;
    super.initState();
  }

  void onTap(int index) {
    _searchActive = false;
    if (_filteredItems.isNotEmpty) {
      for (var pageItem in widget.pages) {
        if (pageItem.title == _filteredItems[index].title) {
          index = widget.pages.indexOf(pageItem);
          break;
        }
      }
      _filteredItems.clear();
    }

    widget.onSelected(index);
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: kAppBarHeight,
            child: Row(
              children: [
                SizedBox(
                  width: kLeftPaneWidth,
                  child: addSearchBar(),
                ),
                Expanded(
                  child: AppBar(
                    title: Text(widget.pages[_selectedIndex].title,
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
                      selectedIndex: _selectedIndex,
                      onTap: onTap,
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
                      child: widget.pages[_selectedIndex].builder(context),
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

  SearchAppBar addSearchBar() {
    return SearchAppBar(
        searchController: _searchController,
        onChanged: (value) {
          setState(() {
            _filteredItems.clear();
            for (PageItem pageItem in widget.pages) {
              if (pageItem.title
                  .toLowerCase()
                  .contains(_searchController.value.text.toLowerCase())) {
                _filteredItems.add(pageItem);
              }
            }
          });
        },
        searchActive: _searchActive,
        onEscape: () => setState(() {
              _searchActive = false;
              _searchController.clear();
              _filteredItems.clear();
            }),
        onTap: () {
          setState(() {
            _searchActive = true;
            _searchController.clear();
          });
        });
  }
}
