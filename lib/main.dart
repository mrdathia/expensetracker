import 'dart:io';

import 'package:expensetracker/screens/splash.dart';
import 'package:flutter/material.dart';

import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:expensetracker/screens/splash.dart';

// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   await Firebase
//       .initializeApp(); // options: DefaultFirebaseConfig.platformOptions
//   print('Handling a background message ${message.messageId}');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  EasyLoading.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Splash(),
      builder: EasyLoading.init(),
    );
  }
}

// #TODO Gitesh why was this added please comment
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
