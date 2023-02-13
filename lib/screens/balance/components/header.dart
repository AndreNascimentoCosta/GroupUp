import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/title.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/balance/components/button.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderBalance extends StatelessWidget {
  const HeaderBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: kDefaultPadding,
          ),
          LargeBody(text: appLocalizations.balance),
          Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: GroupTitle(
                  text: Characters(user?.balance.toString() ?? '0')
                      .replaceAll(Characters(''), Characters('\u{200B}'))
                      .toString(),
                  fontFamily: 'Montserrat-SemiBold',
                ),
              ),
              SizedBox(width: MediaQuery.of(context).size.width * 0.05),
              Button(
                onPressed: () async {
                  try {
                    await FirebaseFunctions.instance
                        .httpsCallable('CreateAccount')
                        .call({});
                  } on FirebaseFunctionsException catch (e) {
                    // ignore: avoid_print
                    print(e.message);
                  }
                },
                text: appLocalizations.add,
                buttonColor: kPrimaryColor,
                textColor: Colors.white,
              ),
              const SizedBox(width: Insets.l),
              Button(
                onPressed: () async {
                  try {
                    await FirebaseFunctions.instance
                        .httpsCallable('DeleteAccount')
                        .call({
                      'accountId': 'acct_1MaROrIAfr4NdoZf',
                    });
                  } on FirebaseFunctionsException catch (e) {
                    // ignore: avoid_print
                    print(e.message);
                  }
                },
                text: appLocalizations.withdraw,
                buttonColor: Color(0XFFE1E1E1),
                textColor: Colors.black,
              ),
              const SizedBox(height: Insets.l * 2.25),
            ],
          ),
        ],
      ),
    );
  }
}
