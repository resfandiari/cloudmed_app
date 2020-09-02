abstract class PostListEvent {}

///for getting data
class PostListFetch extends PostListEvent {
  @override
  String toString() => 'Fetch ${this.runtimeType}';
}

///for refresh data
class PostListRefresh extends PostListEvent {
  @override
  String toString() => 'Fetch ${this.runtimeType}';
}
