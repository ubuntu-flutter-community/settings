import 'package:nm/nm.dart';
import 'package:safe_change_notifier/safe_change_notifier.dart';

class ConnectivityModel extends SafeChangeNotifier {

  ConnectivityModel(NetworkManagerClient client) : _client = client;
  final NetworkManagerClient _client;

  Future<void> init() {
    final network = _client.connect();
    return Future.wait([network]);
  }

  bool? get checkConnectiviy => _client.connectivityCheckEnabled;
  set checkConnectiviy(bool? value) {
    if (value == null) return;
    _client
        .setConnectivityCheckEnabled(value)
        .then((value) => notifyListeners());
  }
}
