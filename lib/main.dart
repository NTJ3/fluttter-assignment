import 'package:flutter/material.dart';
import 'package:flutter_assignment/core/util/logger.dart';
import 'package:flutter_assignment/ui/home/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  loggerConfigure();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    log.info('APP STARTED');
    return MaterialApp(
      title: 'Flutter Assignment',
      theme: ThemeData(),
      home: const HomeScreen(),
    );
  }
}
