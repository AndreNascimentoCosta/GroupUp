import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/design-system.dart';
import 'package:groupup/screens/profile/components/others_profile.dart';
import 'package:groupup/styles/button.dart';
import 'package:groupup/styles/text.dart';

class AppBarProfile extends StatelessWidget with PreferredSizeWidget {
  const AppBarProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: const StandardTextStyle(
        text: 'angusmac_41',
        fontFamily: 'Montserrat-Bold',
        fontSize: 20,
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
                                SizedBox(height: 140, child: OthersProfile()),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              child: const Padding(
                padding: EdgeInsets.only(right: kDefaultPadding),
                child: ImageIcon(
                  AssetImage('assets/icons/ellipsis.png'),
                  color: Colors.black,
                ),
              )),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kAppBarHeight);
}
