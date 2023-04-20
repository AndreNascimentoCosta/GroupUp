import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/switch.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/components/login_button_style.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/sign_up_phone/pages/page_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FirsPageSignUp extends StatefulWidget {
  const FirsPageSignUp({
    Key? key,
  }) : super(key: key);

  @override
  State<FirsPageSignUp> createState() => _FirsPageSignUpState();
}

class _FirsPageSignUpState extends State<FirsPageSignUp> {
  final SwitchModel switchModel = SwitchModel();
  @override
  Widget build(BuildContext context) {
    final phoneProvider = Provider.of<PhoneAuthenProvider>(
      context,
      listen: false,
    );
    final mixPanel = Provider.of<MixPanelProvider>(
      context,
      listen: false,
    );
    final authProvider = Provider.of<AuthProvider>(
      context,
      listen: false,
    );
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(
          context,
        );
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding * 1.5,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (Platform.isAndroid)
                const SizedBox(
                  height: Insets.l * 1.5,
                )
              else
                const SizedBox(
                  height: Insets.l * 1.5,
                ),
              if (Platform.isAndroid)
                const SizedBox()
              else
                SignInWithAppleButton(
                  onPressed: () {
                    mixPanel.logEvent(
                      eventName: 'Sign Up with Apple',
                    );
                    authProvider.loading == true;
                    final provider = context.read<AuthProvider>();
                    provider.appleLogin(context);
                    Navigator.pop(context);
                  },
                  text: AppLocalizations.of(
                    context,
                  ).continueApple,
                  height: 50,
                  iconAlignment: IconAlignment.left,
                  style: SignInWithAppleButtonStyle.whiteOutlined,
                  borderRadius: BorderRadius.circular(
                    Insets.l,
                  ),
                ),
              const SizedBox(
                height: Insets.l * 1.25,
              ),
              ButtonCommonStyle(
                onPressed: () async {
                  mixPanel.logEvent(
                    eventName: 'Sign Up with Google',
                  );
                  authProvider.loading == true;
                  final provider = context.read<AuthProvider>();
                  await provider.googleLogin(
                    context,
                  );
                },
                child: LoginButtonStyle(
                  text: AppLocalizations.of(
                    context,
                  ).continueGoogle,
                ),
              ),
              const SizedBox(
                height: Insets.l * 1.25,
              ),
              ButtonCommonStyle(
                onPressed: () {
                  mixPanel.logEvent(
                    eventName: 'Sign Up with Phone Number',
                  );
                  Navigator.pop(context);
                  phoneProvider.start = 30;
                  phoneProvider.clean();
                  gpModalBottomSheet(
                    context,
                    400,
                    const SignUpPhonePageView(),
                  );
                },
                child: LoginButtonStyle(
                  text: AppLocalizations.of(
                    context,
                  ).continuePhoneNumber,
                  withIcon: false,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
