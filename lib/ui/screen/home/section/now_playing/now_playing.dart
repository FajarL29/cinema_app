import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cinema_app/ui/constant/color_pallete.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cinema_app/ui/constant/constant.dart';
import 'package:cinema_app/ui/screen/detail/detail_page.dart';
import 'package:cinema_app/ui/screen/home/section/now_playing/cubit/now_playing_cubit.dart';

class NowPlayingSection extends StatelessWidget {
  const NowPlayingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Now Playing',
                style: TextStyle(
                    color: ColorPallete.colorSecondary,
                    fontSize: 20,
                    fontWeight: FontWeight.w500),
              
              ),
            ),
            Text(
              'View all',
              style: TextStyle(
                color: ColorPallete.colorOrange,
                fontSize: 12,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        BlocBuilder<NowPlayingCubit, NowPlayingState>(
          builder: (context, state) {
            if (state is NowPlayingLoaded) {
              return CarouselSlider(
                options: CarouselOptions(
                  height: 300.0,
                  autoPlay: true,
                  enlargeCenterPage: false,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.6,
                  enableInfiniteScroll: true,
                ),
                items: state.data.map((entry) {
                  return Container(
                      width: MediaQuery.of(context).size.width * 0.5,
                      margin: const EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: GestureDetector(
                        onTap: () => Navigator.push(context, MaterialPageRoute(
                          builder: (context){
                            return DetailMoviePage(id: entry.id,);
                          },
                        )),
                        child: Column(
                          children: [
                            Container(
                              height: 200,
                              margin: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      '${Constants.imageBaseUrl}${'/original'}${entry.posterPath}',
                                    ),
                                    fit: BoxFit.cover
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                                '${entry.title}', 
                                style: TextStyle(
                                  color: ColorPallete.colorSecondary,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      )
                      );
                }).toList(),
              );
              
            } else if (state is NowPlayingFailed) {
              return Text(state.message);
            } else {
              return const CircularProgressIndicator();
            }
          },
        ),
      ],
    );
  }
  
}
