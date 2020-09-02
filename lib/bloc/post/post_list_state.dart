import 'package:cloudmed_app/model/data.dart';

abstract class PostListState {}

class PostListUninitialized extends PostListState {}

class PostListError extends PostListState {
  String error = "";

  PostListError({this.error});
}

class PostListLoaded extends PostListState {
  List<Data> products = [];
  bool hasReachedMax = false;
  int page = 1;

  PostListLoaded({this.products, this.hasReachedMax, this.page});

//*We implemented copyWith so that we can copy an instance of
// PostState and update zero or more properties
// conveniently (this will come in handy later ).
  PostListLoaded copyWith({List<Data> products, bool hasReachedMax, int page}) {
    return PostListLoaded(
        products: products ?? this.products,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax,
        page: page ?? this.page);
  }
}
