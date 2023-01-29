import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/core/widgets/bottom_sheet/bottom_sheet.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/home_view.dart';
import 'package:groupup/screens/individual_group/components/calendar_add_input/add_input.dart';
import 'package:groupup/core/providers/add_input_provider.dart';
import 'package:provider/provider.dart';
import '../../../../../constants.dart';

class AddInputGroupButton extends StatefulWidget {
  const AddInputGroupButton({
    required this.homeViewModel,
    this.backgroundColor = kPrimaryColor,
    this.icon = 'assets/icons/plus.svg',
  });

  final HomeViewModel homeViewModel;
  final Color backgroundColor;
  final String icon;

  @override
  State<AddInputGroupButton> createState() => _AddInputGroupButtonState();
}

class _AddInputGroupButtonState extends State<AddInputGroupButton> {
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
              heroTag: 'btn3',
              highlightElevation: 0,
              onPressed: () {
                Provider.of<AddInputProvider>(context, listen: false).clean();
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(Insets.m),
                  ),
                  builder: (context) {
                    return const BuilderBottomSheet(
                      height: 220,
                      child: AddInput(),
                    );
                  },
                );
              },
              backgroundColor: widget.backgroundColor,
              elevation: 0,
              child: SvgPicture.asset(
                widget.icon,
                height: Insets.l * 1.5,
                width: Insets.l * 1.5,
              ),
            );
          }),
        ),
      ),
    );
  }
}
