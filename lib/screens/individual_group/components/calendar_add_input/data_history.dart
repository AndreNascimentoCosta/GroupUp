import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/home/components/bottom_sheet/sign_up/auth_provider.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/data_history_bottom_sheet.dart';
import 'package:groupup/screens/individual_group/components/individual_group_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../constants.dart';

class DataHistoryButton extends StatefulWidget {
  const DataHistoryButton({
    required this.homeViewModel,
    this.backgroundColor = kPrimaryColor,
  });

  final HomeViewModel homeViewModel;
  final Color backgroundColor;

  @override
  State<DataHistoryButton> createState() => _DataHistoryButtonState();
}

class _DataHistoryButtonState extends State<DataHistoryButton> {
  @override
  Widget build(BuildContext context) {
    final group = Provider.of<IndividualGroupProvider>(context).group;
    final user = Provider.of<AuthProvider>(context).user;
    if (group == null) {
      return const CircularProgressIndicator(color: kPrimaryColor);
    }
    return SizedBox(
      height: 75,
      width: 75,
      child: FittedBox(
        child: ValueListenableBuilder(
          valueListenable: widget.homeViewModel.isEditing,
          builder: ((context, value, child) {
            return FloatingActionButton(
              heroTag: 'btn6',
              highlightElevation: 0,
              onPressed: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Insets.m),
                  ),
                  builder: (context) {
                    return BuilderBottomSheet(
                      height: 500,
                      child: DataHistoryBottomSheet(
                        userInputData:
                            group.participantsData.firstWhere((element) => element.uid == user?.id).inputData,
                      ),
                    );
                  },
                );
              },
              backgroundColor: widget.backgroundColor,
              elevation: 0,
              child: const Icon(Icons.history, size: 30),
            );
          }),
        ),
      ),
    );
  }
}
