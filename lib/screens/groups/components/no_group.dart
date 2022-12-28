import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/buttons/button.dart';
import 'package:groupup/core/widgets/texts/extra_large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/groups/components/stats_no_group.dart';
import 'package:groupup/screens/home/components/bottom_sheet/create/page_view.dart';

class NoGroup extends StatelessWidget {
  const NoGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.725,
        child: Column(
          children: [
            ButtonCommonStyle(
              onPressed: (() {
                showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Insets.m),
                ),
                builder: (context) {
                  return Padding(
                    padding: MediaQuery.of(context).viewInsets,
                    child: Wrap(
                      children: <Widget>[
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: const CreatePageView()), 
                          ],
                        )
                      ],
                    ),
                  );
                });
              }),
              child: Row(
                children: [
                  DottedBorder(
                    borderType: BorderType.Circle,
                    color: kSecondaryColor,
                    dashPattern: const [5, 5],
                    child: const SizedBox(
                      height: 70,
                      width: 70,
                      child: ImageIcon(
                        AssetImage('assets/icons/plus_picture.png'),
                        color: kSecondaryColor,
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(
                      left: kDefaultPadding,
                    ),
                    child: ExtraLargeBody(
                      text: '#NewProject',
                      color: kSecondaryColor,
                    ),
                  ),
                  const Flexible(child: StatsNoGroup()),
                ],
              ),
            ),
            const Spacer(),
            const StaticText(
              text: 'Create or join a new project',
              color: kSecondaryColor,
              fontFamily: 'Montserrat-Medium',
              fontSize: 20,
            ),
          ],
        ),
      ),
    );
  }
}
