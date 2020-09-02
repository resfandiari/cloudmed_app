import 'package:cloudmed_app/bloc/comment/comment.dart';
import 'package:cloudmed_app/bloc/post/post.dart';
import 'package:cloudmed_app/common/app_localizations.dart';
import 'package:cloudmed_app/common/app_theme/app_theme_cubit.dart';
import 'package:cloudmed_app/item/post_item.dart';
import 'package:cloudmed_app/model/model.dart';
import 'package:cloudmed_app/network/repository.dart';
import 'package:cloudmed_app/widget/BottomLoader.dart';
import 'package:cloudmed_app/widget/LoadingListPage.dart';
import 'package:cloudmed_app/widget/TryToConnectinWidget.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'post_comment.dart';

class Home extends StatefulWidget {
  final Repository repository;

  Home(this.repository);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PostListBloc _postListBloc;
  final _scrollThreshold = 200.0;
  List<Data> dataList = [];

  @override
  void initState() {
    _postListBloc = BlocProvider.of<PostListBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollViewRefreshIndicator(onRefresh: () {
      _postListBloc.add(PostListRefresh());

      return Future.delayed(const Duration(seconds: 1));
    }, child: BlocBuilder<PostListBloc, PostListState>(
      builder: (BuildContext context, PostListState state) {
        if (state is PostListUninitialized) {
          _postListBloc.add(PostListFetch());
        }
        if (state is PostListError) {
          return TryToConnectionWidget(
                  context: context,
                  clickCallBack: () {
                    _postListBloc.add(PostListRefresh());
                  },
                  error: state.error)
              .get();
        }

        if (state is PostListLoaded) {
          if (state.products.isEmpty) {
            return Center(
              child: Text(
                  AppLocalizations.of(context).translate("nothing_to_show")),
            );
          }

          ///add all data to list for local change
          dataList = state.products;

          return NotificationListener<ScrollNotification>(
            onNotification: (scrollNotification) {
              if (scrollNotification is ScrollEndNotification) {
                _onEndScroll(scrollNotification.metrics);
              }
            },
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= dataList.length
                      ? BottomLoader()
                      : PostItem(
                          isDark: getThemeBrightness(),
                          model: dataList[index],
                          onLikeClick: () => _likeOrUnlikePost(index),
                          onCommentClick: () => _navigateToComment(
                              post_id: state.products[index].id.toString()));
                },
                itemCount:
                    state.hasReachedMax ? dataList.length : dataList.length + 1,
              ),
            ),
          );
        }

        return LoadingListPage(
          isDark: getThemeBrightness(),
        );
      },
    ));
  }

  ///get new post in scroll down
  _onEndScroll(ScrollMetrics metrics) {
    final maxScroll = metrics.maxScrollExtent; //maxScroll
    final currentScroll = metrics.extentBefore; //currentScroll

    if (maxScroll - currentScroll <= _scrollThreshold) {
      _postListBloc.add(PostListFetch());
    }
  }

  ///get theme property
  bool getThemeBrightness() {
    return context.bloc<AppThemeCubit>().isDark;
  }

  ///navigate to show cooment
  _navigateToComment({String post_id}) {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return BlocProvider<CommentListBloc>(
        create: (context) =>
            CommentListBloc(widget.repository, post_id: post_id),
        child: PostComment(
          widget.repository,
          post_id: post_id,
        ),
      );
    }));
  }

  ///add like or unlike post
  _likeOrUnlikePost(int index) {
    _handleLikeLocalChange(index);

    widget.repository
        .postLikeAndUnlike(post_id: dataList[index].id.toString())
        .then((v) {
      print('print then $v');
    }).catchError((e) {
      Flushbar(
        title: "متاسفیم!",
        message: e.toString().contains('Exception:')
            ? e.toString().replaceAll('Exception:', "")
            : e.toString(),
        duration: Duration(seconds: 2),
      )..show(context).then((value) {
          _handleLikeLocalChange(index);
        });
      print('print catchError $e');
    });
  }

  ///local change for store like
  _handleLikeLocalChange(int index) {
    if (dataList[index].isLiked == 0) {
      dataList[index].isLiked = 1;
    } else
      dataList[index].isLiked = 0;
    setState(() {});
  }
}
