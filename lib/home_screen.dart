import 'package:flutter/material.dart';
import 'package:moviesync/api/api.dart';
import 'package:moviesync/models/movie.dart';
import 'package:moviesync/widgets/search_bar.dart';
import 'package:moviesync/widgets/movie_slider.dart';
import 'package:moviesync/widgets/trending_slider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> nowPlayingMovies;
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> kidsMovies;
  late Future<List<Movie>> popularTVShows;
  late Future<List<Movie>> onAirTVShows;
  late Future<List<Movie>> searchResults;
  
  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    upcomingMovies = Api().getUpcomingMovies();
    nowPlayingMovies = Api().getNowPlayingMovies();
    kidsMovies = Api().getKidsMovies();
    popularTVShows = Api().getPopularTVShows();
    onAirTVShows = Api().getOnAirTVShows();
    searchResults = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 98, 73),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'asset/moviesynclogo.png',
          fit: BoxFit.cover,
          height: 80,
          filterQuality: FilterQuality.high,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            showMenu<String>(
              context: context,
              position: RelativeRect.fromLTRB(0, 100, 0, 0),
              items: <PopupMenuEntry<String>>[
                PopupMenuItem<String>(
                  value: 'Home',
                  child: Text('Home'),
                ),
                PopupMenuItem<String>(
                  value: 'Watch List',
                  child: Text('Watch List'),
                ),
                PopupMenuItem<String>(
                  value: 'Watched List',
                  child: Text('Watched List'),
                ),
                PopupMenuItem<String>(
                  value: 'Trivia',
                  child: Text('Trivia'),
                ),
                PopupMenuItem<String>(
                  value: 'Quit',
                  child: Text('Quit'),
                ),
              ],
              elevation: 8.0,
            ).then((String? value) {
              if (value != null) {
                // Handle menu item selection here
                switch (value) {
                  case 'Home':
                    // Handle Home button
                    break;
                  case 'Watch List':
                    // Handle Watch List button
                    break;
                  case 'Watched List':
                    // Handle Watched List button
                    break;
                  case 'Trivia':
                    // Handle Trivia button
                    break;
                  case 'Quit':
                    // Handle Quit button
                    break;
                  default:
                    break;
                }
              }
            });
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
          ),
        ],
      ),
      
      
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Movies',
                style: TextStyle(
                  fontSize: 24, // Adjust the font size as desired
                  fontWeight: FontWeight.bold,
                ),
              ), 
              const SizedBox(height: 30),
              Text('Trending Movies'),
              const SizedBox(height: 30),
              SizedBox(
                child: FutureBuilder<List<Movie>>(
                  future: trendingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return TrendingSlider(snapshot: snapshot);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),

              const SizedBox(height: 30),
              Text('Now Playing'),
              const SizedBox(height: 30), 
              SizedBox(
                child: FutureBuilder<List<Movie>>(
                  future: nowPlayingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return MovieSlider(snapshot: snapshot);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ), 


              const SizedBox(height: 30),
              Text('Upcoming Movies'),
              const SizedBox(height: 30), 
              SizedBox(
                child: FutureBuilder<List<Movie>>(
                  future: upcomingMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return MovieSlider(snapshot: snapshot);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ), 

              const SizedBox(height: 30),
              Text('Kids Movies'),
              const SizedBox(height: 30), 
              SizedBox(
                child: FutureBuilder<List<Movie>>(
                  future: kidsMovies,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return MovieSlider(snapshot: snapshot);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ), 


              Text(
                'TV Shows',
                style: TextStyle(
                  fontSize: 24, // Adjust the font size as desired
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              Text('Popular TV Shows'),
              const SizedBox(height: 30), 
              SizedBox(
                child: FutureBuilder<List<Movie>>(
                  future: popularTVShows,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return TrendingSlider(snapshot: snapshot);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ), 

              const SizedBox(height: 30),
              Text('On Air TV Shows'),
              const SizedBox(height: 30), 
              SizedBox(
                child: FutureBuilder<List<Movie>>(
                  future: onAirTVShows,
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error.toString()),
                      );
                    } else if (snapshot.hasData) {
                      return MovieSlider(snapshot: snapshot);
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
