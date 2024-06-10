import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:somnio_test/src/data/models/post_model.dart';
import 'package:somnio_test/src/data/providers/posts_provider.dart';
import 'package:somnio_test/src/domain/repositories/contracts/posts_repository.dart';
import 'package:somnio_test/src/domain/repositories/implementations/posts_repository_impl.dart';

class MockPostsProvider extends Mock implements PostsProvider {}

void main() {
  late PostsProvider provider;
  late PostsRepository repository;

  const fakePostsData = [
    PostModel(id: 1, userId: 1, title: 'title 1', body: 'body 1'),
    PostModel(id: 2, userId: 2, title: 'title 2', body: 'body 2'),
  ];

  setUp(() {
    provider = MockPostsProvider();
    repository = PostsRepositoryImpl(provider);
  });

  group('fetchPosts', () {
    test('returns posts if the http call completes successfully', () async {
      when(() => provider.getPosts()).thenAnswer((_) async => fakePostsData);

      final posts = await repository.getPosts();

      verify(() => provider.getPosts()).called(1);
      expect(posts, hasLength(2));
      verifyNoMoreInteractions(provider);
    });
  });
}
