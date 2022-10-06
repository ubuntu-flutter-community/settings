import 'package:flutter/widgets.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class SettingsPageItem extends YaruPageItem {
  SettingsPageItem({
    required WidgetBuilder titleBuilder,
    required WidgetBuilder builder,
    required Widget Function(BuildContext context, bool selected) iconBuilder,
    this.searchMatches,
  }) : super(
          titleBuilder: titleBuilder,
          builder: builder,
          iconBuilder: iconBuilder,
        );

  final bool Function(String value, BuildContext context)? searchMatches;
}
