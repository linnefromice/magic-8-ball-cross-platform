import 'dart:async';

import 'package:pkg_flutter_bloc/services/AnswerService.dart';

class QABloc {
  final _questionController = StreamController<String>();
  Sink<String> get addQuestion => _questionController.sink;

  final _answerController = StreamController<String>();
  Stream<String> get getAnswer => _answerController.stream;

  QABloc() {
    _replyRandomAnswer();
  }

  void _replyRandomAnswer() {
    _questionController.stream.listen((_) {
      var selectedAnswer = AnswerService.selectRandomAnswer();
      _answerController.add(selectedAnswer);
    });
  }

  void dispose() {
    _questionController.close();
    _answerController.close();
  }
}