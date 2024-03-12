import 'package:flutter/material.dart';
import 'package:moviesync/constants.dart';
import 'package:moviesync/details_screen.dart';
import 'package:moviesync/models/movie.dart'; // Import the Movie model

class MovieSlider extends StatelessWidget {
  const MovieSlider({
    Key? key, // Fix key declaration
    required this.snapshot,
  }) : super(key: key);

  final AsyncSnapshot<List<Movie>> snapshot; // Specify the generic type as List<Movie>

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                context, 
                MaterialPageRoute(
                  builder: (context) => DetailsScreen(
                  movie: snapshot.data![index],
              ),
              ),
              );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 200,
                  width: 150,
                  child: Image.network(
                    '${Constants.imagePath}${snapshot.data![index].posterPath}',
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
