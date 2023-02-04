import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';
import 'package:groupup/core/widgets/texts/header.dart';


class AppBarInstagrammable extends StatelessWidget with PreferredSizeWidget {
  const AppBarInstagrammable({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Row(
        children: [
          Stack(
            alignment: AlignmentDirectional.centerStart,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50,
                alignment: AlignmentDirectional.center,
                child: const Header(text: 'GroupUp'),
              ),
              Positioned(
                right: kDefaultPadding * 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: kDefaultPadding),
                  child: Image.asset(
                    'assets/icons/logo_circle.png',
                    width: 40,
                    height: 40,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
