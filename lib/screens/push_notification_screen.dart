// import 'dart:html';
// import 'package:flutter/material.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class PushNotification extends StatefulWidget {
//   @override
//   _PushNotification createState() => _PushNotification();
// }

// class _PushNotification extends State<PushNotification> {

//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//   @override
//   void initState() {
//     super.initState();
//     flutterLocalNotificationsPlugin =FlutterLocalNotificationsPlugin();
//     var android = AndroidInitializationSettings('@mipmap/ic_launcher');
//     var ios= IOSInitializationSettings();
//     var initSettings = InitializationSettings(android, iOS);
//     flutterLocalNotificationsPlugin.initialize(initSettings,
//         onSelectNotification: onSelectNotification);
//   }

//   Future onSelectNotification(String payLoad) {
//     debugPrint('payLoad: $payLoad');
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('Notification'),
//         content: Text('$payLoad'),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar:  AppBar(
//         title: Text('Flutter local Notification'),
//       ),
//       body: Center(
//         child:  RaisedButton(
//           onPressed: showNotification,
//           child: Text('Tap To Get a Notification',
//           style: Theme.of(context).textTheme.headline,),

//         ),
//       ),
//     );
//   }

//   showNotification() async {
//     var android =  AndroidNotificationDetails(
//         'channelId', 'channelName', 'channelDescription',
//         priority: Priority.High, importance: Importance.max);
//   }

//   var platform = NotificationDetails(android);
//   await flutterLocalNotificationsPlugin.show(
//     0, 'New Tutorial', 'Local Notification', patform,
//      payload:'AndroidCoding.in');
// }
