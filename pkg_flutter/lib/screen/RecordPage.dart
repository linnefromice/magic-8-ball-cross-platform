import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RecordPage extends StatefulWidget {
  RecordPage({Key key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}


class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Q/A Records'),
      ),
      body: Center(
        child: Text('TODO'),
      ),
    );
  }
}
