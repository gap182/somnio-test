import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somnio_test/src/domain/repositories/contracts/posts_repository.dart';
import 'package:somnio_test/src/presentation/home/state/posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository _postsRepository;

  PostsCubit(this._postsRepository) : super(const PostsState());

  Future<void> getPosts() async {
    try {
      emit(state.copyWith(status: PostsStatus.loading));
      final posts = await _postsRepository.getPosts();
      emit(
        state.copyWith(
          status: PostsStatus.loaded,
          posts: posts,
          error: '',
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: PostsStatus.error, error: e.toString()));
    }
  }
}
