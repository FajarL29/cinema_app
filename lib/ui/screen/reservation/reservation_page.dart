// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:cinema_app/ui/screen/reservation/cubit/reservation_cubit.dart';
import 'package:cinema_app/ui/screen/reservation/reservation_screen.dart';

class ReservationPage extends StatelessWidget {
  final String imagePath;
  final String title;
  final int idmovie;

  

  const ReservationPage({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.idmovie,

  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ReservationCubit()..generateRandomBookedSeats(),
      child: ReservationScreen(imagePath: imagePath, title: title, idmovie: idmovie, ticketData: 'ticket',),
    );
  }
}
