// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../design-system.dart';
import '../../screens/home/components/next_button.dart';
import '../widgets/texts/static_text.dart';
import 'create_group_provider.dart';
import 'mix_panel_provider.dart';

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
    try {
      final listPaymentMethods = await FirebaseFunctions.instance
          .httpsCallable('ListPaymentMethods')
          .call(
        {
          'userId': userId,
        },
      );
      final clientSecret = await FirebaseFunctions.instance
          .httpsCallable('StripePayEndPointMethodIdCreateGroup')
          .call(
        {
          'userId': userId,
          'groupReward': groupReward,
          'groupCurrency': groupCurrency,
          'paymentMethodId': listPaymentMethods.data['paymentMethodId'],
        },
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret.data['clientSecret'],
          applePay: PaymentSheetApplePay(
            merchantCountryCode:
                NumberFormat.simpleCurrency(name: clientSecret.data['currency'])
                    .locale
                    .split('_')
                    .last,
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

  Future<String> initPaymentJoinGroup(
    String groupCode,
    String userId,
  ) async {
    isPaying = true;
    notifyListeners();
    try {
      final listPaymentMethods = await FirebaseFunctions.instance
          .httpsCallable('ListPaymentMethods')
          .call(
        {
          'userId': userId,
        },
      );
      final clientSecret = await FirebaseFunctions.instance
          .httpsCallable('StripePayEndPointMethodIdJoinGroup')
          .call(
        {
          'groupCode': groupCode,
          'userId': userId,
          'paymentMethodId': listPaymentMethods.data['paymentMethodId'],
        },
      );
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'GroupUp',
          setupIntentClientSecret:
              'sk_test_51MXufcIXmdKwNYjDzpHrTwv42aY8LErRVMtLgYyFS79jzbXnuFgEvyFBV0XO7vms9VgQo8zLIEPWFPBS6M3xgJTM00N4hMsZ8H',
          paymentIntentClientSecret: clientSecret.data['clientSecret'],
          applePay: PaymentSheetApplePay(
            merchantCountryCode:
                NumberFormat.simpleCurrency(name: clientSecret.data['currency'])
                    .locale
                    .split('_')
                    .last,
            paymentSummaryItems: [
              ApplePayCartSummaryItem.immediate(
                label: 'Reward',
                amount: (clientSecret.data['reward'] / 100).toString(),
              )
            ],
          ),
          googlePay: PaymentSheetGooglePay(
            merchantCountryCode:
                NumberFormat.simpleCurrency(name: clientSecret.data['currency'])
                    .locale
                    .split('_')
                    .last,
            currencyCode:
                NumberFormat.simpleCurrency(name: clientSecret.data['currency'])
                    .currencyName,
            testEnv: true,
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

  Future<void> savedCardConfirmCardCreateGroup(
    BuildContext context,
    String groupReward,
    String groupCurrency,
    String paymentMethodId,
    String groupCode,
  ) async {
    final appLocalizations = AppLocalizations.of(context);
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext newContext) {
        return AlertDialog(
          title: StaticText(
            text: appLocalizations.confirm,
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: StaticText(
              text: appLocalizations.confirmCard,
              maxLines: 2,
              textAlign: TextAlign.center,
              fontSize: TextSize.mBody,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: appLocalizations.no,
              textColor: Colors.red,
              borderColor: Colors.transparent,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                    eventName: 'Cancel Create Group Paying with Saved Card');
                Navigator.of(context).pop();
              },
              color: Colors.transparent,
              height: 40,
              width: 140,
            ),
            NextButton(
              text: appLocalizations.yes,
              borderColor: kPrimaryColor,
              onPressed: () async {
                Navigator.of(newContext).pop();
                final navigatorState = Navigator.of(context);
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Create Group Paying with Saved Card');
                final user =
                    Provider.of<AuthProvider>(context, listen: false).user;
                if (user == null) {
                  return;
                }
                final createGroupProvider =
                    Provider.of<CreateGroupProvider>(context, listen: false);
                isPaying = true;
                notifyListeners();
                try {
                  final paymentIntentId = await FirebaseFunctions.instance
                      .httpsCallable('StripePayEndPointMethodIdCreateGroup')
                      .call(
                    {
                      'userId': user.id,
                      'groupReward': groupReward,
                      'groupCurrency': groupCurrency,
                      'paymentMethodId': paymentMethodId,
                    },
                  );
                  await createGroupProvider.createGroup(user);
                  isPaying = false;
                  await addPaymentIntentId(
                    paymentIntentId.data['paymentIntentId'],
                    createGroupProvider.newGroup.groupCode,
                  );
                } on FirebaseFunctionsException catch (e) {
                  isPaying = false;
                  debugPrint(e.toString());
                }
                notifyListeners();
                navigatorState.pop();
              },
              height: 40,
              width: 140,
            ),
          ],
        );
      },
    );
  }

  Future<void> savedCardConfirmCardJoinGroup(
    BuildContext context,
    String groupCode,
    String paymentMethodId,
  ) async {
    final appLocalizations = AppLocalizations.of(context);
    await showCupertinoDialog(
      context: context,
      builder: (BuildContext newContext) {
        return AlertDialog(
          title: StaticText(
            text: appLocalizations.confirm,
            textAlign: TextAlign.center,
            fontFamily: 'Montserrat-SemiBold',
            fontSize: TextSize.lBody,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: StaticText(
              text: appLocalizations.confirmCard,
              maxLines: 2,
              textAlign: TextAlign.center,
              fontSize: TextSize.mBody,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            NextButton(
              text: appLocalizations.no,
              textColor: Colors.red,
              borderColor: Colors.transparent,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                    eventName: 'Cancel Join Group Paying with Saved Card');
                Navigator.of(context).pop();
              },
              color: Colors.transparent,
              height: 40,
              width: 140,
            ),
            NextButton(
              text: appLocalizations.yes,
              borderColor: kPrimaryColor,
              onPressed: () async {
                Navigator.of(newContext).pop();
                final navigatorState = Navigator.of(context);
                Provider.of<MixPanelProvider>(context, listen: false)
                    .logEvent(eventName: 'Join Group Paying with Saved Card');
                final user =
                    Provider.of<AuthProvider>(context, listen: false).user;
                if (user == null) {
                  return;
                }
                final joinGroupProvider =
                    Provider.of<JoinGroupProvider>(context, listen: false);
                isPaying = true;
                notifyListeners();
                try {
                  final paymentIntentId = await FirebaseFunctions.instance
                      .httpsCallable('StripePayEndPointMethodIdJoinGroup')
                      .call(
                    {
                      'groupCode': groupCode,
                      'userId': user.id,
                      'paymentMethodId': paymentMethodId,
                    },
                  );
                  await joinGroupProvider.joinGroup(user);
                  isPaying = false;
                  await addPaymentIntentId(
                    paymentIntentId.data['paymentIntentId'],
                    groupCode,
                  );
                } on FirebaseFunctionsException catch (e) {
                  isPaying = false;
                  debugPrint(e.toString());
                }
                notifyListeners();
                navigatorState.popUntil((route) => route.isFirst);
              },
              height: 40,
              width: 140,
            ),
          ],
        );
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
