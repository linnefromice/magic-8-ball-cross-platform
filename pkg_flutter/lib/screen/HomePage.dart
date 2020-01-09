import 'dart:math';
import 'package:flutter/material.dart';
import 'package:pkg_flutter/models/QARecordModel.dart';
import 'package:pkg_flutter/screen/RecordPage.dart';
import 'package:pkg_flutter/screen/arguments/RecordPageArguments.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _inputQuestionController = TextEditingController();
  String _displayAnswer;
  List<String> _answerList;
  Map<String, QARecordModel> _recordMap;

  @override
  void dispose() {
    _inputQuestionController.dispose();
    super.dispose();
  }

  _HomePageState() {
    _displayAnswer = 'Wait your quesition.';
    _recordMap = {};
    _answerList = [
      'It is certain.',
      'It is decidely so.',
      'Without a doubt.',
      'Yes - definitely.',
      'You may rely on it.',
      'As I see it, yes.',
      'Most likely.',
      'Outlook good.',
      'Yes.',
      'Signs point to yes.',
      'Reply hazy, try again.',
      'Ask again later.',
      'Better not tell you now.',
      'Cannot predict now.',
      'Concentrate and ask again.',
      'Don\'t count on it.',
      'My reply is no.',
      'My sources say no.',
      'Outlook not so good.',
      'Very doubtful.',
    ];
  }

  void _sendQuestion() {
    var question = _inputQuestionController.text;
    if (question == '') {
      setState(() {
        _displayAnswer = 'Wait your question.';
      });
      return;
    }

    // select random answer
    var num = Random().nextInt(_answerList.length);
    var selectedAnswer = _answerList[num];
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Magic 8 Ball'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_right),
        onPressed: _navigateRecordPage,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Questioner",
                style: TextStyle(
                  fontSize: 36.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Please enter your question.",
                style: TextStyle(
                  fontSize: 18.0,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: TextField(
                controller: _inputQuestionController,
                decoration: InputDecoration(border: OutlineInputBorder()),
                maxLines: 1,
                style: TextStyle(
                    fontSize: 18.0
                ),
              ),
            ),
            Padding(
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
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Divider(
                height: 24.0,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(4.0),
              child: Divider(
                height: 24.0,
              ),
            ),
            Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Respondent",
                  style: TextStyle(
                      fontSize: 36.0
                  ),
                )
            ),
            Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Answer is ...",
                  style: TextStyle(
                      fontSize: 18.0
                  ),
                )
            ),
            Padding(
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
      ),
    );
  }
}
