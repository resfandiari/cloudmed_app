import 'package:cloudmed_app/bloc/post/post.dart';
import 'package:cloudmed_app/common/app_localizations.dart';
import 'package:cloudmed_app/common/app_theme/app_theme_cubit.dart';
import 'package:cloudmed_app/item/post_item.dart';
import 'package:cloudmed_app/widget/BottomLoader.dart';
import 'package:cloudmed_app/widget/LoadingListPage.dart';
import 'package:cloudmed_app/widget/TryToConnectinWidget.dart';
import 'package:extended_nested_scroll_view/extended_nested_scroll_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  PostListBloc _postListBloc;
  final _scrollThreshold = 200.0;

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
                  return index >= state.products.length
                      ? BottomLoader()
                      : PostItem(
                          isDark: getThemeBrightness(),
                          model: state.products[index],
                        );
                },
                itemCount: state.hasReachedMax
                    ? state.products.length
                    : state.products.length + 1,
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
}
