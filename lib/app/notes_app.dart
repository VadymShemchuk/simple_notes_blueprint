import 'package:flutter/material.dart';
import 'package:simple_notes_blueprint/app/note_item.dart/note_item_page.dart';
import 'package:simple_notes_blueprint/app/notes_list.dart/notes_page.dart';
import 'package:simple_notes_blueprint/app/sign_in/sign_in_page.dart';
import 'package:simple_notes_blueprint/app/sign_up/sign_up_page.dart';
import 'root/root_page.dart';

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.blueGrey,
          appBarTheme: const AppBarTheme(backgroundColor: Colors.white),
          buttonTheme: const ButtonThemeData(buttonColor: Colors.blue)),
      initialRoute: RootPage.route,
      routes: {
        RootPage.route: (context) => const RootPage(),
        SignInPage.route: (context) => const SignInPage(),
        SignUpPage.route: (context) => const SignUpPage(),
        NotesListPage.route: (context) => const NotesListPage(),
        NoteItemPage.route: (context) => const NoteItemPage(),
      },
    );
  }
}
