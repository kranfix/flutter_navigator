import 'package:flutter/material.dart';
import 'package:navigator1/src/nav.dart';
import 'package:navigator1/src/page_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget with PageWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

  @override
  String get pageName => 'My Home Page';
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? _message;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            TextButton(
              onPressed: () async {
                final message = await HelloPage.navigate(context);
                setState(() => _message = message);
              },
              child: Text('Go to hello'),
            ),
            if (_message != null) Text(_message!)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class HelloPage extends StatelessWidget with PageWidget {
  const HelloPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Nav.pop(context);
        return true;
      },
      child: Scaffold(
        body: Center(
          child: TextButton(
            onPressed: () => Nav.pop(context, 'Message for pop'),
            child: Text('Hello'),
          ),
        ),
      ),
    );
  }

  @override
  String get pageName => 'HelloPage';

  static Future<String?> navigate(BuildContext context) {
    return Nav.goto<String>(context, HelloPage());
  }
}
