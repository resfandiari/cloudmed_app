import 'package:bloc/bloc.dart';
import 'package:cloudmed_app/model/data.dart';
import 'package:cloudmed_app/network/repository.dart';

import 'post.dart';

class PostListBloc extends Bloc<PostListEvent, PostListState> {
  PostListBloc(this.repository) : super(PostListUninitialized());

  final Repository repository;

  ///why after error we call refresh event
  ///because if we want call Fetch event we must story Data(page , product)
  ///to base class for when error be show add page to getPostList method
  ///and after that add product to PostListLoaded state

  @override
  Stream<PostListState> mapEventToState(PostListEvent event) async* {
    try {
      if (event is PostListFetch && !_hasReachedMax(state)) {
        if (state is PostListUninitialized) {
          final json = await repository.getPost(page: 1);

          //add ad to list
          List<Data> list = json['data'];

          yield PostListLoaded(
              products: list,
              hasReachedMax: json['total'] == list.length ? true : false,
              page: 2);
          return;
        } else if (state is PostListLoaded) {
          final json =
              await repository.getPost(page: (state as PostListLoaded).page);

          //add ad to list
          List<Data> list = json['data'];

          yield PostListLoaded(
              products: (state as PostListLoaded).products + list,
              hasReachedMax:
                  json['total'] == (state as PostListLoaded).products.length
                      ? true
                      : false,
              page: (state as PostListLoaded).page + 1);
        }
      } else if (event is PostListRefresh) {
        yield PostListUninitialized();

        final json = await repository.getPost(page: 1);

        //add ad to list
        List<Data> list = json['data'];

        yield PostListLoaded(
            products: list,
            hasReachedMax: json['total'] == list.length ? true : false,
            page: 2);
      }
    } catch (e) {
      yield PostListError(
          error: e.toString().contains('Exception:')
              ? e.toString().replaceAll('Exception:', "")
              : e.toString());
    }
  }

  bool _hasReachedMax(PostListState state) =>
      state is PostListLoaded && state.hasReachedMax;
}
