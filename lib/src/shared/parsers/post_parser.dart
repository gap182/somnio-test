import 'package:somnio_test/src/data/models/post_model.dart';
import 'package:somnio_test/src/domain/entities/post.dart';

extension PostModelX on PostModel {
  Post toEntity() => Post(
        id: id,
        title: title,
        body: body,
        userId: userId,
      );
}
