import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/pages/accounts/accounts_model.dart';
import 'package:settings/view/pages/accounts/user_model.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:xdg_accounts/xdg_accounts.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  static Widget create(BuildContext context) =>
      ChangeNotifierProvider<AccountsModel>(
        create: (context) => AccountsModel(context.read<XdgAccounts>())..init(),
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
          child: SizedBox(
            width: kDefaultWidth,
            child: Column(
              children: [
                YaruTile(
                  title: const Text('Add user'),
                  leading: YaruIconButton(
                    icon: const Icon(
                      YaruIcons.plus,
                    ),
                    onPressed: () => showDialog(
                      context: context,
                      builder: (context) =>
                          ChangeNotifierProvider<AccountsModel>.value(
                        value: model,
                        child: const _AddUserDialog(),
                      ),
                    ),
                  ),
                ),
                for (final user in model.users ?? <XdgUser>[])
                  _UserTile.create(context: context, user: user)
              ],
            ),
          ),
        )
      ],
    );
  }
}

class _AddUserDialog extends StatefulWidget {
  const _AddUserDialog();

  @override
  State<_AddUserDialog> createState() => _AddUserDialogState();
}

class _AddUserDialogState extends State<_AddUserDialog> {
  late TextEditingController _usernameController;
  late TextEditingController _fullNameController;
  late TextEditingController _passwordController;
  late TextEditingController _passwordHintController;

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _fullNameController = TextEditingController();
    _passwordHintController = TextEditingController();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _fullNameController.dispose();
    _passwordHintController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AccountsModel>();
    return AlertDialog(
      title: const YaruTitleBar(
        title: Text('Add User'),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(kYaruPagePadding),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'username'),
          ),
          const SizedBox(
            height: kYaruPagePadding,
          ),
          TextField(
            controller: _fullNameController,
            decoration: const InputDecoration(labelText: 'full name'),
          ),
          const SizedBox(
            height: kYaruPagePadding,
          ),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'password'),
          ),
          const SizedBox(
            height: kYaruPagePadding,
          ),
          TextField(
            controller: _passwordHintController,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Password hint'),
          )
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => model
              .addUser(
                name: _usernameController.text,
                fullname: _fullNameController.text,
                accountType: 0,
                password: _passwordController.text,
                passwordHint: _passwordHintController.text,
              )
              .then((_) => Navigator.pop(context)),
          child: Text(context.l10n.confirm),
        )
      ],
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile();

  static Widget create({required BuildContext context, required XdgUser user}) {
    return ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel(user)..init(),
      child: const _UserTile(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<UserModel>();

    return YaruTile(
      leading: model.iconFile != null
          ? CircleAvatar(
              radius: 20,
              backgroundImage: FileImage(File(model.iconFile!)),
            )
          : null,
      title: Text(model.userName ?? ''),
      subtitle: Text(
        model.accountType ?? '',
      ),
      trailing: YaruIconButton(
        icon: const Icon(YaruIcons.pen),
        onPressed: () => showDialog(
          context: context,
          builder: (context) => ChangeNotifierProvider<UserModel>.value(
            value: model,
            child: const _EditUserDialog(),
          ),
        ),
      ),
    );
  }
}

class _EditUserDialog extends StatefulWidget {
  const _EditUserDialog();

  @override
  State<_EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<_EditUserDialog> {
  late TextEditingController userNameController;

  @override
  void initState() {
    super.initState();
    userNameController = TextEditingController();
  }

  @override
  void dispose() {
    userNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<UserModel>();
    userNameController.text = model.userName ?? '';
    return SimpleDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(kYaruPagePadding),
      title: YaruTitleBar(
        title: Text(model.userName ?? ''),
      ),
      children: [
        TextField(
          controller: userNameController,
          onSubmitted: (value) => model.userName = value,
        )
      ],
    );
  }
}
