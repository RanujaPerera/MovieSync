import 'package:moviesync/constants.dart';
import 'package:moviesync/models/movie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Api {
  static const _trendingUrl = 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';
  static const _nowPlayingUrl = 'https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apiKey}';
  static const _upcomingUrl = 'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';
  static const _kidsMoviesUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&certification_country=US&certification=PG';
  static const _popularTVUrl = 'https://api.themoviedb.org/3/tv/popular?api_key=${Constants.apiKey}';
  static const _onAirTVUrl = 'https://api.themoviedb.org/3/tv/airing_today?api_key=${Constants.apiKey}';
  

Future<List<Movie>> getTrendingMovies() async {
  final response = await http.get(Uri.parse(_trendingUrl));
  if (response.statusCode == 200) {
    final decodedData = json.decode(response.body)['results'] as List;
    return decodedData.map((movie) => Movie.fromJson(movie)).toList();
  }else{
    throw Exception ('Something went wrong');
  }
}

Future<List<Movie>> getNowPlayingMovies() async {
  final response = await http.get(Uri.parse(_nowPlayingUrl));
  if (response.statusCode == 200) {
    final decodedData = json.decode(response.body)['results'] as List;
    return decodedData.map((movie) => Movie.fromJson(movie)).toList();
  }else{
    throw Exception ('Something went wrong');
  }
}

Future<List<Movie>> getUpcomingMovies() async {
  final response = await http.get(Uri.parse(_upcomingUrl));
  if (response.statusCode == 200) {
    final decodedData = json.decode(response.body)['results'] as List;
    return decodedData.map((movie) => Movie.fromJson(movie)).toList();
  }else{
    throw Exception ('Something went wrong');
  }
}

Future<List<Movie>> getKidsMovies() async {
  final response = await http.get(Uri.parse(_kidsMoviesUrl));
  if (response.statusCode == 200) {
    final decodedData = json.decode(response.body)['results'] as List;
    return decodedData.map((movie) => Movie.fromJson(movie)).toList();
  }else{
    throw Exception ('Something went wrong');
  }
}

Future<List<Movie>> getPopularTVShows() async {
  final response = await http.get(Uri.parse(_popularTVUrl));
  if (response.statusCode == 200) {
    final decodedData = json.decode(response.body)['results'] as List;
    return decodedData.map((movie) => Movie.fromJson(movie)).toList();
  }else{
    throw Exception ('Something went wrong');
  }
}

Future<List<Movie>> getOnAirTVShows() async {
  final response = await http.get(Uri.parse(_onAirTVUrl));
  if (response.statusCode == 200) {
    final decodedData = json.decode(response.body)['results'] as List;
    return decodedData.map((movie) => Movie.fromJson(movie)).toList();
  }else{
    throw Exception ('Something went wrong');
  }
}
}