import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:groupup/core/providers/add_input_provider.dart';
import 'package:groupup/core/providers/instagrammable_provider.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/core/providers/storage_provider.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/providers/join_group_provider.dart';
import 'package:groupup/core/providers/auth_provider.dart';
import 'package:groupup/core/providers/phone_auth_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/providers/stripe_payment_provider.dart';
import 'package:groupup/l10n/l10n.dart';
import 'package:groupup/screens/onboarding/pages/onboarding_page_view_screen.dart';
import 'package:groupup/core/theme/theme_data.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'screens/force_update/screens/force_update_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate(
    webRecaptchaSiteKey: 'recaptcha-v3-site-key',
  );

  await SentryFlutter.init(
    (options) => {
      options.dsn =
          'https://0aa61fd755844cc1bdac24bceebd7124@o4504561838522368.ingest.sentry.io/4504561860345856',
      options.tracesSampleRate = 1.0,
      options.attachScreenshot = true,
      options.enableAutoSessionTracking = true,
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
            ListenableProvider(
              create: (context) => MixPanelProvider(
                mixpanel: Mixpanel.init(
                  '88935fffe276a4ba87e683e9f0ba3c63',
                  trackAutomaticEvents: true,
                  optOutTrackingDefault: !kReleaseMode,
                ),
              ),
            ),
          ],
          child: MaterialApp(
            title: 'GroupUp',
            theme: themeData,
            supportedLocales: L10n.all,
            navigatorObservers: [
              SentryNavigatorObserver(),
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
            ],
            home: FutureBuilder<FirebaseRemoteConfig>(
              future: setupRemoteConfig(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }
                if (snapshot.data == null) {
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  );
                }
                return FutureBuilder<PackageInfo>(
                  future: PackageInfo.fromPlatform(),
                  builder: (context, snapshotPlatform) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }
                    if (snapshot.data == null) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator.adaptive(),
                        ),
                      );
                    }
                    bool needsUpdate() {
                      final List<int>? currentVersion = snapshotPlatform
                          .data?.version
                          .split('.')
                          .map((String number) => (int.tryParse(number)) ?? 0)
                          .toList();
                      final List<int>? enforcedVersion = snapshot.data
                          ?.getString('minimalVersionName')
                          .split('.')
                          .map((String number) => (int.tryParse(number)) ?? 0)
                          .toList();
                      for (int i = 0; i < 3; i++) {
                        if (enforcedVersion == null || currentVersion == null) {
                          return false;
                        }
                        if (enforcedVersion[i] > currentVersion[i]) return true;
                      }
                      return false;
                    }

                    if (needsUpdate() == true) {
                      return const ForceUpdateScreen();
                    } else {
                      return const OnboardingPageViewScreen();
                    }
                  },
                );
              },
            ),
          ),
        ),
      ),
    ),
  );
}

Future<FirebaseRemoteConfig> setupRemoteConfig() async {
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.fetchAndActivate();
  return remoteConfig;
}
