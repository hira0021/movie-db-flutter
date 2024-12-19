import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import 'package:movie_db/cubit/movies_cubit.dart';
import 'package:movie_db/models/movie_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PagingController<int, MovieModel> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener((pageKey) {
      _fetchMovies(pageKey);
    });
  }

  Future<void> _fetchMovies(int page) async {
    try {
      final moviesCubit = context.read<MoviesCubit>();
      final response = await moviesCubit.getPaginatedMovieList(
        queryParams: {
          'page': page.toString(),
        },
      );

      final movies = response.results;
      final totalPages = response.totalPages;

      if (page >= totalPages) {
        _pagingController.appendLastPage(movies);
      } else {
        final nextPageKey = page + 1;
        _pagingController.appendPage(movies, nextPageKey);
      }
    } catch (error) {
      _pagingController.error = error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movies with Pagination'),
      ),
      body: Column(
        children: [
          Expanded(
            child: PagedListView<int, MovieModel>(
              pagingController: _pagingController,
              builderDelegate: PagedChildBuilderDelegate<MovieModel>(
                itemBuilder: (context, movie, index) {
                  return ListTile(
                    title: Text(movie.title),
                    subtitle: Text(movie.overview),
                  );
                },
                firstPageErrorIndicatorBuilder: (context) => const Center(
                  child: Text("Error loading movies."),
                ),
                newPageErrorIndicatorBuilder: (context) => const Center(
                  child: Text("Error loading more movies."),
                ),
                firstPageProgressIndicatorBuilder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
                newPageProgressIndicatorBuilder: (context) => const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}
