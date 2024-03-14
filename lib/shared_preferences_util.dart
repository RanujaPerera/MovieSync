import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moviesync/models/movie.dart';

class SharedPreferencesUtil {
  static Future<void> saveWatchList(List<Movie> watchList) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> watchListJson = watchList.map((movie) => movie.toJson()).toList();
    prefs.setString('watchList', jsonEncode(watchListJson));
  }

  static Future<List<Movie>> loadWatchList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String watchListJson = prefs.getString('watchList') ?? '[]';
    final List<dynamic> watchListData = jsonDecode(watchListJson);
    final List<Movie> watchList = watchListData.map((item) => Movie.fromJson(item)).toList();
    return watchList;
  }
}
