import 'package:cb_app/services/authentication_service.dart';
import 'package:cb_app/services/dialog_service.dart';
import 'package:cb_app/services/firestore_service.dart';
import 'package:cb_app/services/localnotification_service.dart';
import 'package:cb_app/services/pushnotify_service.dart';
import 'package:get_it/get_it.dart';
import 'package:cb_app/services/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator(){
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => AuthenticationService());
  locator.registerLazySingleton(() => FireStoreService());
  locator.registerLazySingleton(() => PushNotificationService());
  locator.registerLazySingleton(() => LocalNotificationService());
}