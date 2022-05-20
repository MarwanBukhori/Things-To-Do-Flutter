import 'dart:io';

import 'package:camera/camera.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_note/providers/user.provider.dart';
import 'package:flutter_note/screen/landing-page.screen.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

late List<CameraDescription> cameras;

// Firebase Messaging Instance
FirebaseMessaging messaging = FirebaseMessaging.instance;

// Firebase Background Handler
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,

  print("Handling a background message: ${message.messageId}");
}

// Firebase Foregound
// const AndroidNotificationChannel channel = AndroidNotificationChannel(
//   'high_importance_channel', // id
//   'High Importance Notifications', // title
//   'This channel is used for important notifications.', // description
//   importance: Importance.max,
// );

void main() async {
  await GetStorage.init();
  await Firebase.initializeApp();
  cameras = await availableCameras();

  if (Platform.isIOS) {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
  }
  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  //     FlutterLocalNotificationsPlugin();
  //
  // await flutterLocalNotificationsPlugin
  //     .resolvePlatformSpecificImplementation<
  //         AndroidFlutterLocalNotificationsPlugin>()
  //     ?.createNotificationChannel(channel);
  //
  // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
  //   RemoteNotification? notification = message.notification;
  //   AndroidNotification? android = message.notification?.android;
  //
  //   // If `onMessage` is triggered with a notification, construct our own
  //   // local notification to show to users using the created channel.
  //   if (notification != null && android != null) {
  //     flutterLocalNotificationsPlugin.show(
  //         notification.hashCode,
  //         notification.title,
  //         notification.body,
  //         NotificationDetails(
  //           android: AndroidNotificationDetails(
  //             channel.id,
  //             channel.name,
  //             channel.description,
  //             icon: android.smallIcon,
  //             // other properties...
  //           ),
  //         ));
  //   }
  // });

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appUser = AppUser();

    return MultiProvider(
      providers: [ChangeNotifierProvider<AppUser>.value(value: appUser)],
      child: Builder(
        builder: (context) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.green,
            ),
            home: LandingPage(),
          );
        },
      ),
    );
  }
}

// void main() async {
//   await GetStorage.init();
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   final box = GetStorage();
//   @override
//   Widget build(BuildContext context) {
//     final taskList = box.read('taskList');
//     final List<Task> list = taskList != null
//         ? List.from((taskList as List<dynamic>).map((e) => Task.fromMap(e)))
//         : [];
//
//     final taskListProvider = TaskListProvider(taskList: list);
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider<TaskListProvider>.value(value: taskListProvider)
//       ],
//       child: Builder(
//         builder: (context) {
//           return MaterialApp(
//             title: 'Flutter Demo',
//             theme: ThemeData(
//               primarySwatch: Colors.blue,
//             ),
//             home: TestScreen(),
//           );
//         },
//       ),
//     );
//   }
// }