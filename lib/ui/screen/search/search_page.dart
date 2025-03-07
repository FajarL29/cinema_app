import 'package:cinema_app/ui/screen/search/cubit/search_cubit.dart';
import 'package:cinema_app/ui/screen/search/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatelessWidget {
  final String query;
  const SearchPage({super.key, required this.query});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SearchCubit()..searchMovie(query),
        ),
      ],
      child: SearchScreen(
        query: query,),
    );
  }
}