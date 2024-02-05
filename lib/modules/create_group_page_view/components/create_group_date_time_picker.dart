import 'package:flutter/material.dart';
import 'package:groupup/core/constants/constants.dart';
import 'package:groupup/core/extensions/gp_size_extension.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:groupup/core/utils/colors/gp_colors.dart';
import 'package:groupup/core/utils/icons/gp_icons.dart';
import 'package:groupup/core/widgets/icons/gp_icon.dart';
import 'package:groupup/core/constants/design_system.dart';
import 'package:groupup/core/widgets/texts/gp_text_body.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CreateGroupDateTimePicker extends StatefulWidget {
  const CreateGroupDateTimePicker({required this.onChanged});

  final void Function(DateTime?, DateTime?) onChanged;

  @override
  State<CreateGroupDateTimePicker> createState() =>
      _CreateGroupDateTimePickerState();
}

class _CreateGroupDateTimePickerState extends State<CreateGroupDateTimePicker> {
  DateTime? startDate, endDate;

  String _displayText(DateTime? date) {
    if (date != null) {
      return DateFormat.yMd(Localizations.localeOf(context).toLanguageTag())
          .format(date);
    } else {
      return AppLocalizations.of(context)!.selectDate;
    }
  }

  Future<DateTime?> _pickDate() async {
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

  String? _startDateValidator(value) {
    if (startDate == null) return AppLocalizations.of(context)!.selectDate;
    return null;
  }

  String? _endDateValidator(value) {
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
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    final appLocalizations = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
            width: context.isVerySmallScreen
                ? 130
                : context.isSmallScreen
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
                  color: GPColors.transparent,
                  child: const GPIcon(
                    GPIcons.dateSwitch,
                    color: GPColors.secondaryColor,
                    height: Insets.l,
                    width: Insets.l,
                  ),
                ),
                hintText: startDate == null
                    ? appLocalizations.startDate
                    : _displayText(startDate),
                hintStyle: TextStyle(
                  fontFamily: 'Montserrat-Medium',
                  fontSize: context.isVerySmallScreen
                      ? TextSize.xsBody
                      : TextSize.mBody,
                  color: GPColors.secondaryColor,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 2,
                ),
              ),
              onTap: () async {
                startDate = await _pickDate();
                widget.onChanged(startDate, endDate);
                createGroupProvider.controllerStartDate.text =
                    _displayText(startDate);
                setState(() {});
              },
              readOnly: true,
              validator: _startDateValidator,
              style: TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: context.isVerySmallScreen
                    ? TextSize.xsBody
                    : TextSize.mBody,
                color: GPColors.secondaryColor,
              ),
            ),
          ),
          SizedBox(width: context.isSmallScreen ? Insets.xs : Insets.s),
          const Padding(
            padding: EdgeInsets.only(top: Insets.s),
            child: GPTextBody(
              text: '-',
              color: GPColors.secondaryColor,
              fontSize: 24,
            ),
          ),
          SizedBox(width: context.isSmallScreen ? Insets.xs : Insets.s),
          SizedBox(
            width: context.isVerySmallScreen
                ? 130
                : context.isSmallScreen
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
                  color: GPColors.transparent,
                  child: const GPIcon(
                    GPIcons.dateSwitch,
                    color: GPColors.secondaryColor,
                    height: Insets.l,
                    width: Insets.l,
                  ),
                ),
                hintText: endDate == null
                    ? appLocalizations.endDate
                    : _displayText(endDate),
                hintStyle: TextStyle(
                  fontFamily: 'Montserrat-Medium',
                  fontSize: context.isVerySmallScreen
                      ? TextSize.xsBody
                      : TextSize.mBody,
                  color: GPColors.secondaryColor,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              ),
              onTap: () async {
                endDate = await _pickDate();
                widget.onChanged(startDate, endDate);
                createGroupProvider.controllerEndDate.text = _displayText(
                  endDate,
                );
                setState(() {});
              },
              readOnly: true,
              validator: _endDateValidator,
              style: TextStyle(
                fontFamily: 'Montserrat-Medium',
                fontSize: context.isVerySmallScreen
                    ? TextSize.xsBody
                    : TextSize.mBody,
                color: GPColors.secondaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
