import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:groupup/screens/splashscreen/splashscreen.dart';
import 'package:groupup/styles/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        ListenableProvider(
          create: ((context) => AuthProvider()),
        ),
      ],
      child: MaterialApp(
        theme: themeData,
        home: const SplashScreen(),
      ),
    ),
  );
}
