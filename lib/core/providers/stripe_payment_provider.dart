import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:provider/provider.dart';

enum PaymentStatus { initial, loading, success, error }

class StripePaymentProvider extends ChangeNotifier {
  final PaymentStatus status;
  bool isPaying = false;

  StripePaymentProvider({this.status = PaymentStatus.initial});

  Future<String> initPaymentCreateGroup(
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
      isPaying = false;
      notifyListeners();
      return clientSecret.data['paymentIntentId'];
    } on StripeException {
      isPaying = false;
      notifyListeners();
      throw Exception('Payment failed');
    }
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
          merchantDisplayName: 'GroupUp',
          paymentIntentClientSecret: clientSecret.data['clientSecret'],
          applePay: PaymentSheetApplePay(
            merchantCountryCode: 'BR',
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
      await addPaymentIntentId(
        clientSecret.data['paymentIntentId'],
        groupCode,
      );
      isPaying = false;
    } on StripeException {
      isPaying = false;
      notifyListeners();
      throw Exception('Payment failed');
    }
    notifyListeners();
  }

  Future<void> addPaymentIntentId(
    String paymentIntentId,
    String groupCode,
  ) async {
    final documents = await FirebaseFirestore.instance
        .collection('groups')
        .where('groupCode', isEqualTo: groupCode)
        .get();
    if (documents.docs.isEmpty) return;
    final groupId = documents.docs.first.id;
    await FirebaseFirestore.instance.collection('groups').doc(groupId).update(
      {
        'paymentIntentIds': FieldValue.arrayUnion(
          [paymentIntentId],
        ),
      },
    );
  }

  Future<void> deleteConnectedAccount(
      BuildContext context, String accountId) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user == null) return;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(authProvider.user?.id)
        .update({'stripeAccountId': ''});
    await authProvider.getUser();
  }
}
