import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:somnio_test/src/data/providers/posts_provider.dart';
import 'package:somnio_test/src/domain/repositories/contracts/posts_repository.dart';
import 'package:somnio_test/src/domain/repositories/implementations/posts_repository_impl.dart';
import 'package:somnio_test/src/presentation/home/state/posts_cubit.dart';

final getIt = GetIt.instance;

void diSetup() {
  // Data layer
  getIt.registerLazySingleton<http.Client>(() => http.Client());
  getIt.registerLazySingleton<PostsProvider>(
      () => PostsProvider(getIt<http.Client>()));

  // Domain layer
  getIt.registerLazySingleton<PostsRepository>(
      () => PostsRepositoryImpl(getIt<PostsProvider>()));

  // Presentation layer
  getIt.registerLazySingleton<PostsCubit>(
      () => PostsCubit(getIt<PostsRepository>()));
}
