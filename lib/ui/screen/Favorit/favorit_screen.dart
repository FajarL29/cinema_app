import 'package:cinema_app/ui/constant/color_pallete.dart';
import 'package:cinema_app/ui/constant/constant.dart';
import 'package:cinema_app/ui/screen/Favorit/cubit/favorit_cubit.dart';
import 'package:cinema_app/ui/screen/Favorit/cubit/favorit_state.dart';
import 'package:cinema_app/ui/screen/detail/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class FavoriteScreen extends StatelessWidget {
  
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      appBar: AppBar(
        title: const Text(
          'Favorite',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: ColorPallete.colorPrimary,
      ),
      body: BlocBuilder<FavoriteCubit, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteLoaded) {
            if (state.favorites.isEmpty) {
              return Center(
                  child: Text(
                "Belum Ada favorite",
                style: TextStyle(color: Colors.white),
              ));
            }
            return ListView.builder(
              itemCount: state.favorites.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DetailMoviePage(
                          id: state.favorites[index].data.id!,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            '${Constants.imageBaseUrl}${'/original'}${state.favorites[index].data.posterPath}',
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(Icons.photo);
                            },
                            width: 100,
                          ),
                        ),
                        const SizedBox(width: 24),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${state.favorites[index].data.title}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                state.favorites[index].data.overview ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              //    
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }
          return SizedBox(child: Text('belum ada'),);
        },
      ),
    );
  }
}