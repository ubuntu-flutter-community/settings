import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settings/view/widgets/constants.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar(
      {Key? key,
      required this.searchController,
      required this.onChanged,
      required this.searchActive,
      required this.onEscape,
      required this.onTap})
      : super(key: key);

  final TextEditingController searchController;
  final Function(String value) onChanged;
  final Function() onEscape;
  final Function() onTap;
  final bool searchActive;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: searchActive
          ? null
          : InkWell(child: const Icon(YaruIcons.search), onTap: () => onTap()),
      title: searchActive
          ? RawKeyboardListener(
              onKey: (event) {
                if (event.logicalKey == LogicalKeyboardKey.escape) {
                  onEscape();
                  return;
                }
              },
              focusNode: FocusNode(),
              child: SizedBox(
                height: kAppBarHeight - 12,
                child: TextField(
                  controller: searchController,
                  autofocus: true,
                  onChanged: (value) => onChanged(value),
                ),
              ),
            )
          : const Text('Settings',
              style: TextStyle(fontWeight: FontWeight.normal)),
    );
  }

  @override
  Size get preferredSize => const Size(0, kAppBarHeight);
}
