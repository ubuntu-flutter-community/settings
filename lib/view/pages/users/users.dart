import 'package:flutter/material.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) => const UsersPage();

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.usersPageTitle);

  static bool searchMatches(String value, BuildContext context) => value
          .isNotEmpty
      ? context.l10n.usersPageTitle.toLowerCase().contains(value.toLowerCase())
      : false;

  @override
  Widget build(BuildContext context) {
    return YaruPage(children: [
      Center(
        child: Text(context.l10n.usersPageTitle),
      )
    ]);
  }
}
