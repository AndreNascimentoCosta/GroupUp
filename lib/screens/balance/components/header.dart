// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/core/widgets/texts/title.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/balance/components/button.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/balance/components/continue_create_connected_account_dialog.dart';
import 'package:groupup/screens/balance/components/create_connected_account_dialog.dart';
import 'package:groupup/screens/balance/components/payout_or_connected_account_options_dialog.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HeaderBalance extends StatelessWidget {
  const HeaderBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context);
    if (user == null) return const SizedBox();
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: user.id)
            .snapshots(),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs.first.data()['balance'];
          if (snapshot.hasData == false || snapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(color: kPrimaryColor),
            );
          } else {
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
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: StaticText(
                          text:
                              'R\$ ${Characters((data / 100).toStringAsFixed(2)).replaceAll(Characters(''), Characters('\u{200B}')).toString()}',
                          fontFamily: 'Montserrat-SemiBold',
                          fontSize: 30,
                        ),
                      ),
                      SizedBox(width: MediaQuery.of(context).size.width * 0.2),
                      Button(
                        onPressed: () async {
                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          if (authProvider.user == null) return;
                          if (authProvider.user!.stripeAccountId.isEmpty) {
                            createConnectedAccount(context);
                          } else {
                            final getAccount = await FirebaseFunctions.instance
                                .httpsCallable('GetAccount')
                                .call({
                              'accountId': authProvider.user!.stripeAccountId,
                            });
                            if (getAccount.data['detailsSubmitted'] == true) {
                              payoutOrConnectedAccountOptionsDialog(context);
                            } else {
                              continueCreateConnectedAccountDialog(context);
                            }
                          }
                        },
                        text: appLocalizations.options,
                        buttonColor: kPrimaryColor,
                        textColor: Colors.white,
                      ),
                      const SizedBox(height: Insets.l * 2.25),
                    ],
                  ),
                ],
              ),
            );
          }
        });
  }
}
