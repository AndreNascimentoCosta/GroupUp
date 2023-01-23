import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/first_page.dart';
import 'package:groupup/screens/home/components/continue_button.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return GroupsScreen(homeViewModel: HomeViewModel());
          } else if (snapshot.hasError) {
            return const Center(child: Header(text: 'Something went wrong'));
          } else {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: kDefaultPadding * 1.5, left: kDefaultPadding * 1.5),
                child: ListView(
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: Insets.l * 2),
                        const StaticText(
                          text: 'GroupUp',
                          textAlign: TextAlign.center,
                          fontSize: 34,
                          fontFamily: 'Montserrat-SemiBold',
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.1),
                        Image.asset(
                          'assets/images/target2.png',
                          height: MediaQuery.of(context).size.height * 0.35,
                          fit: BoxFit.fitHeight,
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.05),
                        RichText(
                          textAlign: TextAlign.center,
                          text: const TextSpan(
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 28,
                              fontFamily: 'Montserrat-Medium',
                            ),
                            children: [
                              TextSpan(
                                text: 'Create',
                                style: TextStyle(
                                  fontFamily: 'Montserrat-Bold',
                                ),
                              ),
                              TextSpan(
                                text: ' or',
                              ),
                              TextSpan(
                                text: ' Join',
                                style: TextStyle(
                                  fontFamily: 'Montserrat-Bold',
                                ),
                              ),
                              TextSpan(
                                text: ' a group then',
                              ),
                              TextSpan(
                                text: ' Challenge!',
                                style: TextStyle(
                                  fontFamily: 'Montserrat-Bold',
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.065),
                        ButtonCommonStyle(
                          onPressed: () {
                            showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(Insets.m),
                              ),
                              builder: (context) {
                                return Padding(
                                  padding: MediaQuery.of(context).viewInsets,
                                  child: Wrap(
                                    children: <Widget>[
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: const [
                                          SizedBox(
                                              height: 280,
                                              child: FirsPageSignUp()),
                                        ],
                                      )
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Provider.of<AuthProvider>(context).loading
                              ? const CircularProgressIndicator(color: kPrimaryColor)
                              : const ContinueButton(),
                        ),
                        const SizedBox(height: Insets.l),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
