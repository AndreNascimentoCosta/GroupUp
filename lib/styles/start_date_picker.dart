import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

class StartDatePicker extends StatefulWidget {
  const StartDatePicker({required this.groups});

  final GroupModel groups;

  @override
  State<StartDatePicker> createState() => _StartDatePickerState();
}

class _StartDatePickerState extends State<StartDatePicker> {
  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () async {
        DateTime? newDate = await showDatePicker(
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                dialogTheme: const DialogTheme(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15)))),
                primaryColor: kPrimaryColor,
                colorScheme: const ColorScheme.light(primary: kPrimaryColor),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
          context: context,
          initialDate: widget.groups.startDate ?? DateTime.now(),
          firstDate: DateTime(2010),
          lastDate: DateTime(2050),
        );
        if (newDate == null) return;

        setState(() {
          widget.groups.startDate = newDate;
        });
      },
      child: Container(
        height: 45,
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(color: kSecondaryColor),
          borderRadius: BorderRadius.circular(10),
          color: Colors.transparent,
        ),
        child: Row(
          children: [
            const SizedBox(width: Insets.s),
            SvgPicture.asset(
                'assets/icons/date_switch.svg',
              height: Insets.l,
              width: Insets.l,
              color: kSecondaryColor,
            ),
            const SizedBox(width: Insets.l * 2),
            Text(
              '${widget.groups.startDate?.day}/${widget.groups.startDate?.month}/${widget.groups.startDate?.year}',
              style: const TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: TextSize.mBody,
                color: kSecondaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
