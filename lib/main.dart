import 'package:flutter/material.dart';
import 'package:somnio_test/src/presentation/home/pages/home_page.dart';
import 'package:somnio_test/src/shared/di/di.dart';

void main() {
  diSetup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Blog app',
      home: HomePage(),
    );
  }
}
