abstract class CommentListEvent {}

///for getting data
class CommentListFetch extends CommentListEvent {
  @override
  String toString() => 'Fetch ${this.runtimeType}';
}
