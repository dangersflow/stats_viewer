import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ImportPage extends StatefulWidget {
  ImportPage({Key key}) : super(key: key);

  @override
  _ImportPageState createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.menu), onPressed: ()=>{}, iconSize: 25,),
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Container(padding: EdgeInsets.all(20)),
                Text("Import", style: TextStyle(fontSize: 28, color: Colors.white),),
              ],
            ),
            Divider(color: Colors.white, endIndent: 100, indent: 43, thickness: 2,),
          ]
      ),
    );
  }
}