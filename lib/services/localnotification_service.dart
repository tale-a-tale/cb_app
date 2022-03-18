import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService{
  var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
  final _notification = FlutterLocalNotificationsPlugin();

  Future showLocalNotification({
    int id = 0,
    String title,
    String body,
    String payload }) async{
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        icon: "@mipmap/ic_launcher");
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
    await _notification.show(
        0, title, body, platformChannelSpecifics,
        payload: payload);
  }
}