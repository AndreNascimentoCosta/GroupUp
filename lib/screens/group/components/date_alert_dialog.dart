import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/models/general_group_info.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

class DateAlertDialogModel extends StatefulWidget {
  const DateAlertDialogModel({
    required this.generalGroupInfoModel,
    required this.title,
  });

  final GeneralGroupInfoModel generalGroupInfoModel;
  final String title;

  @override
  State<DateAlertDialogModel> createState() => _DateAlertDialogModelState();
}

class _DateAlertDialogModelState extends State<DateAlertDialogModel> {
  DateTime startDate = DateTime(2022, 09, 15);
  DateTime endDate = DateTime(2022, 12, 31);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: StandardTextStyle(
        text: widget.title,
        fontSize: TextSize.subTitle,
      ),
      contentPadding: const EdgeInsets.only(
        top: kDefaultPadding,
        bottom: 0,
        right: kDefaultPadding,
        left: kDefaultPadding * 1.25,
      ),
      content: ButtonCommonStyle(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                builder: (context, child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      dialogTheme: const DialogTheme(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15))
                        )
                      ),
                      primaryColor: kPrimaryColor,
                      colorScheme:
                          const ColorScheme.light(primary: kPrimaryColor),
                      buttonTheme: const ButtonThemeData(
                          textTheme: ButtonTextTheme.primary),
                    ),
                    child: child!,
                  );
                },
                context: context,
                initialDate: startDate,
                firstDate: DateTime(2010),
                lastDate: DateTime(2050),
              );
              if (newDate == null) return;

              setState(() {
                startDate = newDate;
              });
            },
            child: Container(
              height: 45,
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(color: kSecondaryColor),
                borderRadius: BorderRadius.circular(10),
                color: Colors.transparent,
              ),
              child: Row(
                children: [
                  const SizedBox(width: Insets.s),
                  const ImageIcon(
                    AssetImage('assets/icons/date_switch.png'),
                    size: 20,
                    color: kSecondaryColor,
                  ),
                  const SizedBox(width: Insets.m),
                  Text(
                    '${startDate.day}/${startDate.month}/${startDate.year}',
                    style: const TextStyle(
                      fontFamily: 'Montserrat-Medium',
                      fontSize: TextSize.mBody,
                      color: kSecondaryColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
      actionsPadding: const EdgeInsets.symmetric(vertical: 0),
      actions: [
        TextButton(
            onPressed: (() {
              Navigator.pop(context);
            }),
            child: const StandardTextStyle(
              text: 'OK',
              fontSize: TextSize.mBody,
              color: kPrimaryColor,
            ))
      ],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    );
    ;
  }
}
