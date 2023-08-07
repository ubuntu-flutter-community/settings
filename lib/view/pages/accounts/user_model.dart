import 'dart:async';
import 'dart:io';

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

  int? get id => _user.uid;

  File? get iconFile {
    String? iconFile;
    try {
      iconFile = _user.iconFile;
    } on Exception catch (_) {
      return null;
    }

    if (iconFile == null || iconFile.endsWith('.face')) {
      return null;
    } else {
      return File(_user.iconFile!.toString());
    }
  }

  XdgAccountType? get accountType => _user.accountType;

  Future<void> init() async {
    _userNameSub = _user.userNameChanged.listen((event) => notifyListeners());
  }

  @override
  void dispose() {
    _userNameSub?.cancel();
    super.dispose();
  }
}
