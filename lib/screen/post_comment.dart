import 'package:cloudmed_app/bloc/comment/comment.dart';
import 'package:cloudmed_app/common/app_localizations.dart';
import 'package:cloudmed_app/common/app_theme/app_theme_cubit.dart';
import 'package:cloudmed_app/item/comment_item.dart';
import 'package:cloudmed_app/network/repository.dart';
import 'package:cloudmed_app/screen/send_comment.dart';
import 'package:cloudmed_app/widget/BaseAppBar.dart';
import 'package:cloudmed_app/widget/LoadingListPage.dart';
import 'package:cloudmed_app/widget/TryToConnectinWidget.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PostComment extends StatefulWidget {
  final Repository repository;
  final String post_id;

  PostComment(this.repository, {this.post_id});

  @override
  _PostCommentState createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  CommentListBloc _commentListBloc;

  @override
  void initState() {
    _commentListBloc = BlocProvider.of<CommentListBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesomeIcons.plus),
        onPressed: () => _navigateToSendComment(),
      ),
      appBar: BaseAppBar(
        appBar: AppBar(),
      ),
      body: NestedScrollViewRefreshIndicator(
        onRefresh: () {
          _commentListBloc.add(CommentListFetch());

          return Future.delayed(const Duration(seconds: 1));
        },
        child: BlocBuilder<CommentListBloc, CommentListState>(
          builder: (BuildContext context, CommentListState state) {
            if (state is CommentListUninitialized) {
              _commentListBloc.add(CommentListFetch());
            }
            if (state is CommentListError) {
              return TryToConnectionWidget(
                      context: context,
                      clickCallBack: () {
                        _commentListBloc.add(CommentListFetch());
                      },
                      error: state.error)
                  .get();
            }

            if (state is CommentListLoaded) {
              if (state.products.isEmpty) {
                return Center(
                  child: Text(AppLocalizations.of(context)
                      .translate("nothing_to_show")),
                );
              }
              return MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child: ListView.builder(
                  itemBuilder: (BuildContext context, int index) {
                    return CommentItem(
                      model: state.products[index],
                    );
                    //     : CommentItem(
                    //   isDark: getThemeBrightness(),
                    //   model: state.products[index],
                    // );
                  },
                  itemCount: state.products.length,
                ),
              );
            }

            return LoadingListPage(
              isDark: getThemeBrightness(),
            );
          },
        ),
      ),
    );
  }

  ///get theme property
  bool getThemeBrightness() {
    return context.bloc<AppThemeCubit>().isDark;
  }

  ///navigate to send comment
  _navigateToSendComment() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return SendComment(
        widget.repository,
        post_id: widget.post_id,
      );
    }));
  }
}
