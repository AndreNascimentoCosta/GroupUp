import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/screens/saved_cards/saved_cards_create_group_bottom_sheet/saved_card_create_group_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SavedCardsCreateGroupBottomSheetBody extends StatelessWidget {
  const SavedCardsCreateGroupBottomSheetBody({
    required this.groupReward,
    required this.groupCurrency,
    required this.groupCode,
  });

  final String groupReward;
  final String groupCurrency;
  final String groupCode;

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context);
    final currentUser = Provider.of<AuthProvider>(context).user;
    if (currentUser == null) {
      return const Center(
        child: CircularProgressIndicator(color: kPrimaryColor),
      );
    }
    final userId = currentUser.id;
    return Expanded(
      child: Scrollbar(
        child: FutureBuilder(
          future: FirebaseFunctions.instance
              .httpsCallable('ListPaymentMethods')
              .call(
            {
              'userId': userId,
            },
          ),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('Error'),
                );
              } else {
                if (snapshot.hasData == false) {
                  return const Center(
                    child: CircularProgressIndicator(color: kPrimaryColor),
                  );
                }
                if (snapshot.data!.data.isEmpty) {
                  return Center(
                    child: StaticText(text: appLocalizations.noSavedCards),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.only(
                    top: kDefaultPadding / 2,
                  ),
                  separatorBuilder: (context, index) => const Divider(
                    indent: kDefaultPadding,
                    endIndent: kDefaultPadding,
                    height: 20,
                    thickness: 0.5,
                    color: kSecondaryColor,
                  ),
                  itemCount: snapshot.data?.data['paymentMethodsData'].length,
                  itemBuilder: (context, index) =>
                      SavedCardCreateGroupBottomSheet(
                    last4Numbers: snapshot.data?.data['paymentMethodsData']
                        [index]['card']['last4'],
                    brand: (snapshot.data?.data['paymentMethodsData'][index]
                            ['card']['brand'])
                        .toString()
                        .capitalize(),
                    expMonth: snapshot.data?.data['paymentMethodsData'][index]
                        ['card']['exp_month'],
                    expYear: snapshot.data?.data['paymentMethodsData'][index]
                        ['card']['exp_year'],
                    groupReward: groupReward,
                    groupCurrency: groupCurrency,
                    paymentMethodId: snapshot.data?.data['paymentMethodsData']
                        [index]['id'],
                    groupCode: groupCode,
                  ),
                );
              }
            } else {
              return const Center(
                child: CircularProgressIndicator(color: kPrimaryColor),
              );
            }
          },
        ),
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
