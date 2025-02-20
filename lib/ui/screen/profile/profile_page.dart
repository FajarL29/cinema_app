// import 'package:cinema_app/ui/screen/home/cubit/user_cubit.dart';
// import 'package:cinema_app/ui/screen/home/profil_screen.dart';
import 'package:cinema_app/ui/screen/profile/profile_screen.dart';
import 'package:cinema_app/ui/screen/user/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilPage extends StatelessWidget {
  final Function (int index) onChangePage;
  const ProfilPage({super.key, required this.onChangePage});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => UserCubit()..getUser(),
        ),
      ],
      child: ProfileScreen(onChangePage: onChangePage),
    );
  }
}