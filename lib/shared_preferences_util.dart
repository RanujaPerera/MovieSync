import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moviesync/models/movie.dart';

class SharedPreferencesUtil {
  static Future<void> saveWatchList(List<Movie> watchList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String watchListJson = jsonEncode(watchList);
    prefs.setString('watchList', watchListJson);
  }

  static Future<List<Movie>> loadWatchList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String watchListJson = prefs.getString('watchList') ?? '[]';
    final List<Movie> watchList = (jsonDecode(watchListJson) as List)
        .map((item) => Movie.fromJson(item))
        .toList();
    return watchList;
  }
}