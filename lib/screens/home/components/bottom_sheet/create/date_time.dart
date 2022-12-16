import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

class DateTimeSwicth extends StatefulWidget {
  const DateTimeSwicth({super.key});

  @override
  State<DateTimeSwicth> createState() => _DateTimeSwicthState();
}

class _DateTimeSwicthState extends State<DateTimeSwicth> {
  DateTime startDate = DateTime(2022, 09, 15);
  DateTime endDate = DateTime(2022, 12, 31);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: Row(
        children: [
          ButtonCommonStyle(
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
                borderRadius: BorderRadius.circular(Insets.s),
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
          const SizedBox(width: Insets.s),
          const StandardTextStyle(text: '-', fontSize: 24, color: kSecondaryColor),
          const SizedBox(width: Insets.s),
          ButtonCommonStyle(
            onPressed: () async {
              DateTime? newDate = await showDatePicker(
                context: context,
                initialDate: endDate,
                firstDate: DateTime(2010),
                lastDate: DateTime(2050),
              );
              if (newDate == null) return;

              setState(() {
                endDate = newDate;
              });
            },
            child: Container(
              height: 45,
              width: 140,
              decoration: BoxDecoration(
                border: Border.all(color: kSecondaryColor),
                borderRadius: BorderRadius.circular(Insets.s),
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
                    '${endDate.day}/${endDate.month}/${endDate.year}',
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
        ],
      ),
    );
  }
}
