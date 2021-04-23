import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'DataGroup.dart';
import 'Data.dart';
import 'Data.dart' as myData;
import 'package:excel/excel.dart';
import 'ExcelBook.dart';

typedef DataGroupCallback = Function(DataGroup arg);
enum ImportMode { manual, automatic }
enum AutomaticImport { vertical, horizontal }
List<String> rangesList = [];
RegExp rangeExpression = RegExp(r"\w+\d+:\w+\d+");

//variables to iterate through excel file
String firstPoint = "";
int firstPointNum = 0;
String secondPoint = "";
int secondPointNum = 0;
String dataGroupName = "";

final TextEditingController firstRange = new TextEditingController();
final TextEditingController repeatData = new TextEditingController();

class ImportPage extends StatefulWidget {
  ImportPage({Key key, this.callback}) : super(key: key);
  DataGroupCallback callback;
  @override
  _ImportPageState createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> with TickerProviderStateMixin {
  ImportMode _modeSelected;
  AutomaticImport _modeSelected2;

  AnimationController _controller;
  Animation<double> _animation;

  AnimationController _controller2;
  Animation<double> _animation2;

  void grabFile() async {
    FilePickerResult result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: [
          'xlsx',
          'xlsm',
          'xlsb',
          'xltx',
          'xltm',
          'xls',
          'xml',
          'csv',
          'tsv',
          'ods'
        ]);

    if (result != null) {
      File file = File(result.files.single.path);
    } else {
      // User canceled the picker
    }
  }

  int sublength(String a, String b) {
    int count = 0;
    int c = a.codeUnitAt(0);
    int end = b.codeUnitAt(0);
    while (c <= end) {
      print(String.fromCharCode(c));
      c++;
      count++;
    }

    return count;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    grabFile();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.fastOutSlowIn,
    );

    _controller2 = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation2 = CurvedAnimation(
      parent: _controller2,
      curve: Curves.fastOutSlowIn,
    );

