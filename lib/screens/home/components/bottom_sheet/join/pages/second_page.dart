import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/switch.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up_phone/page_view.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/styles/text.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class SecondPageJoin extends StatefulWidget {
  const SecondPageJoin({
    required this.controller,
  });

  final PageController controller;

  @override
  State<SecondPageJoin> createState() => _SecondPageJoinState();
}

class _SecondPageJoinState extends State<SecondPageJoin> {
  final SwitchModel switchModel = SwitchModel();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: Insets.l * 1.5),
              SignInWithAppleButton(
                onPressed: () {},
                text: 'Continue with Apple',
                height: 50,
                iconAlignment: IconAlignment.left,
                style: SignInWithAppleButtonStyle.whiteOutlined,
                borderRadius: BorderRadius.circular(Insets.l),
              ),
              const SizedBox(height: Insets.l * 1.25),
              ButtonCommonStyle(
                onPressed: () {},
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(Insets.l),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Image.network(
                          'http://pngimg.com/uploads/google/google_PNG19635.png',
                          height: 35,
                          width: 31,
                        ),
                        const Expanded(
                          child: StandardTextStyle(
                            text: 'Continue with Google',
                            fontSize: 18.92,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(width: 28),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Insets.l * 1.25),
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
                                      height: 400, child: SignUpPhonePageView()),
                                ],
                              )
                            ],
                          ),
                        );
                      });
                },
                child: Container(
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(Insets.l),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: const [
                        Expanded(
                          child: StandardTextStyle(
                            text: 'Continue with phone number',
                            fontSize: 18.92,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
