import 'package:cb_app/constants/app_routes.dart';
import 'package:cb_app/locator.dart';
import 'package:cb_app/services/localnotification_service.dart';
import 'package:cb_app/services/navigation_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService{

  final NavigationService _navigationService =  locator<NavigationService>();
  final LocalNotificationService _localNotification =  locator<LocalNotificationService>();

  Future initializeNotification() async{
    FirebaseMessaging.instance.getInitialMessage();

    // If app is  in background notification will show in status bar
    // If app is in foreground then no popup is shown
    FirebaseMessaging.onMessage.listen((event) async{
      if(event.notification!= null) {
        print(event.notification.body);
        print(event.notification.title);
        _localNotification.showLocalNotification(title: event.notification.title, body: event.notification.body,payload: "Test Notif");
      }
    });

    //App should be in background and not terminated
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      if(event.data!= null){
        print(event.data['route']);
        _serialiseAndNavigate(event.data);
      }
    });
  }

  void _serialiseAndNavigate(Map<String, dynamic> data) {
    var notificationRoute = data['route'];
    if(notificationRoute != null && notificationRoute == 'create_view'){
      _navigationService.navigateTo(CreatePostViewRoute);
    }
  }

}