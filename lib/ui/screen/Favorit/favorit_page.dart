//import 'package:cinema_app/domain/entities/ticket.dart';
import 'package:cinema_app/ui/screen/Favorit/cubit/favorit_cubit.dart';
import 'package:cinema_app/ui/screen/Favorit/favorit_screen.dart';
// import 'package:cinema_app/ui/screen/ticket/cubit/ticket_cubit.dart';
// import 'package:cinema_app/ui/screen/ticket/ticket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritPage extends StatelessWidget {


  const FavoritPage({super.key,});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => FavoriteCubit()..loadFavorite(),
        ),
      ],
      child: FavoriteScreen()
    );
  }
}
