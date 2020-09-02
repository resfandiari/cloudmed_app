import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class ShimmerItem extends StatefulWidget {
  @override
  _ShimmerItemState createState() => _ShimmerItemState();
}

class _ShimmerItemState extends State<ShimmerItem> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: ScreenUtil.screenWidth / 4,
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(ScreenUtil().setHeight(4)),
                topLeft: Radius.circular(ScreenUtil().setHeight(4)),
              ),
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width: double.infinity,
            height: 8.0,
            color: Colors.white,
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width: double.infinity,
            height: 8.0,
            color: Colors.white,
          ),
          SizedBox(
            height: 4,
          ),
          Container(
            width: 100.0,
            height: 8.0,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}
