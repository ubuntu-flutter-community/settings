import 'package:safe_change_notifier/safe_change_notifier.dart';

class AppModel extends SafeChangeNotifier {
  String? _searchQuery;
  String? get searchQuery => _searchQuery;
  void setSearchQuery(String? value) {
    if (value == _searchQuery) return;
    _searchQuery = value;
    notifyListeners();
  }

  bool? _searchActive;
  bool? get searchActive => _searchActive;
  void setSearchActive(bool? value) {
    if (value == _searchActive) return;
    _searchActive = value;
    notifyListeners();
  }
}
