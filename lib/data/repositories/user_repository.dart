import 'package:cinema_app/domain/entities/user_detail.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final Dio dio = Dio();
  final String useUrl = 'https://dummyjson.com/auth/me';

  Future<UserDetailEntity> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    (prefs.getString('accessToken'));
    final response = await dio.get(
      useUrl,
      options:Options(
        headers: {
          'Content-Type':'application/json',
          'Authorization':'Bearer ${ prefs.getString('accessToken')}'
        },
      )
    );
    return UserDetailEntity.fromJson(response.data);
  }
}