import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/storage.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/join_group_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_provider.dart';
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
        ListenableProvider(
          create: ((context) => CreateGroupProvider()),
        ),
        ListenableProvider(
          create: ((context) => JoinGroupProvider()),
        ),
        ListenableProvider(
          create: ((context) => PhoneAuthenProvider()),
        ),
        ListenableProvider(
          create: ((context) => StorageProvider()),
        ),
      ],
      child: MaterialApp(
        title: 'GroupUp',
        theme: themeData,
        home: const SplashScreen(),
      ),
    ),
  );
}
