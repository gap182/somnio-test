import 'package:somnio_test/src/data/providers/posts_provider.dart';
import 'package:somnio_test/src/domain/entities/post.dart';
import 'package:somnio_test/src/domain/repositories/contracts/posts_repository.dart';
import 'package:somnio_test/src/shared/parsers/post_parser.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsProvider _postsProvider;

  PostsRepositoryImpl(this._postsProvider);

  @override
  Future<List<Post>> getPosts() async {
    final posts = await _postsProvider.getPosts();
    return posts.map((post) => post.toEntity()).toList();
  }
}
