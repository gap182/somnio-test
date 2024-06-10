import 'package:somnio_test/src/domain/entities/post.dart';

abstract interface class PostsRepository {
  Future<List<Post>> getPosts();
}
