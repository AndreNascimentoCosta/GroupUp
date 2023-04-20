import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/header.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/groups/screens/groups_screen.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/first_page.dart';
import 'package:groupup/screens/home/components/continue_button.dart';
import 'package:groupup/screens/home/components/subtitle_home.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

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
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          }
          if (snapshot.hasData) {
            return GroupsScreen(
              homeViewModel: HomeViewModel(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Header(
                text: AppLocalizations.of(context).generalError,
              ),
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                right: kDefaultPadding * 1.5,
                left: kDefaultPadding * 1.5,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(
                    height: Insets.l * 2,
                  ),
                  const StaticText(
                    text: 'GroupUp',
                    textAlign: TextAlign.center,
                    fontSize: 34,
                    fontFamily: 'Montserrat-Bold',
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.1,
                  ),
                  Image.asset(
                    'assets/images/target2.png',
                    height: context.screenHeight * 0.35,
                    fit: BoxFit.fitHeight,
                  ),
                  SizedBox(
                    height: context.screenHeight * 0.05,
                  ),
                  const SubtitleHome(),
                  SizedBox(
                    height: context.screenHeight * 0.065,
                  ),
                  ButtonCommonStyle(
                    onPressed: () {
                      Provider.of<MixPanelProvider>(
                        context,
                        listen: false,
                      ).logEvent(
                        eventName: 'Home Screen - Get Started Button',
                      );
                      gpModalBottomSheet(
                        context,
                        Platform.isAndroid
                            ? context.screenHeight * 0.25
                            : context.screenHeight * 0.325,
                        const FirsPageSignUp(),
                      );
                    },
                    child: Provider.of<AuthProvider>(context).loading
                        ? const CircularProgressIndicator.adaptive()
                        : const ContinueButton(),
                  ),
                  const SizedBox(
                    height: Insets.l,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
