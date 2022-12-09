import 'package:flutter/material.dart';
import '../../../constants.dart';

class AddProject extends StatelessWidget {
  const AddProject({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FloatingActionButton(
        onPressed: () {},
        backgroundColor: kPrimaryColor,
        highlightElevation: 0,
        elevation: 0,
        child: const ImageIcon(
          AssetImage(
            'assets/icons/plus_home.png',
          ),
          size: 30,
        ),
      ),
    );
  }
}