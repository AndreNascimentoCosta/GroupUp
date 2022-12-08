import 'package:flutter/material.dart';
import 'package:groupup/screens/group_settings/styles/button_style.dart';
import 'package:groupup/screens/home/home_button.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 30,
            left: 30,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(
                height: 20,
              ),
              const Text(
                'GroupUp',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'Montserrat-Bold',
                  fontWeight: FontWeight.bold,
                  fontSize: 36.0,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'Create or join a group and start setting your goals!',
                textAlign: TextAlign.left,
                style: TextStyle(
                  letterSpacing: 1.0,
                  fontFamily: 'Montserrat-Medium',
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/icons/targetteam.png',
                height: 380,
                fit: BoxFit.fitHeight,
              ),
              const SizedBox(
                height: 40,
              ),
              ButtonCommonStyle(
                  onPressed: () {},
                  child: HomeButton(
                    isGreen: true,
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              ButtonCommonStyle(
                onPressed: (){},
                child: HomeButton(
                  isGreen: false,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