    rangesList.add("Enter Range");
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus &&
              currentFocus.focusedChild != null) {
            currentFocus.focusedChild.unfocus();
            setState(() {});
          }
        },
        child: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              leading: IconButton(
                icon: Icon(Icons.menu),
                onPressed: () => {},
                iconSize: 25,
              ),
              elevation: 0,
            ),
            body: SingleChildScrollView(
                child: Container(
              padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      decoration: BoxDecoration(
                          border:
                              Border.all(width: 3.0, color: Color(0xFF515151)),
                          color: Color(0xFF272B31),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(padding: EdgeInsets.all(20)),
                              Text(
                                "Import",
                                style: TextStyle(
                                    fontSize: 28, color: Colors.white),
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
                    Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 15)),
                    Text(
                      "Group Name",
                      style: TextStyle(fontSize: 25, color: Color(0xFFB7BCC5)),
                    ),
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25)),
                        fillColor: Color(0xFF363A43),
                        filled: true,
                      ),
                      maxLength: 20,
                      style: TextStyle(fontSize: 20, color: Color(0xFFB7BCC5)),
                      onChanged: (value) {
                        dataGroupName = value;
                      },
                    ),
                    RadioListTile<ImportMode>(
                      title: Text(
                        "Manual",
                        style:
                            TextStyle(color: Color(0xFFB7BCC5), fontSize: 25),
                      ),
                      value: ImportMode.manual,
                      groupValue: _modeSelected,
                      onChanged: (ImportMode value) {
                        setState(() {
                          _modeSelected = value;
                          _controller.forward();
                          _controller2.reverse();
                        });
                      },
                      activeColor: Color(0xFFB7BCC5),
                      contentPadding: EdgeInsets.fromLTRB(-50, 0, 0, 0),
                      subtitle: Text(
                        "Input multiple data ranges.",
                        style:
                            TextStyle(color: Color(0xFFB7BCC5), fontSize: 12),
                      ),
                    ),
                    SizeTransition(
                      sizeFactor: _animation,
                      axis: Axis.vertical,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: 1,
                                color: Colors.grey,
                                height: MediaQuery.of(context).size.height / 5 +
                                    170,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Ranges",
                                      style: TextStyle(
                                          color: Color(0xFFB7BCC5),
                                          fontSize: 25),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    ),
                                    Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3,
                                      width: MediaQuery.of(context).size.width /
                                          1.7,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        itemCount: rangesList.length,
                                        itemBuilder: (context, index) {
                                          return TextFormField(
                                            //controller: _controller,
                                            decoration: InputDecoration(
                                              border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25)),
                                              fillColor: Color(0xFF363A43),
                                              filled: true,
                                              hintText: "Enter a Range!",
                                              hintStyle: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFF8B93A2)),
                                            ),
                                            maxLength: 20,
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Color(0xFFB7BCC5)),
                                            onTap: () {
                                              if (index ==
                                                  rangesList.length - 1) {
                                                rangesList.add("Enter Range");
                                              }
                                            },
                                            inputFormatters: [
                                              //FilteringTextInputFormatter.allow(RegExp('([a-zA-Z])+([0-9])*(:)*([a-zA-Z])*([0-9])*\W'))
                                            ],
                                            onChanged: (value) {
                                              rangesList[index] = value;
                                            },
                                          );
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    RadioListTile<ImportMode>(
                      title: Text(
                        "Automatic",
                        style:
                            TextStyle(color: Color(0xFFB7BCC5), fontSize: 25),
                      ),
                      value: ImportMode.automatic,
                      groupValue: _modeSelected,
                      onChanged: (ImportMode value) {
                        setState(() {
                          _modeSelected = value;
                          _controller.reverse();
                          _controller2.forward();
                        });
                      },
                      activeColor: Color(0xFFB7BCC5),
                      contentPadding: EdgeInsets.fromLTRB(-50, 0, 0, 0),
                      subtitle: Text(
                        "Input one data range that occurs multiple times.",
                        style:
                            TextStyle(color: Color(0xFFB7BCC5), fontSize: 12),
                      ),
                    ),
                    SizeTransition(
                      sizeFactor: _animation2,
                      axis: Axis.vertical,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10),
                                width: 1,
                                color: Colors.grey,
                                height: MediaQuery.of(context).size.height / 5 +
                                    180,
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      "First Group Range",
                                      style: TextStyle(
                                          color: Color(0xFFB7BCC5),
                                          fontSize: 25),
                                    ),
                                    Container(
                                      padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                                    ),
                                    Container(
                                        height:
                                            MediaQuery.of(context).size.height /
                                                2.5,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.7,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextFormField(
                                              controller: firstRange,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                fillColor: Color(0xFF363A43),
                                                filled: true,
                                                hintText: "Enter a Range!",
                                                hintStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF8B93A2)),
                                              ),
                                              maxLength: 20,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFFB7BCC5)),
                                              inputFormatters: [
                                                //FilteringTextInputFormatter.allow(RegExp('([a-zA-Z])+([0-9])*(:)*([a-zA-Z])*([0-9])*\W'))
                                              ],
                                            ),
                                            Text(
                                              "Data Repeats",
                                              style: TextStyle(
                                                  color: Color(0xFFB7BCC5),
                                                  fontSize: 25),
                                            ),
                                            TextFormField(
                                              controller: repeatData,
                                              decoration: InputDecoration(
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            25)),
                                                fillColor: Color(0xFF363A43),
                                                filled: true,
                                                hintText: "X cells",
                                                hintStyle: TextStyle(
                                                    fontSize: 20,
                                                    color: Color(0xFF8B93A2)),
                                              ),
                                              maxLength: 20,
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  color: Color(0xFFB7BCC5)),
                                              inputFormatters: [
                                                //FilteringTextInputFormatter.allow(RegExp('([a-zA-Z])+([0-9])*(:)*([a-zA-Z])*([0-9])*\W'))
                                              ],
                                            ),
                                            RadioListTile<AutomaticImport>(
                                              title: Text(
                                                "Vertical",
                                                style: TextStyle(
                                                    color: Color(0xFFB7BCC5),
                                                    fontSize: 20),
                                              ),
                                              value: AutomaticImport.vertical,
                                              groupValue: _modeSelected2,
                                              onChanged:
                                                  (AutomaticImport value) {
                                                setState(() {
                                                  _modeSelected2 = value;
                                                });
                                              },
                                              activeColor: Color(0xFFB7BCC5),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      -50, 0, 0, 0),
                                            ),
                                            RadioListTile<AutomaticImport>(
                                              title: Text(
                                                "Horizontal",
                                                style: TextStyle(
                                                    color: Color(0xFFB7BCC5),
                                                    fontSize: 20),
                                              ),
                                              value: AutomaticImport.horizontal,
                                              groupValue: _modeSelected2,
                                              onChanged:
                                                  (AutomaticImport value) {
                                                setState(() {
                                                  _modeSelected2 = value;
                                                });
                                              },
                                              activeColor: Color(0xFFB7BCC5),
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      -50, 0, 0, 0),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              )
                            ],
                          )),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        ),
                        SizedBox(
                          height: 50,
                          width: 150,
                          child: ElevatedButton(
                            child: Text(
                              "Import",
                              style: TextStyle(
                                  color: Color(0xFFB7BCC5), fontSize: 20),
                            ),
                            onPressed: () {
                              DataGroup finalGroup;
                              List<myData.Data> data = [];
                              //finalGroup.name = dataGroupName;
                              //check if automatic or manual
                              if (_modeSelected == ImportMode.manual) {
                                //if its manual go through each input range
                                for (int x = 0; x < rangesList.length; x++) {
                                  //if the current input has the correct format, gather information
                                  print(rangesList[x]);
                                  print(
                                      rangeExpression.hasMatch(rangesList[x]));
                                  print(rangeExpression
                                      .allMatches(rangesList[x]));
                                  if (rangeExpression.hasMatch(rangesList[x])) {
                                    /*
                                    myData.Data newData;
                                    rangesList[x].split(":").forEach((element) {
                                      print(element
                                          .split(new RegExp(r'[a-zA-Z]')));
                                      print(
                                          element.split(new RegExp(r'[0-9]')));
                                    }); */
                                  }
                                }
                              }
                            },
                            style: ButtonStyle(
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                        RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10))),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF363A43))),
                          ),
                        )
                      ],
                    )
                  ]),
            ))),
      ),
      onWillPop: () async {
        rangesList.clear();
        return true;
      },
    );
  }
}
