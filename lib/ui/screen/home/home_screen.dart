import 'package:cinema_app/ui/constant/color_pallete.dart';
//import 'package:cinema_app/ui/screen/home/home_page.dart';
import 'package:cinema_app/ui/screen/home/section/categories/categories.dart';
import 'package:cinema_app/ui/screen/home/section/now_playing/now_playing.dart';
import 'package:cinema_app/ui/screen/home/section/upcoming/upcoming.dart';
//import 'package:cinema_app/ui/screen/profile/profile_page.dart';
import 'package:cinema_app/ui/screen/search/search_page.dart';
// import 'package:cinema_app/ui/screen/login/login_screen.dart';
// import 'package:cinema_app/ui/screen/profile/profile_page.dart';
import 'package:cinema_app/ui/screen/user/cubit/user_cubit.dart';
import 'package:flutter/material.dart';
//import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  final Function (int index) onChangePage;
  const HomeScreen({super.key, required this.onChangePage});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<String> categories = ['Action', 'Comedy', 'Horror', 'Romance'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(17.0),
            child: Column(
              children: [
                BlocBuilder<UserCubit, UserState>(
                  builder: (context, state) {
                    // print("masuk sini");
                    // print(state);
                    if (state is UserLoaded) {
                      return Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Welcome ${state.data.firstName}', // Assuming userName is part of state
                                  style: TextStyle(
                                    color: ColorPallete.colorGrey,
                                    fontSize: 16.0,
                                  ),
                                ),
                                Text(
                                  "Let's relax and watch a movie!",
                                  style: TextStyle(
                                    color: ColorPallete.colorSecondary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                          onTap: () async {
                            widget.onChangePage(3);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: Image.network(
                              state.data.image!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                        ],
                      );
                    } else if(state is UserFailed) {
                      return Text(state.message, style: TextStyle(color: Colors.white),);
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
                const SizedBox(
                  height: 48,
                ),
                TextField(
                  style: TextStyle(color: ColorPallete.colorGrey),
                  onSubmitted: (value) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(query: value))
                    );
                  },
                  decoration: InputDecoration(
                    hintText: 'Search a movie....',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(90),
                      borderSide: BorderSide(
                          width: 1, color: Colors.grey),
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 20),
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: Colors.grey,
                    prefixIconColor: ColorPallete.colorGrey,
                    hintStyle: TextStyle(color: ColorPallete.colorGrey),
                  ),
                ),
                const SizedBox(
                  height: 28,
                ),
                const CategoriesSection(),
                const NowPlayingSection(),
                const UpcomingSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
