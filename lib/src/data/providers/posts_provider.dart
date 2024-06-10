import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:somnio_test/src/data/models/post_model.dart';
import 'package:somnio_test/src/shared/values/constants.dart';

class PostsProvider {
  PostsProvider(this.client);

  final http.Client client;

  Future<List<PostModel>> getPosts() async {
    final url = Uri.parse('${Constants.baseUrl}/posts');
    final response = await client.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> postsJson = json.decode(response.body);

      try {
        final posts = postsJson.map((json) => PostModel.fromMap(json)).toList();
        return posts;
      } catch (e) {
        throw Exception('Error with data parsing in posts provider');
      }
    } else {
      throw Exception('Failed to load posts');
    }
  }
}
