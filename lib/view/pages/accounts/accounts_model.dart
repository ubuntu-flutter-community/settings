import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:xdg_accounts/xdg_accounts.dart';

class AccountsModel extends SafeChangeNotifier {
  final XdgAccounts _xdgAccounts;

  AccountsModel(this._xdgAccounts);

  List<XdgUser>? get users => _xdgAccounts.xdgUsers;

  Future<void> addUser({
    required String name,
    required String fullname,
    required int accountType,
    required String password,
  }) async {
    final path = await _xdgAccounts.createUser(
      name: name,
      fullname: fullname,
      accountType: accountType,
    );
    final user = _xdgAccounts.findUserByPath(path);
    if (user != null) {
      user.setPassword(password, '').then((_) => user.setLocked(false));
    }
  }

  Future<void> init() async {
    await _xdgAccounts.init();
    notifyListeners();
  }
}
