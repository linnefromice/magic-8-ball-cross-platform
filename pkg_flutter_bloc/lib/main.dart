import 'package:flutter/material.dart';
import 'package:pkg_flutter_bloc/blocs/QABloc.dart';
import 'package:provider/provider.dart';

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
