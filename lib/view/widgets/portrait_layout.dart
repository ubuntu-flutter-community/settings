import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:settings/view/pages/page_items.dart';
import 'package:settings/view/widgets/search_app_bar.dart';

import 'constants.dart';
import 'page_item.dart';

class PortraitLayout extends StatefulWidget {
  const PortraitLayout({
    Key? key,
    required this.selectedIndex,
    required this.pages,
    required this.onSelected,
  }) : super(key: key);

  final int selectedIndex;
  final List<PageItem> pages;
  final ValueChanged<int> onSelected;

  @override
  _PortraitLayoutState createState() => _PortraitLayoutState();
}

class _PortraitLayoutState extends State<PortraitLayout> {
  late int _selectedIndex;
  late TextEditingController _searchController;
  final _filteredItems = <PageItem>[];
  late bool _searchActive;
  final _navigatorKey = GlobalKey<NavigatorState>();
  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  void initState() {
    _searchActive = false;
    _searchController = TextEditingController();
    _selectedIndex = widget.selectedIndex;
    super.initState();
  }

  void onTap(int indexOfTappedTile) {
    _searchActive = false;
    final tappedItem = _filteredItems[indexOfTappedTile];
    late int indexInAllPages;
    for (var pageItem in widget.pages) {
      if (pageItem.title == tappedItem.title) {
        indexInAllPages = widget.pages.indexOf(pageItem);
      }
    }
    _navigator.push(pageRoute(indexInAllPages));
    widget.onSelected(indexInAllPages);
    _filteredItems.clear();
    _searchController.clear();
    setState(() => _selectedIndex = indexInAllPages);
  }

  MaterialPageRoute pageRoute(int index) {
    return MaterialPageRoute(
      builder: (context) {
        final page = widget.pages[_selectedIndex];
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
                  appBar: addSearchBar(),
                  body: PageItemListView(
                    selectedIndex: _selectedIndex,
                    onTap: onTap,
                    pages:
                        _filteredItems.isEmpty ? widget.pages : _filteredItems,
                  ),
                );
              },
            ),
            if (_selectedIndex != -1) pageRoute(_selectedIndex)
          ];
        },
      ),
    );
  }

  SearchAppBar addSearchBar() {
    return SearchAppBar(
        searchController: _searchController,
        onChanged: (value) {
          setState(() {
            filterItems(_searchController);
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
          });
        });
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
}
