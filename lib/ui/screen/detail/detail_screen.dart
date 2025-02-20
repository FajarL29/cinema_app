import 'package:cinema_app/domain/entities/favorite.dart';
//import 'package:cinema_app/domain/entities/movies.dart';
import 'package:cinema_app/ui/screen/Favorit/cubit/favorit_cubit.dart';
import 'package:cinema_app/ui/screen/Favorit/cubit/favorit_state.dart';
import 'package:cinema_app/ui/screen/reservation/reservation_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_app/ui/constant/color_pallete.dart';
import 'package:cinema_app/ui/constant/constant.dart';
import 'package:cinema_app/ui/screen/detail/cubit/detail_movie_cubit.dart';

class DetailMovieScreen extends StatelessWidget {
  DetailMovieScreen({
    super.key,
  });

  bool isBookmarked = false;
  // final String title;
  // final int idmovie;
  // final String urlimage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      floatingActionButton: BlocBuilder<DetailMovieCubit, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoaded) {
            
          context.read<FavoriteCubit>().checkFavorite(state.data.id ?? 0);
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.5,
              height: 40,
              child: FloatingActionButton.extended(
                backgroundColor: ColorPallete.colorOrange,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ReservationPage(
                        title: state.data.title ?? '',
                        idmovie: state.data.id ?? 0,
                        imagePath:
                            '${Constants.imageBaseUrl}/original${state.data.posterPath}',
                      ),
                    ),
                  );
                },
                label: const Text(
                  'Get Reservation',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            );
          }
          return const SizedBox.shrink(); // Hide button if data is not loaded
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: BlocBuilder<DetailMovieCubit, DetailMovieState>(
        builder: (context, state) {
          if (state is DetailMovieLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context, state),
                  _buildRatingAndTitle(state),
                  _buildGenres(state),
                  _buildOverview(state),
                ],
              ),
            );
          } else if (state is DetailMovieFailed) {
            return Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.white),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Widget _buildHeader(BuildContext context, DetailMovieLoaded state) {
    return Stack(
      children: [
        Image.network(
          '${Constants.imageBaseUrl}/original${state.data.posterPath}',
          width: double.infinity,
          height: 500,
          fit: BoxFit.cover,
        ),
        Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black.withOpacity(0.7),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel_outlined, color: Colors.white),
              ),
              BlocBuilder<FavoriteCubit, FavoriteState>(
                builder: (context, favoriteState) {
                  bool isFavorite = false;
                  if (favoriteState is FavoriteActLoaded) {
                    isFavorite = favoriteState.isFavorite;
                  }
                  return IconButton(
                    onPressed: () {
                      context
                          .read<FavoriteCubit>()
                          .actFavorite(FavoriteEntity(data: state.data));

                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(isFavorite
                              ? 'Dihapus dari favorit'
                              : 'Ditambahkan ke Favorit')));
                    },
                    icon: Icon(
                      Icons.bookmark,
                      color: isFavorite ? Colors.yellow : Colors.white,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 150),
            child: IconButton(
              onPressed: () {},
              icon: Icon(Icons.play_arrow,
                  size: 100, color: Colors.grey.shade500),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingAndTitle(DetailMovieLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.star, color: ColorPallete.colorOrange),
              const SizedBox(width: 5),
              Text(
                '${state.data.voteAverage}/10',
                style: TextStyle(
                  color: ColorPallete.colorOrange,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                '(${state.data.voteCount} Voters)',
                style: const TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            state.data.title ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 30,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenres(DetailMovieLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: SizedBox(
        height: 31,
        child: ListView.separated(
          itemCount: state.data.genres!.length,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                color: ColorPallete.colorGrey,
              ),
              child: Center(
                child: Text(
                  '${state.data.genres![index]}',
                  style: TextStyle(color: ColorPallete.colorSecondary),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildOverview(DetailMovieLoaded state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Text(
        state.data.overview ?? '',
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
    );
  }
}
