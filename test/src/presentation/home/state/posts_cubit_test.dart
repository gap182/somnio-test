import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:somnio_test/src/domain/entities/post.dart';
import 'package:somnio_test/src/domain/repositories/contracts/posts_repository.dart';
import 'package:somnio_test/src/presentation/home/state/posts_cubit.dart';
import 'package:somnio_test/src/presentation/home/state/posts_state.dart';

class MockPostsRepository extends Mock implements PostsRepository {}

void main() {
  late PostsRepository postsRepository;
  late PostsCubit postsCubit;
  const PostsState postsInitState = PostsState();

  const fakePostsData = [
    Post(id: 1, userId: 1, title: 'title 1', body: 'body 1'),
    Post(id: 2, userId: 2, title: 'title 2', body: 'body 2'),
  ];

  setUp(() {
    postsRepository = MockPostsRepository();
    postsCubit = PostsCubit(postsRepository);
  });

  group('getPosts', () {
    test('should return a list of posts when the getPosts method is called',
        () async {
      when(() => postsRepository.getPosts())
          .thenAnswer((_) async => fakePostsData);

      expect(postsCubit.state, equals(postsInitState));

      postsCubit.getPosts();

      expect(postsCubit.state,
          equals(postsInitState.copyWith(status: PostsStatus.loading)));

      await untilCalled(() => postsRepository.getPosts());

      expect(
          postsCubit.state,
          equals(postsInitState.copyWith(
              status: PostsStatus.loaded, posts: fakePostsData)));

      verify(() => postsRepository.getPosts()).called(1);
      expect(postsCubit.state.posts, fakePostsData);
      verifyNoMoreInteractions(postsRepository);
    });

    test('should return an error when the getPosts method throws an exception',
        () async {
      when(() => postsRepository.getPosts())
          .thenThrow(Exception('An error occurred'));

      await postsCubit.getPosts();

      verify(() => postsRepository.getPosts()).called(1);
      expect(postsCubit.state.error, 'Exception: An error occurred');
    });
  });
}
