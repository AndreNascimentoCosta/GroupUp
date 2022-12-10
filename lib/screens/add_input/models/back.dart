import 'package:flutter/material.dart';

Material back() {
  return Material(
    elevation: 2,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        color: const Color(0XFFFCFCFC),
        border: Border.all(color: const Color(0XFFFCFCFC)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const ImageIcon(
        AssetImage('assets/icons/arrow_left.png'),
        color: Colors.black,
        size: 20,
      ),
    ),
  );
}
