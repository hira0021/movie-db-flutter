import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movie_db/cubit/movies_cubit.dart';
import 'package:movie_db/models/movie_model.dart';
import 'package:movie_db/utils/general_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _fetchMovies();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchMovies() async {
    await context.read<MoviesCubit>().getMovieList();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      context.read<MoviesCubit>().getMovieList(
          queryParams: {'page': '${context.read<MoviesCubit>().currentPage}'});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies with Pagination'),
      ),
      body: BlocBuilder<MoviesCubit, GeneralState<List<MovieModel>>>(
        builder: (context, state) {
          if (state is LoadingState<List<MovieModel>> && !state.isPagination) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SuccessState<List<MovieModel>>) {
            final movies = state.data;

            return ListView.builder(
              controller: _scrollController,
              itemCount:
                  movies.length + 1, // Add extra space for pagination loader
              itemBuilder: (context, index) {
                if (index == movies.length) {
                  // Show loader when fetching next page
                  final isPaginationLoader =
                      context.read<MoviesCubit>().isFetchingPagination;
                  if (isPaginationLoader) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return const SizedBox(); // Empty placeholder
                }

                final movie = movies[index];
                return ListTile(
                  title: Text(movie.title),
                  subtitle: Text(movie.overview),
                );
              },
            );
          } else if (state is ErrorState<List<MovieModel>>) {
            return Center(child: Text("Error: ${state.message}"));
          }

          return const Center(child: Text("No movies available."));
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}
