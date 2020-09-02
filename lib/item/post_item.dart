import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloudmed_app/common/app_localizations.dart';
import 'package:cloudmed_app/common/constants.dart';
import 'package:cloudmed_app/model/data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostItem extends StatefulWidget {
  final Data model;
  final bool isDark;
  final VoidCallback onCommentClick;
  final VoidCallback onLikeClick;

  PostItem({this.model, this.isDark, this.onCommentClick, this.onLikeClick});

  @override
  _PostItemState createState() => _PostItemState();
}

class _PostItemState extends State<PostItem> {
  @override
  Widget build(BuildContext context) {
    print("is like ${widget.model.isLiked}");
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                child: Icon(
                  FontAwesomeIcons.user,
                  color: Colors.white,
                ),
                radius: 15,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                widget.model.user.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Expanded(
                child: Container(),
              ),
              Icon(Icons.more_vert)
            ],
          ),
        ),
        CachedNetworkImage(
            imageUrl: widget.model.images.first.imageUrl,
            width: ScreenUtil.screenWidth,
            fit: BoxFit.cover,
            fadeOutDuration: const Duration(seconds: 1),
            fadeInDuration: const Duration(seconds: 3),
            placeholder: (context, url) =>
                Center(child: new CircularProgressIndicator()),
            errorWidget: (context, url, error) => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.error),
                    Text(
                      AppLocalizations.of(context)
                          .translate("unable_load_image"),
                      style: TextStyle(fontFamily: "Vazir"),
                    )
                  ],
                )),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              IconButton(
                icon: Icon(widget.model.isLiked == 0
                    ? Icons.favorite_border
                    : Icons.favorite),
                onPressed: () => widget.onLikeClick.call(),
              ),
              SizedBox(
                width: 12,
              ),
              IconButton(
                icon: Icon(Icons.comment),
                onPressed: () => widget.onCommentClick.call(),
              ),
              SizedBox(
                width: 12,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.send),
              ),
              Expanded(
                child: Container(),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.turned_in_not),
              ),
            ],
          ),
        )
      ],
    );
  }
}
