import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/bottom_sheet/gp_modal_bottom_sheet.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/utils/images/gp_images.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/modules/main_page_view/screens/main_page_view_screen.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/modules/home/components/continue_button.dart';
import 'package:groupup/modules/home/components/home_event.dart';
import 'package:groupup/modules/home/components/subtitle_home.dart';
import 'package:groupup/modules/sign_up/pages/sign_up_page_view_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final phoneProvider = Provider.of<PhoneAuthenProvider>(
      context,
      listen: false,
    );
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
            return MainPageViewScreen(
              homeViewModel: HomeViewModel(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: GPTextHeader(
                text: AppLocalizations.of(context)!.generalError,
              ),
            );
          }
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(
                right: kDefaultPadding * 1.5,
                left: kDefaultPadding * 1.5,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(
                      height: Insets.l * 2,
                    ),
                    GPTextHeader(
                      text: appLocalizations.groupUp,
                      textAlign: TextAlign.center,
                      fontSize: 34,
                    ),
                    SizedBox(
                      height: context.screenHeight * 0.1,
                    ),
                    Image.asset(
                      GPImages.target,
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
                          eventName: HomeEvent.getStartedButton.value,
                        );
                        phoneProvider.clean();
                        gpModalBottomSheet(
                          context,
                          400,
                          const SignUpPhonePageViewScreen(),
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
            ),
          );
        }),
      ),
    );
  }
}
