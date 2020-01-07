import 'package:flutter/material.dart';
import 'package:pkg_flutter/routes/Routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Magic 8 Ball with Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Routes.home,
      routes: Routes.routes,
    );
  }
}