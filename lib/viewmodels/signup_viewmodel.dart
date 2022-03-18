import 'package:cb_app/constants/app_routes.dart';
import 'package:cb_app/locator.dart';
import 'package:cb_app/services/authentication_service.dart';
import 'package:cb_app/services/dialog_service.dart';
import 'package:cb_app/services/navigation_service.dart';
import 'package:cb_app/viewmodels/base_models.dart';
import 'package:flutter/material.dart';

class SignUpViewModel extends BaseModel{

  final AuthenticationService _authenticationService
                            = locator<AuthenticationService>();
  final NavigationService _navigationService
                            = locator<NavigationService>();
  final DialogService _dialogService
                            = locator<DialogService>();

  String _selectedRole = "Select A User Role";
  String get selectedRole => _selectedRole;


  setSelectedRole(dynamic role){
    _selectedRole = role;
    notifyListeners();
  }

  Future signUp({@required String email, @required String password, @required String name}) async {
    setBusy(true);

    var result = await _authenticationService.signUpWithEmail(
        email: email,
        password: password,
        fullName: name,
        role: _selectedRole
    );

    setBusy(false);
    if (result is bool) {
      if (result) {
        _navigationService.navigateTo(HomeViewRoute);
      } else {
        await _dialogService.showDialog(
          title: 'Sign Up Failure',
          description: 'General sign up failure. Please try again later',
        );

      }
    } else {
      await _dialogService.showDialog(
        title: 'Sign Up Failure',
        description: result,
      );
    }
  }
}