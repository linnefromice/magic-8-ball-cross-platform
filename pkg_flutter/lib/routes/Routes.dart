import 'package:flutter/cupertino.dart';
import 'package:pkg_flutter/screen/HomePage.dart';
import 'package:pkg_flutter/screen/RecordPage.dart';

class Routes {
  static final home = HomePage();
  static final routes = <String, WidgetBuilder>{
    HomePage.routeName : (context) => HomePage(),
    RecordPage.routeName : (context) => RecordPage(),
  };
}