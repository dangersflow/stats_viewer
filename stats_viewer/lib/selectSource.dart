import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:stats_viewer/DataGroup.dart';
import 'cardItem.dart';
import 'importPage.dart';
import 'dart:math';

typedef DataGroupCallback = Function(DataGroup arg);

class SelectSource extends StatefulWidget {
  SelectSource({this.callback});
  DataGroupCallback callback;
  @override
  _SelectSourceState createState() => _SelectSourceState();
}

class _SelectSourceState extends State<SelectSource> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.menu),
            onPressed: () => {},
            iconSize: 25,
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Column(
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
                            "Select Data Source",
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
                    OrientationBuilder(
                      builder: (context, orientation) {
                        return new GridView.extent(
                          primary: false,
                          padding: const EdgeInsets.all(35),
                          shrinkWrap: true,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          //crossAxisCount: 5,
                          maxCrossAxisExtent: 200,
                          children: <Widget>[
                            CardItem(
                              name: "File",
                              icon: Icon(
                                Icons.file_copy,
                                color: Color(0xFFB7BCC5),
                                size: 50,
                              ),
                              page: () => ImportPage(
                                callback: widget.callback,
                              ),
                              passPage: true,
                            ),
                            CardItem(
                              name: "Facebook Ads",
                              icon: Icon(
                                FontAwesome.facebook_square,
                                color: Color(0xFF77ADDB),
                                size: 50,
                              ),
                              passPage: false,
                            ),
                            CardItem(
                              name: "YouTube Ads",
                              icon: Icon(
                                FontAwesome.youtube_play,
                                color: Color(0xFFEA6666),
                                size: 50,
                              ),
                              passPage: false,
                            )
                          ],
                        );
                      },
                    )
                  ],
                ),
              ]),
        ));
  }
}
