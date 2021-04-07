import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_icons/flutter_icons.dart';

enum ImportMode {manual, automatic}
List<String> rangesList = [];

class ImportPage extends StatefulWidget {
  ImportPage({Key key}) : super(key: key);

  @override
  _ImportPageState createState() => _ImportPageState();
}

class _ImportPageState extends State<ImportPage> with TickerProviderStateMixin {

  ImportMode _modeSelected;
  AnimationController _controller;
  Animation<double> _animation;

  AnimationController _controller2;
  Animation<double> _animation2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
    _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.fastOutSlowIn,
  );

  _controller2 = AnimationController(
    duration: const Duration(milliseconds: 500),
    vsync: this,
  );
    _animation2 = CurvedAnimation(
    parent: _controller,
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
    return GestureDetector(
      onTap: (){
        FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
       currentFocus.focusedChild.unfocus();
    }
      },
        child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(icon: Icon(Icons.menu), onPressed: ()=>{}, iconSize: 25,),
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(45, 0, 45, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("Import", style: TextStyle(fontSize: 28, color: Colors.white),),
                Divider(color: Colors.white, endIndent: 100, indent: 0, thickness: 2,),
                Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 15)),
                Text("Group Name", style: TextStyle(fontSize: 25, color: Color(0xFFB7BCC5)),),
                TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25)
                    ),
                    fillColor: Color(0xFF363A43),
                    filled: true,
                  ),
                  maxLength: 20,
                  style: TextStyle(fontSize: 20, color: Color(0xFFB7BCC5)),
                ),
                RadioListTile<ImportMode>(
                  title: Text("Manual", style: TextStyle(color: Color(0xFFB7BCC5), fontSize: 25),),
                  value: ImportMode.manual,
                  groupValue: _modeSelected,
                  onChanged: (ImportMode value){
                    setState(() {
                      _modeSelected = value;
                      _controller.forward();
                    });
                  },
                  activeColor: Color(0xFFB7BCC5),
                  contentPadding: EdgeInsets.fromLTRB(-50, 0, 0, 0),
                  subtitle: Text("Input multiple data ranges.", style: TextStyle(color: Color(0xFFB7BCC5), fontSize: 12),),

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
                        Container(margin: EdgeInsets.symmetric(vertical: 10),  width: 1, color: Colors.grey, height: MediaQuery.of(context).size.height / 5 + 100,),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Ranges", style: TextStyle(color: Color(0xFFB7BCC5), fontSize: 25),),
                            Container(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),),
                            Container(
                              height: MediaQuery.of(context).size.height / 4,
                              width: MediaQuery.of(context).size.width / 1.7,
                              child: ListView.builder(
                              shrinkWrap: true,
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (context, index){
                                return TextFormField(
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderRadius: BorderRadius.circular(25)
                                                        ),
                                                        fillColor: Color(0xFF363A43),
                                                        filled: true,
                                                      ),
                                                      maxLength: 20,
                                                      style: TextStyle(fontSize: 20, color: Color(0xFFB7BCC5)),
                                                    );
                              },
                            ),
                            )
                          ],
                        ),
                        )
                      ],
                    )
                    ),
                ),
                RadioListTile<ImportMode>(
                  title: Text("Automatic", style: TextStyle(color: Color(0xFFB7BCC5), fontSize: 25),),
                  value: ImportMode.automatic,
                  groupValue: _modeSelected,
                  onChanged: (ImportMode value){
                    setState(() {
                      _modeSelected = value;
                      _controller.reverse();
                    });
                  },
                  activeColor: Color(0xFFB7BCC5),
                  contentPadding: EdgeInsets.fromLTRB(-50, 0, 0, 0),
                  subtitle: Text("Input one data range that occurs multiple times.", style: TextStyle(color: Color(0xFFB7BCC5), fontSize: 12),),

                ),
              ]
          ),
        )
      ),
    );
  }
}