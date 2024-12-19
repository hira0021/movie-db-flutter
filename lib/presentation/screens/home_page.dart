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

  @override
  void initState() {
    super.initState();
    _fetchMovies();
  }

  Future<void> _fetchMovies() async {
    await context.read<MoviesCubit>().getMovieList();
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
            child: BlocBuilder<MoviesCubit, GeneralState<List<MovieModel>>>(
              builder: (context, state) {
                if (state is LoadingState<List<MovieModel>>) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is SuccessState<List<MovieModel>>) {
                  final movies = state.data;
                  return ListView.builder(
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
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
          ),
        ],
      ),
    );
  }
}
