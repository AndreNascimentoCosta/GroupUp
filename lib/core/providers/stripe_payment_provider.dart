import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_navigator_extension.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/widgets/buttons/gp_button.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:groupup/core/widgets/texts/gp_text_header.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              primary: GPColors.black,
              background: GPColors.white,
              secondaryText: GPColors.black,
              primaryText: GPColors.white,
              componentText: GPColors.black,
              placeholderText: GPColors.secondaryColor,
              componentBackground: GPColors.white,
              componentBorder: GPColors.black,
              componentDivider: GPColors.black,
              icon: GPColors.black,
              error: GPColors.red,
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  text: GPColors.white,
                  background: GPColors.primaryColor,
                ),
                dark: PaymentSheetPrimaryButtonThemeColors(
                  text: GPColors.white,
                  background: GPColors.primaryColor,
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
              primary: GPColors.black,
              background: GPColors.white,
              secondaryText: GPColors.black,
              primaryText: GPColors.white,
              componentText: GPColors.black,
              placeholderText: GPColors.secondaryColor,
              componentBackground: GPColors.white,
              componentBorder: GPColors.black,
              componentDivider: GPColors.black,
              icon: GPColors.black,
              error: GPColors.red,
            ),
            primaryButton: PaymentSheetPrimaryButtonAppearance(
              colors: PaymentSheetPrimaryButtonTheme(
                light: PaymentSheetPrimaryButtonThemeColors(
                  text: GPColors.white,
                  background: GPColors.primaryColor,
                ),
                dark: PaymentSheetPrimaryButtonThemeColors(
                  text: GPColors.white,
                  background: GPColors.primaryColor,
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
          title: GPTextHeader(
            text: appLocalizations.confirm,
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GPTextBody(
              text: appLocalizations.confirmCard,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            GPButton(
              text: appLocalizations.no,
              textColor: GPColors.red,
              borderColor: GPColors.transparent,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                    eventName: 'Cancel Create Group Paying with Saved Card');
                context.pop();
              },
              color: GPColors.transparent,
              height: 40,
              width: 140,
            ),
            GPButton(
              text: appLocalizations.yes,
              borderColor: GPColors.primaryColor,
              onPressed: () async {
                Navigator.of(newContext).pop();
                final navigatorState = context;
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
          title: GPTextHeader(
            text: appLocalizations.confirm,
            textAlign: TextAlign.center,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          content: Padding(
            padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: GPTextBody(
              text: appLocalizations.confirmCard,
              maxLines: 2,
              textAlign: TextAlign.center,
            ),
          ),
          actionsAlignment: MainAxisAlignment.center,
          contentPadding: const EdgeInsets.only(top: 20, bottom: 20),
          actions: [
            GPButton(
              text: appLocalizations.no,
              textColor: GPColors.red,
              borderColor: GPColors.transparent,
              onPressed: () {
                Provider.of<MixPanelProvider>(context, listen: false).logEvent(
                    eventName: 'Cancel Join Group Paying with Saved Card');
                context.pop();
              },
              color: GPColors.transparent,
              height: 40,
              width: 140,
            ),
            GPButton(
              text: appLocalizations.yes,
              borderColor: GPColors.primaryColor,
              onPressed: () async {
                Navigator.of(newContext).pop();
                final navigatorState = context;
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
