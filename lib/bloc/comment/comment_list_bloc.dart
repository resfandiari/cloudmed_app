import 'package:bloc/bloc.dart';
import 'package:cloudmed_app/model/comment.dart';
import 'package:cloudmed_app/network/repository.dart';
import 'package:flutter/material.dart';

import 'comment.dart';

class CommentListBloc extends Bloc<CommentListEvent, CommentListState> {
  final Repository repository;
  final String post_id;

  CommentListBloc(this.repository, {@required this.post_id})
      : super(CommentListUninitialized());

  @override
  Stream<CommentListState> mapEventToState(CommentListEvent event) async* {
    try {
      if (event is CommentListFetch) {
        yield CommentListProgress();
        final json = await repository.getPostComment(post_id: post_id);

        //add ad to list
        List<Comment> list = json['data'];

        yield CommentListLoaded(products: list);
        return;
      }
    } catch (e) {
      yield CommentListError(
          error: e.toString().contains('Exception:')
              ? e.toString().replaceAll('Exception:', "")
              : e.toString());
    }
  }
}
