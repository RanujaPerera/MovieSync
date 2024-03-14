import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:moviesync/api/api.dart';
import 'package:moviesync/models/movie.dart';
import 'package:moviesync/watchlist_screen.dart';
import 'package:moviesync/search_screen.dart';
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
  late Future<List<Movie>> bestMovies;
  late Future<List<Movie>> grossingMovies;
  late Future<List<Movie>> kidsMovies;
  late Future<List<Movie>> popularTVShows;
  late Future<List<Movie>> onAirTVShows;
  late Future<List<Movie>> searchResults;
  late Future<List<Movie>> actorResults;
  
  @override
  void initState() {
    super.initState();
    trendingMovies = Api().getTrendingMovies();
    nowPlayingMovies = Api().getNowPlayingMovies();
    upcomingMovies = Api().getUpcomingMovies();
    bestMovies = Api().getBestMovies();
    grossingMovies = Api().getGrossingMovies();
    kidsMovies = Api().getKidsMovies();
    popularTVShows = Api().getPopularTVShows();
    onAirTVShows = Api().getOnAirTVShows();
    searchResults = Future.value([]);
    actorResults = Future.value([]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 6, 3, 45),
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
          icon: Icon(Icons.menu,
          color: Colors.white),
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
                  value: 'Quit',
                  child: Text('Quit'),
                ),
                PopupMenuItem<String>(
                  value: 'Sign Out',
                  child: Text('Sign Out'),
                ),
              ],
              elevation: 8.0,
            ).then((String? value) {
              if (value != null) {
                // Handle menu item selection here
                switch (value) {
                  case 'Home':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                    break;
                  case 'Watch List':
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>WatchListScreen(watchList: [],)),
                  );
                    break;
                  case 'Quit':
                    SystemNavigator.pop();
                    break;
                    case 'Sign Out':
                    
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
            icon: Icon(
              Icons.search,
              color: Colors.white,
              ),
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
                  fontSize: 48, // Adjust the font size as desired
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ), 
              const SizedBox(height: 30),
              Text(
                'Trending Movies',
                  style: TextStyle(
                   color: Colors.white,
                ),
              ),
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
              Text(
                'Now Playing',
                  style: TextStyle(
                   color: Colors.white,
                ),
              ),
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
              Text(
                'Upcoming Movies',
                  style: TextStyle(
                   color: Colors.white,
                ),
              ),
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
              Text(
                'Best Movies 2024',
                  style: TextStyle(
                   color: Colors.white,
                ),
              ),
              const SizedBox(height: 30), 
              SizedBox(
                child: FutureBuilder<List<Movie>>(
                  future: bestMovies,
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
              Text(
                'Grossing Movies',
                  style: TextStyle(
                   color: Colors.white,
                ),
              ),
              const SizedBox(height: 30), 
              SizedBox(
                child: FutureBuilder<List<Movie>>(
                  future: grossingMovies,
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
              Text(
                'Kids Movies',
                  style: TextStyle(
                   color: Colors.white,
                ),
              ),
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
                  fontSize: 48, // Adjust the font size as desired
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 30),
              Text(
                'Popular Tv Shows',
                  style: TextStyle(
                   color: Colors.white,
                ),
              ),
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
              Text(
                'On Air TV Shows',
                  style: TextStyle(
                   color: Colors.white,
                ),
              ),
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
