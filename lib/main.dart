import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/add_input_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/screens/splashscreen/splashscreen.dart';
import 'package:groupup/styles/theme.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.orange,
  //   ),
  // );

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
          lazy: true,
        ),
        ListenableProvider(
          create: ((context) => PhoneAuthenProvider()),
        ),
        ListenableProvider(
          create: ((context) => StorageProvider()),
        ),
        ListenableProvider(
          create: ((context) => IndividualGroupProvider()),
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
