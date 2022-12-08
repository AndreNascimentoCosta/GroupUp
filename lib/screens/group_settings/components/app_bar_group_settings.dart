import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';

class AppBarGroupSettings extends StatelessWidget with PreferredSizeWidget {
  const AppBarGroupSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
          vertical: kDefaultPadding,
        ),
        child: Row(
          children: const [
            ImageIcon(
              AssetImage(
                'assets/icons/arrow_left.png',
              ),
              size: kDefaultPadding,
            ),
            SizedBox(
              width: kDefaultPadding * 3,
            ),
            Text(
              'Group settings',
              style: TextStyle(
                fontFamily: 'Montserrat-Bold',
                fontSize: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
