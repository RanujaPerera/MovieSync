import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:moviesync/constants.dart';
import 'package:http/http.dart' as http;
import 'package:moviesync/details_screen.dart';
import 'package:moviesync/models/movie.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _searchController;
  late Future<List<dynamic>> _searchResults;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchResults = Future.value([]);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<List<dynamic>> _searchMovies(String query) async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/search/multi?query=$query&api_key=${Constants.apiKey}',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['results'] ?? [];
    } else {
      throw Exception('Failed to search movies, TV shows, and actors');
    }
  }

  Future<List<dynamic>> _searchMoviesByActor(String actorName) async {
    final response = await http.get(
      Uri.parse(
        'https://api.themoviedb.org/3/search/person?query=$actorName&api_key=${Constants.apiKey}',
      ),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final actorId = data['results'][0]['id'];
      final actorMoviesResponse = await http.get(
        Uri.parse(
          'https://api.themoviedb.org/3/discover/movie?with_cast=$actorId&api_key=${Constants.apiKey}',
        ),
      );
      if (actorMoviesResponse.statusCode == 200) {
        final Map<String, dynamic> actorMoviesData = jsonDecode(actorMoviesResponse.body);
        return actorMoviesData['results'] ?? [];
      } else {
        throw Exception('Failed to search movies by actor');
      }
    } else {
      throw Exception('Failed to search for actor');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search movies, TV shows, or actors...',
          ),
          onChanged: (query) {
            setState(() {
              _searchResults = query.isEmpty ? Future.value([]) : _searchMovies(query);
            });
          },
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: _searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final item = snapshot.data![index];
                if (item['media_type'] == 'person') {
                  // Display actor
                  return ListTile(
                    title: Text(item['name']),
                    onTap: () {
                      setState(() {
                        _searchResults = _searchMoviesByActor(item['name']);
                      });
                    },
                  );
                } else {
                  // Display movie or TV show
                  final title = item['title'] ?? item['name'] ?? 'Unknown';
                  final posterPath = item['poster_path'] ?? '';
                  return ListTile(
                    leading: posterPath.isNotEmpty
                        ? Image.network(
                            'https://image.tmdb.org/t/p/w200$posterPath',
                            width: 50,
                          )
                        : Container(
                            width: 50,
                            height: 75,
                            color: Colors.grey,
                            child: Icon(Icons.movie),
                          ),
                    title: Text(title),
                    subtitle: Text('Rating: ${item['vote_average']?.toString() ?? 'N/A'}'),
                    onTap: () {
                      // Navigate to movie or TV show details screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailsScreen(
                            movie: Movie.fromJson(item),
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            );
          } else {
            return Center(
              child: Text('No results found'),
            );
          }
        },
      ),
    );
  }
}
