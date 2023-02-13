import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groupup/constants.dart';

enum PaymentStatus { initial, loading, success, error }

class StripePaymentProvider extends ChangeNotifier {
  final PaymentStatus status;
  bool isPaying = false;

  StripePaymentProvider({this.status = PaymentStatus.initial});

  Future<void> initPaymentCreateGroup(
    BuildContext context,
    String userId,
    String groupReward,
    String groupCurrency,
  ) async {
    isPaying = true;
    notifyListeners();
    Navigator.of(context).pop();
    try {
      final clientSecret = await FirebaseFunctions.instance
          .httpsCallable('StripePayEndPointMethodIdCreateGroup')
          .call(
        {
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
    } on StripeException catch (e) {
      isPaying = false;
      notifyListeners();
      throw Exception('Payment failed');
    }
    isPaying = false;
    notifyListeners();
  }

  Future<void> initPaymentJoinGroup(
    String groupCode,
    String userId,
  ) async {
    isPaying = true;
    notifyListeners();
    try {
      final clientSecret = await FirebaseFunctions.instance
          .httpsCallable('StripePayEndPointMethodIdJoinGroup')
          .call(
        {
          'groupCode': groupCode,
          'userId': userId,
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
                amount: (clientSecret.data['reward'] / 100).toString(),
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
      isPaying = false;
    }  on StripeException catch (e) {
      isPaying = false;
      notifyListeners();
      throw Exception('Payment failed');
    }
    notifyListeners();
  }
}
