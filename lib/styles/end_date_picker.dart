import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/mix_panel_provider.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/group_model.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:provider/provider.dart';

class EndDatePicker extends StatefulWidget {
  const EndDatePicker({required this.groups});

  final GroupModel groups;

  @override
  State<EndDatePicker> createState() => _EndDatePickerState();
}

class _EndDatePickerState extends State<EndDatePicker> {
  @override
  Widget build(BuildContext context) {
    return ButtonCommonStyle(
      onPressed: () async {
        Provider.of<MixPanelProvider>(context, listen: false)
            .logEvent(eventName: 'End Date Picker');
        DateTime? newDate = await showDatePicker(
          builder: (context, child) {
            return Theme(
              data: ThemeData.light().copyWith(
                dialogTheme: const DialogTheme(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ),
                ),
                primaryColor: kPrimaryColor,
                colorScheme: const ColorScheme.light(primary: kPrimaryColor),
                buttonTheme:
                    const ButtonThemeData(textTheme: ButtonTextTheme.primary),
              ),
              child: child!,
            );
          },
          context: context,
          initialDate: widget.groups.endDate?.toUtc() ?? DateTime.now().toUtc(),
          firstDate: DateTime(2010).toUtc(),
          lastDate: DateTime(2100).toUtc(),
        );
        if (newDate == null) return;

        setState(
          () {
            widget.groups.endDate = newDate.toUtc();
          },
        );
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
              '${widget.groups.endDate?.toUtc().day}/${widget.groups.endDate?.toUtc().month}/${widget.groups.endDate?.toUtc().year}',
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
