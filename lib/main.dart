import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:window_size/window_size.dart';
import 'app/bloc_observer.dart';
import 'app/di/di.dart';
import 'my_app.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await configureDependencies();
  Bloc.observer = MyBlocObserver();
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowTitle('My App');
    setWindowMaxSize(const Size(800, 700));
    setWindowMinSize(const Size(800, 700));
  }
  runApp(
    const MyApp(),
  );
}
