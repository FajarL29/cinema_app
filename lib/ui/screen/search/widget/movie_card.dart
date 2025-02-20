
import 'package:cinema_app/domain/entities/movies.dart';
import 'package:cinema_app/ui/constant/constant.dart';
import 'package:flutter/material.dart';

class MovieCard extends StatelessWidget {
  final Movies movie;
  const MovieCard({super.key, required this.movie,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              '${Constants.imageBaseUrl500}${movie.posterPath}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.photo);
              },
              width: 100,
            ),
          ),
          const SizedBox(width: 24,),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),
                ),
                const SizedBox(height: 4,),
                SizedBox(
                  height: 100,
                  child: Text(
                    movie.overview,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.white
                    ),
                  ),
                )
              ],
            
            ),
          )
        ],
      ),
    );
  }
}