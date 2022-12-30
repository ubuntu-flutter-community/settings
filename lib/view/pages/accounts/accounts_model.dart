import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:xdg_accounts/xdg_accounts.dart';

class AccountsModel extends SafeChangeNotifier {
  final XdgAccounts xdgAccounts;

  AccountsModel(this.xdgAccounts);

  List<XdgUser>? get users => xdgAccounts.xdgUsers;

  Future<void> init() async {
    await xdgAccounts.init();
  }
}
