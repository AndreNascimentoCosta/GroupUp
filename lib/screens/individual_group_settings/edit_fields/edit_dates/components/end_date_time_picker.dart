import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:provider/provider.dart';

class EndDateTimePicker extends StatefulWidget {
  const EndDateTimePicker({required this.onChanged});

  final void Function(DateTime?) onChanged;

  @override
  State<EndDateTimePicker> createState() => _EndDateTimePickerState();
}

class _EndDateTimePickerState extends State<EndDateTimePicker> {
  DateTime? endDate;

  String _displayText(DateTime? date) {
    if (date != null) {
      return '${date.day}/${date.month}/${date.year}';
    } else {
      return 'Select date';
    }
  }

  Future<DateTime?> pickDate() async {
    return await showDatePicker(
      context: context,
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
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2999),
    );
  }

  String? endDateValidator(value) {
    if (endDate == null) return "Select date";
    return null;
  }
  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: 
      SizedBox(
            height: 70,
            width: 160,
            child: TextFormField(
              controller: createGroupProvider.controllerEndDate,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                prefixIcon: Container(
                  height: Insets.l,
                  width: Insets.l,
                  alignment: Alignment.center,
                  color: Colors.transparent,
                  child: SvgPicture.asset(
                    'assets/icons/date_switch.svg',
                    color: kSecondaryColor,
                    height: Insets.l,
                    width: Insets.l,
                  ),
                ),
                hintText: 'End date',
                hintStyle: const TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize: TextSize.mBody,
                    color: kSecondaryColor),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              ),
              onTap: () async {
                endDate = await pickDate();
                widget.onChanged(endDate);
                createGroupProvider.controllerEndDate.text = _displayText(endDate);
                setState(() {});
              },
              readOnly: true,
              validator: endDateValidator,
              style: const TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: TextSize.mBody,
                color: kSecondaryColor,
              ),
            ),
          ),
    );
  }
}
