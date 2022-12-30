import 'dart:async';

import 'package:safe_change_notifier/safe_change_notifier.dart';
import 'package:xdg_accounts/xdg_accounts.dart';

class UserModel extends SafeChangeNotifier {
  UserModel(this._user);

  final XdgUser _user;
  StreamSubscription<String>? _userNameSub;

  String? get userName => _user.userName;
  set userName(String? value) {
    if (value == null) return;
    _user.setUserName(value, allowInteractiveAuthorization: true);
  }

  String? get iconFile => _user.iconFile;
  String? get accountType => _user.accountType?.name;

  void init() {
    _userNameSub = _user.userNameChanged.listen((event) {
      userName = event;
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _userNameSub?.cancel();
    super.dispose();
  }
}
