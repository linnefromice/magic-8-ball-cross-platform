import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pkg_flutter_bloc/blocs/QABloc.dart';
import 'package:provider/provider.dart';

import 'models/QARecord.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Provider<QABloc>(
        create: (context) => QABloc(),
        dispose: (context, bloc) => bloc.dispose(),
        child: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {

  Widget _buildRecordRow(final QARecord data) => Container(
    padding: EdgeInsets.all(4.0),
    child: Column(
      children: [
        Text(DateFormat("yyyy/MM/dd HH:mm:ss.SSS").format(data.time)),
        Text(data.question),
        Text(data.answer),
      ],
    ),
  );

  Widget _buildRecordList(BuildContext context, final List<QARecord> list) => ListView.builder(
    itemCount: list.length,
    itemBuilder: (BuildContext context, int index) {
      return _buildRecordRow(list[list.length - (index + 1)]);
    }
  );

  @override
  Widget build(BuildContext context) {
    final bloc = Provider.of<QABloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Magic 8 Ball'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigation),
        onPressed: () {
          final list = bloc.getQARecordList();
          showDialog(
            context: context,
            child: AlertDialog(
              title: Text('Q/A Record List'),
              content: SingleChildScrollView(
                child: SizedBox(
                  width: 400,
                  height: 800,
                  child: _buildRecordList(context, list),
                ),
              ),
              actions: <Widget>[
                FlatButton.icon(
                  onPressed: () => Navigator.pop(context),
                  icon: Icon(Icons.close),
                  label: Text('CLOSE'),
                ),
              ],
            ),
          );
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Enter your question?:',
            ),
            TextField(
              decoration: InputDecoration(labelText: 'QUESTION'),
              onSubmitted: (String value) async {
                bloc.addQuestion.add(value);
              },
            ),
            Divider(),
            Text(
              'ANSWER is',
            ),
            StreamBuilder(
              initialData: '',
              stream: bloc.getAnswer,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.display1,
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
