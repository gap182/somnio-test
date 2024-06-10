import 'package:equatable/equatable.dart';
import 'package:somnio_test/src/domain/entities/post.dart';

enum PostsStatus { initial, loading, loaded, error }

class PostsState extends Equatable {
  final PostsStatus status;
  final List<Post> posts;
  final String error;

  const PostsState({
    this.status = PostsStatus.initial,
    this.posts = const [],
    this.error = '',
  });

  PostsState copyWith({
    PostsStatus? status,
    List<Post>? posts,
    String? error,
  }) {
    return PostsState(
      status: status ?? this.status,
      posts: posts ?? this.posts,
      error: error ?? this.error,
    );
  }

  @override
  List<Object> get props => [status, posts, error];
}
