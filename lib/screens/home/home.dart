import 'package:flutter/material.dart';
import 'package:groupup/styles/button_style.dart';
import 'package:groupup/screens/home/home_button.dart';
import 'package:groupup/styles/standard_text.dart';

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
              StandardTextStyle(
                text: 'GroupUp',
                textAlign: TextAlign.left,
                fontFamily: 'Montserrat-Bold',
                fontWeight: FontWeight.bold,
                fontSize: 36,
              ),
              const SizedBox(
                height: 10,
              ),
              StandardTextStyle(
                text: 'Create or join a group and start setting your goals!',
                textAlign: TextAlign.left,
                letterSpacing: 1,
                fontSize: 18,
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
                onPressed: () {},
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
