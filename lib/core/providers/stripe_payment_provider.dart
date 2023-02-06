import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group/screens/individual_group.dart';
import 'package:provider/provider.dart';

enum PaymentStatus { initial, loading, success, error }

class StripePaymentProvider extends ChangeNotifier {
  final PaymentStatus status;

  StripePaymentProvider({this.status = PaymentStatus.initial});

  Future<void> initPayment(
    BuildContext context,
    String groupId,
    String userId,
    String groupReward,
    String groupCurrency,
    HomeViewModel homeViewModel,
  ) async {
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context, listen: false);
    try {
      final clientSecret = await FirebaseFunctions.instance
          .httpsCallable('StripePayEndPointMethodId')
          .call(
        {
          'groupId': groupId,
          'userId': userId,
          'groupReward': groupReward,
          'groupCurrency': groupCurrency,
        },
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret.data['clientSecret'],
          applePay: PaymentSheetApplePay(
            merchantCountryCode: 'US',
            paymentSummaryItems: [
              ApplePayCartSummaryItem.immediate(
                label: 'Reward',
                amount: groupReward.toString(),
              )
            ],
          ),
          style: ThemeMode.light,
          allowsDelayedPaymentMethods: false,
          appearance: const PaymentSheetAppearance(
            colors: PaymentSheetAppearanceColors(
              primary: Colors.black,
              background: Colors.white,
              secondaryText: Colors.black,
              primaryText: Colors.white,
              componentText: Colors.black,
              placeholderText: kSecondaryColor,
              componentBackground: Colors.white,
              componentBorder: Colors.black,
              componentDivider: Colors.black,
              icon: Colors.black,
              error: Colors.red,
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  text: Colors.white,
                  background: kPrimaryColor,
                ),
                dark: PaymentSheetPrimaryButtonThemeColors(
                  text: Colors.white,
                  background: kPrimaryColor,
                ),
              ),
            ),
          ),
        ),
      );
      await Stripe.instance.presentPaymentSheet();
      individualGroupProvider.getGroup(groupId);
      individualGroupProvider.updateIndex(0);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return IndividualGroupScreen(homeViewModel: homeViewModel);
          },
        ),
      );
    } on FirebaseFunctionsException catch (e) {
      print(e.message);
    }
  }
}
