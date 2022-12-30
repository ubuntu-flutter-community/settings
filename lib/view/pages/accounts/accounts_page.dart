import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/accounts/accounts_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:xdg_accounts/xdg_accounts.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({Key? key}) : super(key: key);

  static Widget create(BuildContext context) =>
      ChangeNotifierProvider<AccountsModel>(
        create: (context) => AccountsModel(context.read<XdgAccounts>()),
        child: const AccountsPage(),
      );

  static Widget createTitle(BuildContext context) =>
      Text(context.l10n.usersPageTitle);

  static bool searchMatches(String value, BuildContext context) => value
          .isNotEmpty
      ? context.l10n.usersPageTitle.toLowerCase().contains(value.toLowerCase())
      : false;

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccountsModel>();
    return SettingsPage(
      children: [
        Center(
          child: Column(
            children: [
              for (final user in model.users ?? <XdgUser>[])
                YaruTile(title: Text(user.name))
            ],
          ),
        )
      ],
    );
  }
}
