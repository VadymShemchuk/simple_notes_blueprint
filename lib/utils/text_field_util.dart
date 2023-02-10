import 'package:flutter/material.dart';
import 'package:simple_notes_blueprint/utils/color_util.dart';

enum TextFieldType { email, password, noteTitle }

class TextFieldUtil {
  const TextFieldUtil._();

  static Widget buildCustomTextField({
    required TextFieldType type,
    String? errorText,
    bool? changeSecureIcon,
    required void Function(String)? onTextFieldChanged,
    void Function()? onSecurePressed,
  }) {
    Widget widget;
    switch (type) {
      case TextFieldType.email:
        widget = _buildCommonTextField(
          hintText: 'Enter email',
          icon: Icons.alternate_email_rounded,
          onTextFieldChanged: onTextFieldChanged,
          errorText: errorText,
        );
        break;
      case TextFieldType.password:
        widget = _buildCommonTextField(
          hintText: 'Enter password',
          icon: Icons.password_rounded,
          onTextFieldChanged: onTextFieldChanged,
          errorText: errorText,
          isSecure: true,
          onSecurePressed: onSecurePressed,
          changeSecureIcon: changeSecureIcon,
        );
        break;
      case TextFieldType.noteTitle:
        widget = _buildCommonTextField(
            hintText: 'Create new note with title',
            icon: Icons.edit,
            onTextFieldChanged: onTextFieldChanged);
        break;
    }
    return widget;
  }

  static Widget buildStaticText(
      {required String text,
      double fontSize = 18,
      FontWeight fontWeight = FontWeight.w200}) {
    return Text(
      text,
      style: TextStyle(
        color: Colors.white,
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }

  static Widget _buildCommonTextField({
    required String hintText,
    String? errorText,
    required IconData icon,
    bool isSecure = false,
    bool? changeSecureIcon,
    required void Function(String)? onTextFieldChanged,
    void Function()? onSecurePressed,
  }) {
    MaterialColor colorCustom =
        ColorUtil.createMaterialColor(const Color(0xFFFFFFFF));
    Icon secureIcon = changeSecureIcon ?? true
        ? const Icon(Icons.visibility_off)
        : const Icon(Icons.visibility);
    bool obscureText = changeSecureIcon ?? false;
    return Theme(
      data: ThemeData(primarySwatch: colorCustom),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.white,
        ),
        obscureText: obscureText,
        onChanged: onTextFieldChanged,
        decoration: InputDecoration(
          suffixIcon: isSecure
              ? IconButton(
                  icon: secureIcon,
                  onPressed: onSecurePressed,
                )
              : null,
          hintText: hintText,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.red),
          ),
          errorText: errorText,
        ),
      ),
    );
  }

  static Widget buildNoteTextField({
    required void Function(String)? onTextFieldChanged,
  }) {
    MaterialColor colorCustom = ColorUtil.createMaterialColor(Colors.white);
    return Theme(
      data: ThemeData(primarySwatch: colorCustom),
      child: TextFormField(
        style: const TextStyle(
          color: Colors.black,
        ),
        maxLines: 10,
        minLines: 1,
        onChanged: onTextFieldChanged,
        decoration: InputDecoration(
          hintText: 'Create new note',
          prefixIcon: const Icon(Icons.edit),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
