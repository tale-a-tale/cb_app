import 'package:cb_app/locator.dart';
import 'package:cb_app/services/dialog_service.dart';
import 'package:cb_app/services/navigation_service.dart';
import 'package:cb_app/ui/router.dart';
import 'package:cb_app/ui/view/startup_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'managers/dialog_manager.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  await Firebase.initializeApp();
  runApp(CBApp());
}

class CBApp extends StatelessWidget {
  const CBApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Compound',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => Navigator(
        key: locator<DialogService>().dialogNavigationKey,
        onGenerateRoute: (settings) => MaterialPageRoute(
            builder: (context) => DialogManager(child: child)),
      ),
      navigatorKey: locator<NavigationService>().navigationKey,
      theme: ThemeData(
        primaryColor: Colors.teal,
        backgroundColor: Colors.teal,
      ),
      home: StartupView(),
      onGenerateRoute: generateRoute,
    );
  }
}
