import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_notes_blueprint/app/blocs_provider_widget.dart';
import 'package:simple_notes_blueprint/firebase_options.dart';
import 'common/service_locator.dart' as ingection;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ingection.init();
  runApp(const BlocProviders());
}
