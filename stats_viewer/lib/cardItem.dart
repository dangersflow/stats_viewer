import 'package:flutter/material.dart';
import 'pageTransition.dart';

class CardItem extends StatefulWidget {
  String name;
  Icon icon;
  Widget Function() page;
  bool passPage;
  CardItem({this.name, this.icon, this.page, @required this.passPage});
  
  @override
  _CardItemState createState() => _CardItemState();
}

class _CardItemState extends State<CardItem> {
  
  
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      width: MediaQuery.of(context).size.width / 10,
      child: Card(
        color: Color(0xFF363A43),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: InkWell(
            onTap: () => {
              if(widget.passPage)
                Navigator.of(context).push(createRoute(Offset(0.0, 1.0), Offset(0.0, 0.0), Curves.fastLinearToSlowEaseIn, () => widget.page()))
            },
            borderRadius: BorderRadius.circular(30),
            child: Column(
            children: [
              widget.icon,
              Container(child: Text(widget.name, style: TextStyle(color: Color(0xFFB7BCC5), fontSize: 20, ),textAlign: TextAlign.center, ), padding: EdgeInsets.fromLTRB(20, 0, 20, 0),)
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        )
      ),
    );
  }
}