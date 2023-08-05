import 'package:flutter/widgets.dart';

class SettingsPageItem {
  SettingsPageItem({
    required this.titleBuilder,
    required this.builder,
    required this.iconBuilder,
    this.searchMatches,
    this.title,
  });

  final WidgetBuilder titleBuilder;
  final String? title;
  final WidgetBuilder builder;
  final Widget Function(BuildContext context, bool selected) iconBuilder;
  final bool Function(String value, BuildContext context)? searchMatches;
}
