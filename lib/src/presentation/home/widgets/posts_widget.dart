import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:somnio_test/src/shared/utils/string_utils.dart';
import 'package:somnio_test/src/domain/entities/post.dart';

class PostsWidget extends StatelessWidget {
  const PostsWidget({
    super.key,
    required this.posts,
  });

  final List<Post> posts;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return _PostWidget(post: posts[index]);
      },
    );
  }
}

class _PostWidget extends StatelessWidget {
  const _PostWidget({
    required this.post,
  });

  final Post post;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.deepPurple[800],
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Community",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            StringUtils.capitalize(post.title),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            StringUtils.capitalize(post.body),
            style: const TextStyle(),
          ),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              debugPrint("Go to post ${post.id}");
            },
            child: const Row(
              children: [
                Text(
                  'Read more',
                  style: TextStyle(
                    color: Colors.blueAccent,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.arrow_right_alt,
                  color: Colors.blueAccent,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
                imageUrl:
                    "https://technobrains.io/wp-content/uploads/2021/07/flutter-Featured-Blog-Image2.jpg"),
          ),
        ],
      ),
    );
  }
}
