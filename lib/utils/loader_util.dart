import 'package:flutter/material.dart';

class LoaderUtil {
  const LoaderUtil._();

  static Widget buildLoader() {
    return const Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 50,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
