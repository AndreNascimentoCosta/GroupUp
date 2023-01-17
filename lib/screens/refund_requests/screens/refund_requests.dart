import 'package:flutter/material.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/screens/refund_requests/components/app_bar.dart';
import 'package:groupup/screens/refund_requests/components/body.dart';

class RefundRequestsScreen extends StatelessWidget {
  const RefundRequestsScreen({required this.groupsData});

  final List<GroupModel> groupsData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const AppBarRefundRequests(),
      body: Column(
        children: [
          BodyRefundRequests(groupsData: groupsData,),
        ],
      ),
    );
  }
}