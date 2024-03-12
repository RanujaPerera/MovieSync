import 'package:flutter/material.dart';
import 'package:moviesync/details_screen.dart';
import 'package:moviesync/models/movie.dart';
import 'package:moviesync/constants.dart'; // Import Constants for image path

class WatchListScreen extends StatelessWidget {
  final List<Movie> watchList;

  const WatchListScreen({Key? key, required this.watchList}) : super(key: key);

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
        itemCount: watchList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              // Navigate to the details screen for the selected movie
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(movie: watchList[index]),
                ),
              );
            },
            child: GridTile(
              child: Container(
                height: MediaQuery.of(context).size.width / 2 * (9 / 16), // 9:16 aspect ratio
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: NetworkImage('${Constants.imagePath}${watchList[index].posterPath}'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              footer: GridTileBar(
                backgroundColor: Colors.black45,
                title: Text(
                  watchList[index].title,
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
