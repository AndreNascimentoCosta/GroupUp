import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../../../core/providers/individual_group_provider.dart';

class DateTimePickerCreateGroup extends StatefulWidget {
  const DateTimePickerCreateGroup({required this.onChanged});

  final void Function(DateTime?, DateTime?) onChanged;

  @override
  State<DateTimePickerCreateGroup> createState() =>
      _DateTimePickerCreateGroupState();
}

class _DateTimePickerCreateGroupState extends State<DateTimePickerCreateGroup> {
  DateTime? startDate, endDate;

  String _displayText(DateTime? date) {
    if (date != null) {
      return DateFormat.yMd(Localizations.localeOf(context).toLanguageTag())
          .format(date.toUtc());
    } else {
      return AppLocalizations.of(context).selectDate;
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
      initialDate: DateTime.now().toUtc(),
      firstDate: DateTime.now().toUtc(),
      lastDate: DateTime(2999).toUtc(),
    );
  }

  String? startDateValidator(value) {
    if (startDate == null) return AppLocalizations.of(context).selectDate;
    return null;
  }

  String? endDateValidator(value) {
    final appLocalizations = AppLocalizations.of(context);
    if (startDate != null && endDate == null) {
      return appLocalizations.selectBothDates;
    }
    if (endDate == null) return appLocalizations.selectDate;
    if (startDate == null) return null;
    if ((endDate!.toUtc().isBefore(startDate!.toUtc()))) {
      return appLocalizations.endDateMustBeAfterStartDate;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    final appLocalizations = AppLocalizations.of(context);
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 350;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
            width: isVerySmallScreen
                ? 130
                : isSmallScreen
                    ? 150
                    : 160,
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
                hintText: startDate == null
                    ? appLocalizations.startDate
                    : _displayText(startDate),
                hintStyle: TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize:
                        isVerySmallScreen ? TextSize.xsBody : TextSize.mBody,
                    color: kSecondaryColor),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                ),
              ),
              onTap: () async {
                startDate = await pickDate();
                widget.onChanged(startDate?.toUtc(), endDate?.toUtc());
                createGroupProvider.controllerStartDate.text =
                    _displayText(startDate?.toUtc());
                setState(() {});
              },
              readOnly: true,
              validator: startDateValidator,
              style: TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: isVerySmallScreen ? TextSize.xsBody : TextSize.mBody,
                color: kSecondaryColor,
              ),
            ),
          ),
          SizedBox(width: isSmallScreen ? Insets.xs : Insets.s),
          const Padding(
            padding: EdgeInsets.only(top: Insets.s),
            child: StaticText(text: '-', fontSize: 24, color: kSecondaryColor),
          ),
          SizedBox(width: isSmallScreen ? Insets.xs : Insets.s),
          SizedBox(
            width: isVerySmallScreen
                ? 130
                : isSmallScreen
                    ? 150
                    : 160,
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
                hintText: endDate == null
                    ? appLocalizations.endDate
                    : _displayText(endDate),
                hintStyle: TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize:
                        isVerySmallScreen ? TextSize.xsBody : TextSize.mBody,
                    color: kSecondaryColor),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              ),
              onTap: () async {
                endDate = await pickDate();
                widget.onChanged(startDate?.toUtc(), endDate?.toUtc());
                createGroupProvider.controllerEndDate.text = _displayText(
                  endDate?.toUtc(),
                );
                setState(() {});
              },
              readOnly: true,
              validator: endDateValidator,
              style: TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: isVerySmallScreen ? TextSize.xsBody : TextSize.mBody,
                color: kSecondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
