import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'importPage.dart';
import 'pageTransition.dart';
import 'selectSource.dart';
import 'Data.dart';
import 'DataGroup.dart';

typedef DataGroupCallback = Function(DataGroup arg);

List<DataGroup> mainDataList = [];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primaryColor: Color(0xFF181A1E),
          scaffoldBackgroundColor: Color(0xFF181A1E),
          fontFamily: "Quicksand",
          unselectedWidgetColor: Color(0xFFB7BCC5)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void addDataGroup(DataGroup data) {
  mainDataList.add(data);
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => {},
          iconSize: 25,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.grid_on),
            onPressed: () => {},
            iconSize: 25,
          ),
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () => {},
            iconSize: 25,
          ),
        ],
        elevation: 0,
      ),
      body: Column(
        // Column is also a layout widget. It takes a list of children and
        // arranges them vertically. By default, it sizes itself to fit its
        // children horizontally, and tries to be as tall as its parent.
        //
        // Invoke "debug painting" (press "p" in the console, choose the
        // "Toggle Debug Paint" action from the Flutter Inspector in Android
        // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
        // to see the wireframe for each widget.
        //
        // Column has various properties to control how it sizes itself and
        // how it positions its children. Here we use mainAxisAlignment to
        // center the children vertically; the main axis here is the vertical
        // axis because Columns are vertical (the cross axis would be
        // horizontal).
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
            decoration: BoxDecoration(
                border: Border.all(width: 3.0, color: Color(0xFF515151)),
                color: Color(0xFF272B31),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              children: [
                Row(
                  children: [
                    Container(padding: EdgeInsets.all(20)),
                    Text(
                      "Data Groups",
                      style: TextStyle(fontSize: 28, color: Colors.white),
                    ),
                  ],
                ),
                Divider(
                  color: Colors.white,
                  endIndent: 100,
                  indent: 43,
                  thickness: 2,
                ),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, 0, 0, (MediaQuery.of(context).size.height) / 3),
              ),
              Row(
                children: [
                  Icon(
                    Icons.info,
                    color: Color(0xFF515151),
                  ),
                  Container(
                    padding: EdgeInsets.all(3),
                  ),
                  Text(
                    'Add a new Data Group!',
                    style: TextStyle(color: Color(0xFF515151)),
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.of(context).push(createRoute(
              Offset(0.0, 1.0),
              Offset(0.0, 0.0),
              Curves.fastLinearToSlowEaseIn,
              () => SelectSource(
                    callback: addDataGroup,
                  )))
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
        backgroundColor: Color(0xFF272B31),
      ), // This trailing comma makes auto-formatting nicer for build methods.
      //bruh
    );
  }
}
