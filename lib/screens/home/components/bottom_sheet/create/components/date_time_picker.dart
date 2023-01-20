import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/create_group_provider.dart';
import 'package:provider/provider.dart';

class DateTimePicker extends StatefulWidget {
  const DateTimePicker({required this.onChanged});

  final void Function(DateTime?, DateTime?) onChanged;

  @override
  State<DateTimePicker> createState() => _DateTimePickerState();
}

class _DateTimePickerState extends State<DateTimePicker> {
  DateTime? startDate, endDate;

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

  String? startDateValidator(value) {
    if (startDate == null) return "Select date";
    return null;
  }

  String? endDateValidator(value) {
    if (startDate != null && endDate == null) {
      return "Select both data";
    }
    if (endDate == null) return "Select the date";
    if (startDate == null) return null;
    if ((endDate!.isBefore(startDate!))) {
      return "Must be after Start Date";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: 
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
            width: 160,
            child: TextFormField(
              controller: createGroupProvider.controllerStartDate,
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
                hintText: startDate == null ? 'Start date' : _displayText(startDate),
                hintStyle: const TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize: TextSize.mBody,
                    color: kSecondaryColor),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              ),
              onTap: () async {
                startDate = await pickDate();
                widget.onChanged(startDate, endDate);
                createGroupProvider.controllerStartDate.text = _displayText(startDate);
                setState(() {});
              },
              readOnly: true,
              validator: startDateValidator,
              style: const TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: TextSize.mBody,
                color: kSecondaryColor,
              ),
            ),
          ),
          const SizedBox(width: Insets.s),
          const Padding(
            padding: EdgeInsets.only(top: Insets.s),
            child: StaticText(text: '-', fontSize: 24, color: kSecondaryColor),
          ),
          const SizedBox(width: Insets.s),
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
                hintText: endDate == null ? 'End date' : _displayText(endDate),
                hintStyle: const TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize: TextSize.mBody,
                    color: kSecondaryColor),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              ),
              onTap: () async {
                endDate = await pickDate();
                widget.onChanged(startDate, endDate);
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
        ],
      ),
    );
  }
}
