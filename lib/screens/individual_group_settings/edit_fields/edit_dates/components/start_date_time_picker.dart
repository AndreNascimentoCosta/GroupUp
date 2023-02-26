import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/core/providers/create_group_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StartDateTimePicker extends StatefulWidget {
  const StartDateTimePicker({required this.onChanged});

  final void Function(DateTime?) onChanged;

  @override
  State<StartDateTimePicker> createState() => _StartDateTimePickerState();
}

class _StartDateTimePickerState extends State<StartDateTimePicker> {
  DateTime? startDate;

  String _displayText(DateTime? date) {
    if (date != null) {
      return '${date.toUtc().day}/${date.toUtc().month}/${date.toUtc().year}';
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
                    borderRadius: BorderRadius.all(Radius.circular(15)))),
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

  @override
  Widget build(BuildContext context) {
    final createGroupProvider = Provider.of<CreateGroupProvider>(context);
    final appLocalizations = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
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
                hintText: appLocalizations.startDate,
                hintStyle: const TextStyle(
                    fontFamily: 'Montserrat-Medium',
                    fontSize: TextSize.mBody,
                    color: kSecondaryColor),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: kDefaultPadding / 2),
              ),
              onTap: () async {
                startDate = await pickDate();
                widget.onChanged(startDate?.toUtc());
                createGroupProvider.controllerStartDate.text =
                    _displayText(startDate?.toUtc());
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
        ],
      ),
    );
  }
}
