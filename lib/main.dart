import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lunar_cinema/BookingPage.dart';
import 'package:lunar_cinema/MoviesPage.dart';
import 'package:lunar_cinema/PaymentPage.dart';
import 'package:provider/provider.dart';

import 'Login.dart';
import 'Signup.dart';
import 'authentication.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    ChangeNotifierProvider(
      create: (context) => Authentication(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '',
      routes: {
        '/': (context) => Login(),
        '/signup': (context) => Signup(),
        '/home':(context)=>MoviesPage(),
      },
    );
  }
}
