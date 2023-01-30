import 'package:flutter/material.dart';
import 'package:groupup/constants.dart';

class ValidateButton extends StatelessWidget {
  const ValidateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SizedBox(
        height: 75,
        width: 75,
        child: FittedBox(
          child: FloatingActionButton(
            heroTag: 'btn7',
            highlightElevation: 0,
            onPressed: () {},
            backgroundColor: kPrimaryColor,
            elevation: 0,
            child: const Icon(
              Icons.check,
              size: 35,
            ),
          ),
        ),
      ),
    );
  }
}
