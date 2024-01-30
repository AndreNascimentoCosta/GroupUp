import 'package:flutter/material.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_dates/components/app_bar_edit_group_dates.dart';
import 'package:groupup/core/providers/edit_group_dates_provider.dart';
import 'package:groupup/modules/individual_group_settings/edit_fields/edit_dates/components/body_edit_group_dates.dart';
import 'package:provider/provider.dart';

class EditGroupDatesScreen extends StatelessWidget {
  const EditGroupDatesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    if (group == null) {
      return const Scaffold();
    }
    return ChangeNotifierProvider(
      create: (context) => EditGroupDatesProvider(),
      child: WillPopScope(
        onWillPop: () async {
          return false;
        },
        child: const Scaffold(
          appBar: AppBarEditGroupDates(),
          body: SingleChildScrollView(
            child: EditGroupDatesBody(),
          ),
        ),
      ),
    );
  }
}
