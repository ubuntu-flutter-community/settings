import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:settings/constants.dart';
import 'package:settings/l10n/l10n.dart';
import 'package:settings/view/common/yaru_switch_row.dart';
import 'package:settings/view/pages/accounts/accounts_model.dart';
import 'package:settings/view/pages/accounts/user_model.dart';
import 'package:settings/view/pages/privacy/house_keeping_page.dart';
import 'package:settings/view/pages/settings_page.dart';
import 'package:ubuntu_service/ubuntu_service.dart';
import 'package:xdg_accounts/xdg_accounts.dart';
import 'package:yaru_icons/yaru_icons.dart';
import 'package:yaru_widgets/yaru_widgets.dart';

class AccountsPage extends StatelessWidget {
  const AccountsPage({super.key});

  static Widget create(BuildContext context) =>
      ChangeNotifierProvider<AccountsModel>(
        create: (context) => AccountsModel(getService<XdgAccounts>())..init(),
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
                  _UserTile.create(
                    context: context,
                    user: user,
                    deleteUser: model.deleteUser,
                    init: () async {
                      await Future.delayed(const Duration(seconds: 1));
                    },
                  ),
              ],
            ),
          ),
        ),
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
  XdgAccountType _accountType = XdgAccountType.user;

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
      title: const YaruDialogTitleBar(
        title: Text('Add User'),
      ),
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.all(kYaruPagePadding),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: 350,
            child: YaruSwitchRow(
              value: _accountType == XdgAccountType.admin,
              onChanged: (value) => setState(() {
                _accountType =
                    value ? XdgAccountType.admin : XdgAccountType.user;
              }),
              trailingWidget: const Text('Admin'), // TODO: localize
            ),
          ),
          const SizedBox(
            height: kYaruPagePadding,
          ),
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
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () => model
              .addUser(
            name: _usernameController.text,
            fullname: _fullNameController.text,
            accountType: _accountType.index,
            password: _passwordController.text,
            passwordHint: _passwordHintController.text,
          )
              .then((_) {
            model.init().then((value) => Navigator.pop(context));
          }),
          child: Text(context.l10n.confirm),
        ),
      ],
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({required this.deleteUser, required this.init});

  final Future<void> Function({
    required int id,
    required String name,
    required bool removeFiles,
  }) deleteUser;
  final Future<void> Function() init;

  static Widget create({
    required BuildContext context,
    required XdgUser user,
    required Future<void> Function({
      required int id,
      required String name,
      required bool removeFiles,
    }) deleteUser,
    required final Future<void> Function() init,
  }) {
    return ChangeNotifierProvider<UserModel>(
      create: (context) => UserModel(user)..init(),
      child: _UserTile(
        deleteUser: deleteUser,
        init: init,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final model = context.watch<UserModel>();
    final theme = Theme.of(context);

    return YaruTile(
      leading: model.iconFile != null
          ? CircleAvatar(
              radius: 20,
              backgroundImage: FileImage(model.iconFile!),
            )
          : CircleAvatar(
              radius: 20,
              backgroundColor: theme.colorScheme.inverseSurface,
              child: Center(
                child: Text(
                  model.userName?.substring(0, 1) ?? '',
                  style: TextStyle(
                    fontSize: 20,
                    color: theme.colorScheme.onInverseSurface,
                  ),
                ),
              ),
            ),
      title: Text(model.userName ?? ''),
      subtitle: Text(
        model.accountType?.name ?? '',
      ),
      trailing: Row(
        children: [
          YaruIconButton(
            icon: const Icon(YaruIcons.pen),
            onPressed: () => showDialog(
              context: context,
              builder: (context) => ChangeNotifierProvider<UserModel>.value(
                value: model,
                child: const _EditUserDialog(),
              ),
            ),
          ),
          if (model.id != null || model.userName == null)
            YaruIconButton(
              icon: const Icon(YaruIcons.trash),
              onPressed: () => showDialog(
                context: context,
                builder: (context) => ConfirmationDialog(
                  iconData: YaruIcons.trash,
                  onConfirm: () => deleteUser(
                    id: model.id!,
                    name: model.userName!,
                    removeFiles: true,
                  ).then((_) {
                    init().then((value) => Navigator.pop(context));
                  }),
                ),
              ),
            ),
        ],
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
        ),
      ],
    );
  }
}
