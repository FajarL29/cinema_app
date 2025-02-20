import 'package:cinema_app/ui/constant/color_pallete.dart';
import 'package:cinema_app/ui/screen/detail/detail_page.dart';
import 'package:cinema_app/ui/screen/search/cubit/search_cubit.dart';
import 'package:cinema_app/ui/screen/search/widget/movie_card.dart';
//import 'package:cinema_app/ui/screen/search/widgets/movie_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorPallete.colorPrimary,
        appBar: AppBar(
          title: Text(
            'Pencarian "$query"',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.grey,
        ),
        body: BlocBuilder<SearchCubit, SearchState>(
          builder: (context, state) {
            if(state is SearchLoaded){
              if (state.movie.isEmpty){
                return const Center(
                  child: Text("Tidak ada hasil pencarian"),
                );
              }else{
              return ListView.separated(
                shrinkWrap: true,
                separatorBuilder: (context, index) => const Divider(),
                itemCount: state.movie.length,
                itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailMoviePage(id: state.movie[index].id)));
                  },
                  child: MovieCard(
                    movie: state.movie[index],
                  ),
                );
               },
              );
            }
            }
            return CircularProgressIndicator();
        },
                )
    );
  }
}
