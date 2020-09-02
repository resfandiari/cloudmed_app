import 'package:cloudmed_app/model/model.dart';
import 'package:cloudmed_app/widget/DashPathBorder.dart';
import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class CommentItem extends StatelessWidget {
  Comment model;

  CommentItem({Key key, this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 120),
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: new BoxDecoration(
        border: DashPathBorder.all(
          dashArray: CircularIntervalList<double>(<double>[5.0, 2.5]),
        ),
        borderRadius: new BorderRadius.circular(10.0),
      ),
      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.person_pin,
                    // color: Singleton.myColors[10].color,
                    size: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      checkVar(model.user.name),
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Container(),
              ),
              SizedBox(
                width: 5,
              ),
              Icon(
                Icons.report,
                color: Colors.redAccent,
              ),
            ],
          ),
          Divider(),
          Align(
            alignment: Alignment.topRight,
            child: Text(checkVar(model.description)),
          )
        ],
      ),
    );
  }

  String checkVar(String input) {
    if (input != null && input.length != 0) {
      return input;
    }
    return "";
  }
}
