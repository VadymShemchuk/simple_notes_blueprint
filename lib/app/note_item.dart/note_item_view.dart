import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_notes_blueprint/app/navigator_status.dart';
import 'package:simple_notes_blueprint/app/note_item.dart/bloc/note_item_bloc.dart';
import 'package:simple_notes_blueprint/utils/button_util.dart';
import 'package:simple_notes_blueprint/utils/loader_util.dart';
import 'package:simple_notes_blueprint/utils/logo_util.dart';
import 'package:simple_notes_blueprint/utils/text_field_util.dart';

class _Constants {
  static const imagePlaceHolder = 'assets/placeholder_image.jpeg';
}

class NoteItemView extends StatelessWidget {
  const NoteItemView({
    Key? key,
    this.image,
    required this.status,
  }) : super(key: key);

  final File? image;
  final NavigatorStatus status;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned(
                top: 40,
                left: 40,
                child: GestureDetector(
                  onTap: () => context.read<NoteItemBloc>().add(BackToList()),
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LogoUtil.buildLogo(),
                    GestureDetector(
                      onTap: () =>
                          context.read<NoteItemBloc>().add(AddPhotoToNote()),
                      child: image == null
                          ? Container(
                              height: 250,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: AssetImage(
                                          _Constants.imagePlaceHolder))),
                            )
                          : Image.file(
                              image!,
                              height: 250,
                            ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextFieldUtil.buildCustomTextField(
                        type: TextFieldType.noteTitle,
                        onTextFieldChanged: (title) =>
                            context.read<NoteItemBloc>().add(
                                  NoteTitleChanged(title),
                                ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: TextFieldUtil.buildNoteTextField(
                        onTextFieldChanged: (text) =>
                            context.read<NoteItemBloc>().add(
                                  NoteTextChanged(text),
                                ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: status is Progress
                          ? LoaderUtil.buildLoader()
                          : ButtonUtil.buildCommonButton(
                              context,
                              onPressed: () =>
                                  context.read<NoteItemBloc>().add(SaveNote()),
                              buttonText: 'Save note',
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
