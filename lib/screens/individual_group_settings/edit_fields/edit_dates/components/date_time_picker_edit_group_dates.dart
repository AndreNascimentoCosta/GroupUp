import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/edit_group_dates_provider.dart';
import 'package:groupup/core/providers/individual_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design-system.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DateTimePickerEditGroupDates extends StatefulWidget {
  const DateTimePickerEditGroupDates({required this.onChanged});

  final void Function(DateTime?, DateTime?) onChanged;

  @override
  State<DateTimePickerEditGroupDates> createState() =>
      _DateTimePickerEditGroupDatesState();
}

class _DateTimePickerEditGroupDatesState
    extends State<DateTimePickerEditGroupDates> {
  DateTime? startDate, endDate;

  String _displayText(DateTime? date) {
    if (date != null) {
      return DateFormat.yMd(Localizations.localeOf(context).toLanguageTag())
          .format(date);
    } else {
      return AppLocalizations.of(context)!.selectDate;
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
            primaryColor: GPColors.primaryColor,
            colorScheme:
                const ColorScheme.light(primary: GPColors.primaryColor),
            buttonTheme:
                const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
  }

  String? startDateValidator(value) {
    if (startDate == null) return AppLocalizations.of(context)!.selectDate;
    return null;
  }

  String? endDateValidator(value) {
    final appLocalizations = AppLocalizations.of(context)!;
    if (startDate != null && endDate == null) {
      return appLocalizations.selectBothDates;
    }
    if (endDate == null) return appLocalizations.selectDate;
    if (startDate == null) return null;
    if ((endDate!.isBefore(startDate!))) {
      return appLocalizations.endDateMustBeAfterStartDate;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final editGroupDatesProvider = Provider.of<EditGroupDatesProvider>(context);
    final individualGroupProvider =
        Provider.of<IndividualGroupProvider>(context);
    final screenHeight = context.screenHeight;
    final screenWidth = context.screenWidth;
    final isSmallScreen = screenHeight < 800 || screenWidth < 350;
    final isVerySmallScreen = screenHeight < 600 || screenWidth < 350;
    if (individualGroupProvider.group == null) {
      return const SizedBox();
    }
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
              controller: editGroupDatesProvider.controllerStartDate,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                prefixIcon: Container(
                  height: Insets.l,
                  width: Insets.l,
                  alignment: Alignment.center,
                  color: GPColors.transparent,
                  child: const GPIcon(
                    GPIcons.dateSwitch,
                    color: GPColors.secondaryColor,
                    height: Insets.l,
                    width: Insets.l,
                  ),
                ),
                hintText: DateFormat.yMd(
                  Localizations.localeOf(context).toLanguageTag(),
                ).format(
                  individualGroupProvider.group!.startDate ?? DateTime.now(),
                ),
                hintStyle: TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize:
                        isVerySmallScreen ? TextSize.xsBody : TextSize.mBody,
                    color: GPColors.secondaryColor),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                ),
              ),
              onTap: () async {
                startDate = await pickDate();
                editGroupDatesProvider.controllerStartDate.text =
                    _displayText(startDate);
                setState(() {
                  widget.onChanged(startDate, endDate);
                });
              },
              readOnly: true,
              validator: startDateValidator,
              style: TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: isVerySmallScreen ? TextSize.xsBody : TextSize.mBody,
                color: GPColors.secondaryColor,
              ),
            ),
          ),
          SizedBox(width: isSmallScreen ? Insets.xs : Insets.s),
          const Padding(
            padding: EdgeInsets.only(top: Insets.s),
            child: GPTextBody(
              text: '-',
              color: GPColors.secondaryColor,
              fontSize: 24,
            ),
          ),
          SizedBox(width: isSmallScreen ? Insets.xs : Insets.s),
          SizedBox(
            width: isVerySmallScreen
                ? 130
                : isSmallScreen
                    ? 150
                    : 160,
            child: TextFormField(
              controller: editGroupDatesProvider.controllerEndDate,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: InputDecoration(
                prefixIcon: Container(
                  height: Insets.l,
                  width: Insets.l,
                  alignment: Alignment.center,
                  color: GPColors.transparent,
                  child: const GPIcon(
                    GPIcons.dateSwitch,
                    color: GPColors.secondaryColor,
                    height: Insets.l,
                    width: Insets.l,
                  ),
                ),
                hintText: DateFormat.yMd(
                  Localizations.localeOf(context).toLanguageTag(),
                ).format(
                  individualGroupProvider.group!.endDate ?? DateTime.now(),
                ),
                hintStyle: TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize:
                        isVerySmallScreen ? TextSize.xsBody : TextSize.mBody,
                    color: GPColors.secondaryColor),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              ),
              onTap: () async {
                endDate = await pickDate();
                editGroupDatesProvider.controllerEndDate.text = _displayText(
                  endDate,
                );
                setState(
                  () {
                    widget.onChanged(startDate, endDate);
                  },
                );
              },
              readOnly: true,
              validator: endDateValidator,
              style: TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: isVerySmallScreen ? TextSize.xsBody : TextSize.mBody,
                color: GPColors.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
