import 'package:flutter/material.dart';
import 'package:groupup/screens/refund_requests/components/app_bar.dart';
import 'package:groupup/screens/refund_requests/components/body.dart';

class RefundRequestsScreen extends StatelessWidget {
  const RefundRequestsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarRefundRequests(),
      body: Column(
        children: const [
          BodyRefundRequests(),
        ],
      ),
    );
  }
}