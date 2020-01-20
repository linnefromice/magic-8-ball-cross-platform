import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pkg_flutter/models/QARecordModel.dart';
import 'package:pkg_flutter/screen/RecordPage.dart';
import 'package:pkg_flutter/screen/arguments/RecordPageArguments.dart';
import 'package:pkg_flutter/services/AnswerService.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  TextEditingController _inputQuestionController;
  String _displayAnswer;
  Map<String, QARecordModel> _recordMap;

  @override
  void dispose() {
    _inputQuestionController.dispose();
    super.dispose();
  }

  _HomePageState() {
    _inputQuestionController = TextEditingController();
    _displayAnswer = 'Wait your quesition.';
    _recordMap = {};
  }

  void _sendQuestion() {
    var question = _inputQuestionController.text;
    if (question == '') {
      setState(() {
        _displayAnswer = 'Wait your question.';
      });
      return;
    }

    var selectedAnswer = AnswerService.selectRandomAnswer();
    setState(() {
      _displayAnswer = selectedAnswer;
      // for navigate
      _recordMap[question] = QARecordModel(DateTime.now(),question,selectedAnswer);
    });
  }

  void _requestClear() {
    setState(() {
      _inputQuestionController.text = '';
      _displayAnswer = '';
    });
  }

  void _navigateRecordPage() {
    Navigator.pushNamed(
      context,
      RecordPage.routeName,
      arguments: RecordPageArguments(_recordMap),
    );
  }

  Widget _buildFloatingActionButton() => FloatingActionButton(
    child: Icon(Icons.arrow_right),
    onPressed: _navigateRecordPage,
  );

  Widget _buildQuestionArea() => Container(
    child: Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "Questioner",
            style: TextStyle(fontSize: 36.0),
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Text(
            "Please enter your question.",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          child: TextField(
            controller: _inputQuestionController,
            decoration: InputDecoration(border: OutlineInputBorder()),
            maxLines: 1,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
        Container(
          padding: EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.check_circle),
                onPressed: _sendQuestion,
                iconSize: 48.0,
              ),
              IconButton(
                icon: Icon(Icons.close),
                onPressed: _requestClear,
                iconSize: 48.0,
              ),
            ],
          ),
        ),
      ],
    ),
  );

  Widget _buildAnswerArea() => Container(
    child: Column(
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Respondent",
              style: TextStyle(
                  fontSize: 36.0
              ),
            )
        ),
        Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              "Answer is ...",
              style: TextStyle(
                  fontSize: 18.0
              ),
            )
        ),
        Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              _displayAnswer,
              style: TextStyle(
                  fontSize: 18.0
              ),
            )
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magic 8 Ball'),
      ),
      floatingActionButton: _buildFloatingActionButton(),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildQuestionArea(),
              Divider(),
              Divider(),
              _buildAnswerArea(),
            ],
          ),
        ),
      ),
    );
  }
}
