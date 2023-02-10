import 'package:flutter/material.dart';

class _Constants {
  static const logoTitle = 'Simple Notes';
  static const fontFamily = 'Believeit';
}

class LogoUtil {
  LogoUtil._();

  static Widget buildLogo() {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 40,
      ),
      child: const Text(
        _Constants.logoTitle,
        style: TextStyle(
          fontFamily: _Constants.fontFamily,
          fontSize: 44,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
