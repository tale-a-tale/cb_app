import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../locator.dart';
import '../models/user_model.dart';
import 'firestore_service.dart';

class AuthenticationService{

  final FirebaseAuth _firebaseAuth =  FirebaseAuth.instance;
  final FireStoreService _fireStoreService = locator<FireStoreService>();

  AppUser _currentUser;
  AppUser get currentUser => _currentUser;

  //Method for handling login service
  Future loginWithEmail({@required String email, @required String password}) async{
    try{
      var authUser = await _firebaseAuth.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      _populateCurrentUser(authUser.user);
      return authUser.user != null;
    }catch(e){
      return e.message;
    }
  }

  //Method for handling signup service
  Future signUpWithEmail({
    @required String email,
    @required String password,
    @required String fullName,
    @required String role,
  }) async{
    try {
      var authResult = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      //Create a user to store details
      _currentUser =  AppUser(
          id: authResult.user.uid,
          email: email,
          name: fullName,
          userRole: role
      );
      await _fireStoreService.createUser(_currentUser);
      return authResult != null;
    } catch (e) {
      return e.message;
    }
  }

  //Handle login scenario
  Future<bool> isUserLoggedIn() async{
    var user = _firebaseAuth.currentUser;
    _populateCurrentUser(user);
    return user != null;
  }

  //Populate
  void _populateCurrentUser(User user) async{
    if(user != null){
      _currentUser = await _fireStoreService.getUser(user.uid);
    }
  }
}