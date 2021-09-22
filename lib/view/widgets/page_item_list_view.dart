import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:settings/view/widgets/page_item.dart';

class PageItemListView extends StatelessWidget {
  PageItemListView(
      {Key? key,
      required this.pages,
      required this.selectedIndex,
      required this.onTap})
      : super(key: key);

  final List<PageItem> pages;
  final int selectedIndex;
  final Function(int index) onTap;
  final ItemScrollController scrollController = ItemScrollController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ScrollablePositionedList.builder(
          itemScrollController: scrollController,
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                  color: index == selectedIndex
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
                  leading: Icon(pages[index].iconData,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8)),
                  title: Text(pages[index].title,
                      style: TextStyle(
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.onSurface)),
                  selected: index == selectedIndex,
                  onTap: () {
                    onTap(index);
                    scrollController.jumpTo(index: selectedIndex);
                  },
                ),
              ),
            );
          }),
    );
  }
}
