import 'dart:async';
import 'package:flutter/material.dart';
import 'package:groupup/models/dropdown.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/groups/groups_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return StartState();
  }
}

class StartState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() async {
    var duration = const Duration(seconds: 2);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => GroupsScreen(
                  homeViewModel: HomeViewModel(),
                  dropDownModel: DropDownModel(),
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        'assets/images/SplashScreen.png',
        height: 932,
        width: 430,
      ),
    );
  }
}
