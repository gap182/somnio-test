import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:somnio_test/src/presentation/home/state/posts_cubit.dart';
import 'package:somnio_test/src/presentation/home/state/posts_state.dart';
import 'package:somnio_test/src/presentation/home/widgets/posts_widget.dart';
import 'package:somnio_test/src/shared/di/di.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    getIt<PostsCubit>().getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'BLOG',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Text(
                'The best software development frameworks to learn in 2024',
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const TabBar(
                      tabs: [
                        Text('Posts'),
                        Text('Videos'),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: TabBarView(
                        children: [
                          BlocBuilder<PostsCubit, PostsState>(
                              bloc: getIt<PostsCubit>(),
                              builder: (context, state) {
                                if (state.status == PostsStatus.loading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }

                                if (state.status == PostsStatus.error) {
                                  return const Center(
                                    child: Text(
                                        'Ups, something went wrong! please try again later.'),
                                  );
                                }

                                return PostsWidget(
                                  posts: state.posts,
                                );
                              }),
                          const Center(
                            child: Text('No videos yet, comming soon!'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
