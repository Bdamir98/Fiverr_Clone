
import 'package:flutter/foundation.dart';

class ChatScreenProvider with ChangeNotifier {
  bool _isExpanded = false;

  bool get isExpanded => _isExpanded;

  void toggleExpandedState() {
    _isExpanded = !_isExpanded;
    notifyListeners();
  }
}
