import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

enum Actions { Increment }

int counterReducer(int state, dynamic action) {
  if (action == Actions.Increment) {
    return state + 1;
  }
  return state;
}

void main() {
  final store = Store<int>(counterReducer, initialState: 0);
  runApp(MyApp(store));
}

class MyApp extends StatelessWidget {
  final Store<int> store;

  MyApp(this.store);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: StoreProvider<int>(
        store: store,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Redux test"),
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'You have pushed the button this many times:',
                ),
                StoreConnector<int, String>(
                  converter: (store) => store.state.toString(),
                  builder: (context, counter) {
                    return Text(
                      '$counter',
                      style: Theme.of(context).textTheme.headline4,
                    );
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: StoreConnector<int, VoidCallback>(
            converter: (store) => () => store.dispatch(Actions.Increment),
            builder: (context, callback){
              return FloatingActionButton(
                onPressed: callback,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              );
            },
          ), // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}



