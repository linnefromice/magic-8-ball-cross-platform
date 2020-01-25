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
                content: Column(
                  children: <Widget>[
                    // TODO: Tentative version
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(DateFormat("yyyy/MM/dd").format(list[0].time)),
                            Text(DateFormat("HH:mm:ss.SSS").format(list[0].time)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(list[0].question),
                            Text(list[0].answer),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(DateFormat("yyyy/MM/dd").format(list[1].time)),
                            Text(DateFormat("HH:mm:ss.SSS").format(list[1].time)),
                          ],
                        ),
                        Column(
                          children: <Widget>[
                            Text(list[1].question),
                            Text(list[1].answer),
                          ],
                        ),
                      ],
                    ),
                  ],
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
                /*
                ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    final QARecord data = list[index];
                    return Container(
                      child: Row(
                        children: <Widget>[
                          Text(data.time.toString()),
                          Text(data.question),
                          Text(data.answer),
                        ],
                      ),
                    );
                  },
                ),
                */
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
