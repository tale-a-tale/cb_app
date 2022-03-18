import 'package:cb_app/models/user_model.dart';
import 'package:flutter/cupertino.dart';

import '../locator.dart';
import '../services/authentication_service.dart';

class BaseModel extends ChangeNotifier {

  final AuthenticationService _authenticationService = locator<AuthenticationService>();

  AppUser get currentUser => _authenticationService.currentUser;

  bool _busy = false;
  bool get busy => _busy;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }

}