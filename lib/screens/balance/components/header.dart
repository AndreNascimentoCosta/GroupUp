// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/texts/gu_text_body.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/texts/gu_text_header.dart';
import 'package:groupup/screens/balance/components/button.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/screens/balance/components/continue_create_connected_account_dialog.dart';
import 'package:groupup/screens/balance/components/create_connected_account_dialog.dart';
import 'package:groupup/screens/balance/components/payout_or_connected_account_options_dialog.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../core/providers/mix_panel_provider.dart';

class HeaderBalance extends StatelessWidget {
  const HeaderBalance({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthProvider>(context).user;
    final appLocalizations = AppLocalizations.of(context);
    bool isLoading = false;
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
              child: CircularProgressIndicator.adaptive(),
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
                  GUTextBody(
                    text: appLocalizations.balance,
                    minFontSize: 16,
                    maxFontSize: 18,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: context.screenWidth * 0.5,
                        child: GUTextHeader(
                          text: 'R\$ ${NumberFormat.decimalPattern(
                            Localizations.localeOf(context).toString(),
                          ).format(
                            double.parse('${(data / 100)}'),
                          )}',
                          overflow: TextOverflow.ellipsis,
                          minFontSize: 25,
                          maxFontSize: 35,
                        ),
                      ),
                      SizedBox(width: context.screenWidth * 0.1),
                      Button(
                        onPressed: () async {
                          if (isLoading) return;
                          Provider.of<MixPanelProvider>(context, listen: false)
                              .logEvent(eventName: 'Balance Options');
                          final authProvider =
                              Provider.of<AuthProvider>(context, listen: false);
                          if (authProvider.user == null) return;
                          if (authProvider.user!.stripeAccountId.isEmpty) {
                            createConnectedAccount(context);
                          } else {
                            isLoading = true;
                            final getAccount = await FirebaseFunctions.instance
                                .httpsCallable('GetAccount')
                                .call({
                              'accountId': authProvider.user!.stripeAccountId,
                            });
                            isLoading = false;
                            if (getAccount.data['detailsSubmitted'] == true) {
                              payoutOrConnectedAccountOptionsDialog(context);
                            } else {
                              continueCreateConnectedAccountDialog(context);
                            }
                          }
                        },
                        text: appLocalizations.options,
                        buttonColor: GPColors.primaryColor,
                        textColor: GPColors.white,
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
