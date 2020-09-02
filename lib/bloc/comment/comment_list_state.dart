import 'package:cloudmed_app/model/comment.dart';

abstract class CommentListState {}

class CommentListUninitialized extends CommentListState {}

class CommentListError extends CommentListState {
  String error = "";

  CommentListError({this.error});
}

class CommentListLoaded extends CommentListState {
  List<Comment> products = [];

  CommentListLoaded({this.products});
}

class CommentListProgress extends CommentListState {}
