import 'package:flutter/widgets.dart';

class SettingsPageItem {
  SettingsPageItem({
    required this.titleBuilder,
    required this.builder,
    required this.iconBuilder,
    this.searchMatches,
  });

  final WidgetBuilder titleBuilder;
  final WidgetBuilder builder;
  final Widget Function(BuildContext context, bool selected) iconBuilder;
  final bool Function(String value, BuildContext context)? searchMatches;
}
