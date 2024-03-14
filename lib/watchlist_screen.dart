import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:moviesync/constants.dart';
import 'package:moviesync/models/movie.dart';

class WatchListScreen extends StatefulWidget {
  final List<Movie> watchList;

  const WatchListScreen({Key? key, required this.watchList}) : super(key: key);

  @override
  _WatchListScreenState createState() => _WatchListScreenState();
}

class _WatchListScreenState extends State<WatchListScreen> {
  List<Movie> _watchList = [];

  @override
  void initState() {
    super.initState();
    _loadWatchList();
  }

  Future<void> _loadWatchList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String watchListJson = prefs.getString('watchList') ?? '[]';
    setState(() {
      _watchList = (jsonDecode(watchListJson) as List)
          .map((item) => Movie.fromJson(item))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watch List'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8.0,
          crossAxisSpacing: 8.0,
        ),
        itemCount: _watchList.length,
        itemBuilder: (context, index) {
          final movie = _watchList[index];
          return GestureDetector(
            onTap: () {
              // Navigate to the details screen for the selected movie
            },
            child: GridTile(
              child: Container(
                height: MediaQuery.of(context).size.width / 2 * (9 / 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ClipRRect(
  borderRadius: BorderRadius.circular(8.0),
  child: Image.network(
    '${Constants.imagePath}${movie.posterPath}',
    fit: BoxFit.cover,
    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
      print('Failed to load image: $exception\n$stackTrace');
      return Center(
        child: Text('Failed to load image'),
      );
    },
  ),
),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(
                  movie.title,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
