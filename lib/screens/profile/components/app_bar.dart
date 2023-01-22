import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/large_body.dart';
import 'package:groupup/core/widgets/texts/static_text.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/profile/components/other_options.dart';
import 'package:groupup/core/widgets/buttons/button.dart';

class AppBarProfile extends StatelessWidget with PreferredSizeWidget {
  const AppBarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: const StaticText(
        text: 'Profile',
        fontFamily: 'Montserrat-SemiBold',
        fontSize: TextSize.subTitle,
      ),
      centerTitle: false,
      actions: [
        Align(
          alignment: Alignment.center,
          child: ButtonCommonStyle(
              onPressed: () {
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
                              children: const [
                                SizedBox(
                                    height: 240, child: OtherOptionsProfile()),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              child: Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: SizedBox(
                  height: Insets.xl,
                  width: Insets.xl,
                  child: SvgPicture.asset(
                    'assets/icons/ellipsis.svg',
                    color: Colors.black,
                  ),
                ),
              )),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
