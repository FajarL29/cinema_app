import 'package:bloc/bloc.dart';
//import 'package:cinema_app/data/repositories/auth_repository.dart';
import 'package:cinema_app/data/repositories/user_repository.dart';
import 'package:cinema_app/domain/entities/user_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final repository = UserRepository();

  void getUser() async{
    emit(UserLoading());
    try {
      final result = await repository.getUser();
      emit(UserLoaded(data: result));
    } catch (e) {
      emit(UserFailed(message: e.toString()));
    }
  }
}
