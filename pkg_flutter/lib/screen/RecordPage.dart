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

  Widget _buildHeader() {
    return Container(
      margin: EdgeInsets.all(2.0),
      color: Colors.blue,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _buildHeaderCell('TIME'),
          ),
          Expanded(
            flex: 1,
            child: _buildHeaderCell('QUESTION'),
          ),
          Expanded(
            flex: 1,
            child: _buildHeaderCell('ANSWER'),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderCell(final String _msg) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 1.0, top: 2.0, right: 1.0, bottom: 2.0),
      padding: EdgeInsets.only(left: 1.0, top: 2.0, right: 1.0, bottom: 2.0),
      child: Text(
        _msg,
        style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget _buildDataRow(final QARecordModel model) {
    return Container(
      margin: EdgeInsets.all(2.0),
      color: Colors.blue,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _buildDataCell(DateFormat("yyyy/MM/dd HH:mm:ss.SSS").format(model.time)),
          ),
          Expanded(
            flex: 1,
            child: _buildDataCell(model.question),
          ),
          Expanded(
            flex: 1,
            child: _buildDataCell(model.answer),
          ),
        ],
      ),
    );
  }

  Widget _buildDataCell(final String _msg) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 1.0, top: 2.0, right: 1.0, bottom: 2.0),
      color: Colors.white,
      height: 40,
      child: Text(
        _msg,
        textAlign: TextAlign.center,
      ),
    );
  }


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
              _buildHeader(),
              Expanded(child: ListView.builder(
                  itemCount: _datas.length,
                  itemBuilder: (BuildContext context, int index) {
                    QARecordModel model = _datas[_datas.keys.elementAt(index)];
                    return _buildDataRow(model);
                  }
              ))
            ],
          ),
      ),
    );
  }
}
