import 'package:chucker_flutter/chucker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_db/cubit/movies_cubit.dart';
import 'package:movie_db/data/data_provider/movie_data_provider.dart';
import 'package:movie_db/data/repository/movie_repository.dart';
import 'package:movie_db/presentation/screens/home_page.dart';

void main() {
  ChuckerFlutter.showNotification = true;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => MovieRepository(MovieDataProvider()),
      child: BlocProvider(
        create: (context) => MoviesCubit(context.read<MovieRepository>()),
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          navigatorObservers: [ChuckerFlutter.navigatorObserver],
          home: const HomePage(),
        ),
      ),
    );
  }
}
