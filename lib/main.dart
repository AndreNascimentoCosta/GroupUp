import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/add_input_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/l10n/l10n.dart';
import 'package:groupup/screens/splashscreen/splashscreen.dart';
import 'package:groupup/styles/theme.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = stripePublishableKey;
  Stripe.merchantIdentifier = 'merchant.com.andrecosta.groupup';
  await Stripe.instance.applySettings();
  await SentryFlutter.init(
    (options) => {
      options.dsn =
          'https://0aa61fd755844cc1bdac24bceebd7124@o4504561838522368.ingest.sentry.io/4504561860345856',
      options.tracesSampleRate = 1.0,
      options.attachScreenshot = true,
      options.enableAutoPerformanceTracking = true,
    },
    appRunner: () => runApp(
      SentryScreenshotWidget(
        child: MultiProvider(
          providers: [
            ListenableProvider(
              create: (context) => AuthProvider(),
            ),
            ListenableProvider(
              create: (context) => CreateGroupProvider(),
            ),
            ListenableProvider(
              create: (context) => JoinGroupProvider(),
              lazy: true,
            ),
            ListenableProvider(
              create: (context) => PhoneAuthenProvider(),
            ),
            ListenableProvider(
              create: (context) => StorageProvider(),
            ),
            ListenableProvider(
              create: (context) => IndividualGroupProvider(),
            ),
            ListenableProvider(
              create: (context) => AddInputProvider(),
              lazy: true,
            ),
            ListenableProvider(
              create: (context) => InstagrammableProvider(),
            ),
            ListenableProvider(
              create: (context) => StripePaymentProvider(),
            ),
          ],
          child: MaterialApp(
            title: 'GroupUp',
            theme: themeData,
            supportedLocales: L10n.all,
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,  
            ],
            home: const SplashScreen(),
          ),
        ),
      ),
    ),
  );
}
