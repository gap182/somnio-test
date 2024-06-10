import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:somnio_test/src/data/providers/posts_provider.dart';
import 'package:somnio_test/src/shared/values/constants.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late PostsProvider postsProvider;
  late http.Client client;
  const fakePostsDataSuccess = '''[
   {
    "userId": 1,
    "id": 1,
    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
    "body": "quia et suscipit suscipit recusandae consequuntur expedita et cumreprehenderit molestiae ut ut quas totamnostrum rerum est autem sunt rem eveniet architecto"
  },
  {
    "userId": 1,
    "id": 2,
    "title": "qui est esse",
    "body": "est rerum tempore vitaesequi sint nihil reprehenderit dolor beatae ea dolores nequefugiat blanditiis voluptate porro vel nihil molestiae ut reiciendisqui aperiam non debitis possimus qui neque nisi nulla"
  },
  {
    "userId": 1,
    "id": 3,
    "title": "ea molestias quasi exercitationem repellat qui ipsa sit aut",
    "body": "et iusto sed quo iurevoluptatem occaecati omnis eligendi aut advoluptatem doloribus vel accusantium quis pariaturmolestiae porro eius odio et labore et velit aut"
  }
  ]''';

  final url = Uri.parse('${Constants.baseUrl}/posts');

  setUp(() {
    client = MockHttpClient();
    postsProvider = PostsProvider(client);
  });
  group('Posts provider', () {
    test('Should return a list of posts if succesful', () async {
      // Arrange
      when(() => client.get(url))
          .thenAnswer((_) async => http.Response(fakePostsDataSuccess, 200));

      // Act
      final posts = await postsProvider.getPosts();

      // Assert
      verify(() => client.get(url));
      expect(posts, isNotEmpty);
      verifyNoMoreInteractions(client);
    });

    test('Should throw an exception if the response code is not 200', () async {
      // Arrange
      when(() => client.get(url))
          .thenAnswer((_) async => http.Response('Not Found', 404));

      // Act
      final call = postsProvider.getPosts;

      // Assert
      expect(call, throwsException);
    });
  });
}
