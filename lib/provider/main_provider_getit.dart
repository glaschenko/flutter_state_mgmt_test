import 'package:flutter/material.dart';
import 'package:flutter_state_mgmt_test/provider/MyService.dart';
import 'package:injectable/injectable.dart';
import 'package:provider/provider.dart';
import 'package:get_it/get_it.dart';
import 'main_provider_getit.config.dart';


void main() {
  configureDependencies();
  // setupGetit();
  runApp(MyApp());
}

final getIt = GetIt.instance;
// void setupGetit() {
//   getIt.registerSingleton<MyService>(MyService());
// }

@InjectableInit()
void configureDependencies() => $initGetIt(getIt);


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
    ),
    home: ChangeNotifierProvider<MyDataStore>(
      create: (context) => MyDataStore(),
      child: MyHomePage(title: 'Flutter Demo Home Page'),
    ));
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  BuildContext context;

  void _incrementCounter() {
    Provider.of<MyDataStore>(context).counterValue++;
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    var counter = Provider.of<MyDataStore>(context).counterValue;
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
            Text(
                'Result from my getit service: '
            ),
            Text(
              getIt<MyService>().getResponse(),
              style: Theme
                  .of(context)
                  .textTheme
                  .headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


}



class MyDataStore with ChangeNotifier {
  int _counterValue = 0;
  int get counterValue => _counterValue;

  set counterValue(int value) {
    _counterValue = value;
    notifyListeners();
  }
}
