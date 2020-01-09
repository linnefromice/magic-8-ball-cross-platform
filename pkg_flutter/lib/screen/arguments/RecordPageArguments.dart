import 'package:pkg_flutter/models/QARecordModel.dart';

class RecordPageArguments {
  // question, (time, answer)
  final Map<String, QARecordModel> map;

  RecordPageArguments(this.map);
}