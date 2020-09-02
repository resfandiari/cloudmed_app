import 'package:cloudmed_app/common/app_localizations.dart';
import 'package:cloudmed_app/model/comment_req.dart';
import 'package:cloudmed_app/network/repository.dart';
import 'package:cloudmed_app/widget/BaseAppBar.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SendComment extends StatefulWidget {
  final Repository repository;
  String post_id;

  SendComment(this.repository, {Key key, this.post_id}) : super(key: key);

  @override
  _SendCommentState createState() => _SendCommentState();
}

class _SendCommentState extends State<SendComment> {
  final commentController = TextEditingController();
  //dialog
  ProgressDialog pr;

  @override
  void dispose() {
    super.dispose();
    commentController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ///config dialog
    pr = new ProgressDialog(context,
        type: ProgressDialogType.Normal,
        isDismissible: false,
        showLogs: false,
        textDirection: TextDirection.rtl);
    pr.style(message: "در حال ارسال...", textAlign: TextAlign.start);

    return Scaffold(
      appBar: BaseAppBar(
        appBar: AppBar(),
      ),
      persistentFooterButtons: <Widget>[
        MaterialButton(
            color: Theme.of(context).accentColor,
            child: Text(
              AppLocalizations.of(context).translate("send"),
              style: TextStyle(
                fontSize: ScreenUtil().setSp(40),
                fontFamily: "Vazir",
              ),
            ),
            onPressed: () => _validateFields(),
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
            elevation: 2,
            highlightElevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)))
      ],
      body: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "متن کامنت",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(44),
                            fontFamily: "VazirM",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          "لطفا قوانین و مقررات مرسوم کشور را در متن ارسالی خود رعایت کنید سپاس گذاریم.",
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(40),
                            fontFamily: "Vazir",
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: TextField(
                          controller: commentController,
                          maxLines: 6,
                          maxLength: 220,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.start,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.black),
                          decoration: new InputDecoration(
                            contentPadding: const EdgeInsets.only(
                                top: 10, right: 5, bottom: 10, left: 5),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey, width: 2)),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.redAccent, width: 2)),
                            errorStyle: TextStyle(color: Colors.redAccent),
                          )),
                    ),
                  ]))),
    );
  }

  ///validate comment fields
  _validateFields() async {
    if (commentController.text != null && commentController.text.length != 0) {
      FocusScope.of(context).requestFocus(new FocusNode()); //remove focus
      await pr.show();
      _sendComment();
    } else {
      Flushbar(
        message: "لطفا نظر خود را وارد کنید.",
        duration: Duration(seconds: 2),
      )..show(context);
    }
  }

  ///send comment to server
  _sendComment() {
    widget.repository
        .sendPostComment(
            commentReq: CommentReq(
                postId: int.tryParse(widget.post_id),
                description: commentController.text))
        .then((v) {
      print('print then $v');

      if (pr.isShowing()) {
        pr.hide();
      }
      Navigator.of(context).pop();
    }).catchError((e) {
      if (pr.isShowing()) {
        pr.hide();
      }
      Flushbar(
        title: "متاسفیم!",
        message: e.toString().contains('Exception:')
            ? e.toString().replaceAll('Exception:', "")
            : e.toString(),
        duration: Duration(seconds: 2),
      )..show(context);
      print('print catchError $e');
    });
  }
}
