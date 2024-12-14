import 'package:flutter/material.dart';
import 'package:movie_db/api/api_call.dart';
import 'dart:developer' as developer;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  API api = API();
  bool _isLoading = false;

  Future<void> _callGetMovies() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var request = await api.callGetMovies();
      var data = request['body']['data'];

      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print(e);
      setState(() {
        _isLoading = false;
      });
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _callGetMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            _callGetMovies();
          },
          child: const Text("refresh"),
        ),
      ),
    );
  }
}
