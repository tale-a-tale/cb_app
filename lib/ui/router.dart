import 'package:cb_app/ui/view/createpost_view.dart';
import 'package:cb_app/ui/view/home_view.dart';
import 'package:cb_app/ui/view/login_view.dart';
import 'package:flutter/material.dart';
import '../constants/app_routes.dart';

import 'package:cb_app/ui/view/signup_view.dart';

import '../models/post_model.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUpView(),
    );
    case LoginViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: LoginView(),
    );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomeView(),
      );
    case CreatePostViewRoute:
      String postTitle;
      Post postToEdit;

      if(settings.arguments is String){
        postTitle = settings.arguments;
      } else if(settings.arguments is Post){
        postToEdit = settings.arguments;
      }
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreatePostView(
          edittingPost: postToEdit,
          postTitle: postTitle,
        ),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
                child: Text('No route defined for ${settings.name}')),
          ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}