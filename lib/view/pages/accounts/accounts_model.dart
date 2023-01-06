import 'dart:async';

import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:xdg_accounts/xdg_accounts.dart';

class AccountsModel extends SafeChangeNotifier {
  final XdgAccounts _xdgAccounts;

  AccountsModel(this._xdgAccounts);

  StreamSubscription<bool>? _usersChangedSub;
  List<XdgUser>? get users => _xdgAccounts.xdgUsers;

  Future<void> addUser({
    required String name,
    required String fullname,
    required int accountType,
    required String password,
    required String passwordHint,
  }) async {
    final path = await _xdgAccounts.createUser(
      name: name,
      fullname: fullname,
      accountType: accountType,
    );
    final user = _xdgAccounts.findUserByPath(path);
    if (user != null) {
      await user.setLocked(false);
      await user.setPasswordMode(0);
      await user.setPassword(password, passwordHint);
    }
  }

  Future<void> init() async {
    await _xdgAccounts.init();
    _usersChangedSub = _xdgAccounts.usersChanged.listen((event) {
      notifyListeners();
    });
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    _usersChangedSub?.cancel();
  }
}
