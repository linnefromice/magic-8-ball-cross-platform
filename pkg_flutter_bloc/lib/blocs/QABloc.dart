import 'dart:async';

import 'package:pkg_flutter_bloc/models/QARecord.dart';
import 'package:pkg_flutter_bloc/services/AnswerService.dart';

class QABloc {
  final _questionController = StreamController<String>();
  Sink<String> get addQuestion => _questionController.sink;

  final _answerController = StreamController<String>();
  Stream<String> get getAnswer => _answerController.stream;

  List<QARecord> _qaRecordList;

  QABloc() {
    _qaRecordList = [];
    _replyRandomAnswer();
    // TODO: Tentative version
    _initForTest();
  }

  void _initForTest() {
    _qaRecordList.add(new QARecord(DateTime.now(), 'First Question', 'I am fine.'));
    _qaRecordList.add(new QARecord(DateTime.now(), 'Second Question', 'See you again.'));
    _qaRecordList.add(new QARecord(DateTime.now(), '3rd Question', 'I am fine.'));
    _qaRecordList.add(new QARecord(DateTime.now(), '4th Question', 'See you again.'));
    _qaRecordList.add(new QARecord(DateTime.now(), '5th Question', 'I am fine.'));
    _qaRecordList.add(new QARecord(DateTime.now(), '6th Question', 'See you again.'));
    _qaRecordList.add(new QARecord(DateTime.now(), '7th Question', 'I am fine.'));
    _qaRecordList.add(new QARecord(DateTime.now(), '8th Question', 'See you again.'));
    _qaRecordList.add(new QARecord(DateTime.now(), '9th Question', 'I am fine.'));
    _qaRecordList.add(new QARecord(DateTime.now(), '10th Question', 'See you again.'));
  }

  List<QARecord> getQARecordList() {
    return _qaRecordList;
  }

  void _replyRandomAnswer() {
    _questionController.stream.listen((_) {
      var selectedAnswer = AnswerService.selectRandomAnswer();
      _answerController.add(selectedAnswer);
      _addQARecord(_, selectedAnswer);
    });
  }

  void _addQARecord(final String question, final String answer) {
    QARecord dto = QARecord(DateTime.now(), question, answer);
    _qaRecordList.add(dto);
  }

  void dispose() {
    _questionController.close();
    _answerController.close();
  }
}