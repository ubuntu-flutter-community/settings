import 'package:flutter/material.dart';
import 'package:settings/view/pages/page_items.dart';

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

  @override
  void initState() {
    _index = widget.index;
    _contentScrollController = ScrollController();
    super.initState();
  }

  void landscapeOnTap(int index) {
    widget.onSelected(index);
    setState(() => _index = index);
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
                  child: AppBar(
                      title: const Text('Settings',
                          style: TextStyle(fontWeight: FontWeight.normal))),
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
                      pages: widget.pages,
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
