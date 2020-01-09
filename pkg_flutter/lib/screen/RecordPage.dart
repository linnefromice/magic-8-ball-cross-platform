import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pkg_flutter/models/QARecordModel.dart';
import 'package:pkg_flutter/screen/arguments/RecordPageArguments.dart';

class RecordPage extends StatefulWidget {
  static const routeName = '/record';
  RecordPage({Key key}) : super(key: key);

  @override
  _RecordPageState createState() => _RecordPageState();
}


class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {

    final RecordPageArguments _args = ModalRoute.of(context).settings.arguments;
    var _datas = _args.map;
    return Scaffold(
      appBar: AppBar(
        title: Text('Q/A Records'),
      ),
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('TIME'),
                  Text('QUESTION'),
                  Text('ANSWER'),
                ],
              ),
              Expanded(child: ListView.builder(
                  itemCount: _datas.length,
                  itemBuilder: (BuildContext context, int index) {
                    QARecordModel model = _datas[_datas.keys.elementAt(index)];
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(DateFormat("yyyy/MM/dd").format(model.time)),
                            Text(DateFormat("HH:mm:ss.SSS").format(model.time)),
                          ],
                        ),
                        Text(model.question),
                        Text(model.answer),
                      ],
                    );
                  }
              ))
            ],
          ),
      ),
    );
  }
}
