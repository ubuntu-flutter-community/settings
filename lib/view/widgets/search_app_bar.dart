import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:settings/view/widgets/constants.dart';
import 'package:yaru_icons/widgets/yaru_icons.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SearchAppBar({
    Key? key,
    required this.searchController,
    required this.onChanged,
    required this.onEscape,
  }) : super(key: key);

  final TextEditingController searchController;
  final Function(String value) onChanged;
  final Function() onEscape;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      flexibleSpace: RawKeyboardListener(
        onKey: (event) {
          if (event.logicalKey == LogicalKeyboardKey.escape) {
            onEscape();
            return;
          }
        },
        focusNode: FocusNode(),
        child: TextField(
          textAlignVertical: TextAlignVertical.center,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w200),
          decoration: InputDecoration(
            prefixIcon: const Icon(YaruIcons.search),
            hintText: 'Search...',
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.black.withOpacity(0.01))),
            border: const UnderlineInputBorder(),
          ),
          controller: searchController,
          autofocus: true,
          onChanged: (value) => onChanged(value),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(0, kAppBarHeight);
}
