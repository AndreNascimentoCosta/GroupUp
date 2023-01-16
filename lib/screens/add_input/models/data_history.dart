import 'package:flutter/material.dart';
import 'package:groupup/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/add_input/models/data_history_bottom_sheet.dart';
import '../../../../constants.dart';

class DataHistoryButton extends StatefulWidget {
  const DataHistoryButton({
    required this.homeViewModel,
    required this.groupModel,
    this.backgroundColor = kPrimaryColor,
  });

  final HomeViewModel homeViewModel;
  final GroupModel groupModel;
  final Color backgroundColor;

  @override
  State<DataHistoryButton> createState() => _DataHistoryButtonState();
}

class _DataHistoryButtonState extends State<DataHistoryButton> {
  @override
  Widget build(BuildContext context) {
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
                // showModalBottomSheet(
                //   isScrollControlled: true,
                //   context: context,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(Insets.m),
                //   ),
                //   builder: (context) {
                //     return BuilderBottomSheet(
                //       height: 500,
                //       child: DataHistoryBottomSheet(
                //         userInputData:
                //             widget.groupModel.meParticipant.inputData,
                //       ),
                //     );
                //   },
                // );
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
