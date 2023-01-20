import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/providers/storage.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/join/join_group_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/phone_auth_provider.dart';
import 'package:groupup/screens/individual_group/components/individual_group_provider.dart';
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
