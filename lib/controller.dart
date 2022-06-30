import 'package:flutter/cupertino.dart';

class Controller extends ChangeNotifier {
  String? _token;
  String? get token => _token;
  set token(String? t) {
    _token = t;
    notifyListeners();
  }

  
}
