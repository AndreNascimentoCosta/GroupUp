// ignore_for_file: override_on_non_overriding_member

import 'package:flutter/foundation.dart';
import 'package:mixpanel_flutter/mixpanel_flutter.dart';

class MixPanelProvider extends ChangeNotifier {
  MixPanelProvider({
    required Future<Mixpanel> mixpanel,
  }) : _mixpanel = mixpanel;

  final Future<Mixpanel> _mixpanel;

  @override
  Future<void> logEvent({
    required String eventName,
    Map<String, dynamic>? properties,
  }) async {
    debugPrint('MixpanelAnalyticsClient.logEvent: $eventName');
    final mixpanel = await _mixpanel;
    mixpanel.track(eventName, properties: properties);
  }

  @override
  Future<void> setUserId(String userId) async {
    debugPrint('MixpanelAnalyticsClient.setUserId: $userId');
    final mixpanel = await _mixpanel;
    mixpanel.identify(userId);
  }

  @override
  Future<void> removeUser() async {
    debugPrint('MixpanelAnalyticsClient.removeUser');
    final mixpanel = await _mixpanel;
    mixpanel.reset();
  }
}
