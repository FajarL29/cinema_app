//import 'package:cinema_app/domain/entities/ticket.dart';
import 'package:cinema_app/ui/constant/color_pallete.dart';
import 'package:cinema_app/ui/screen/Favorit/favorit_page.dart';
import 'package:cinema_app/ui/screen/home/home_page.dart';
//import 'package:cinema_app/ui/screen/logout.dart';
import 'package:cinema_app/ui/screen/profile/profile_page.dart';
import 'package:cinema_app/ui/screen/ticket/ticket_page.dart';
//import 'package:cinema_app/ui/screen/ticket/ticket_page.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:movie/ui/constant/color_pallete.dart';
// import 'package:movie/ui/screen/home/home_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class MainPage extends StatefulWidget {
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  
  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      HomePage(onChangePage: (int index) { 
        setState(() {
          _selectedIndex=index;
        });
      },),
    
      TicketPage(),
      FavoritPage(),
      ProfilPage(onChangePage: (int index) { setState(() {
          _selectedIndex=index;
        }); },),
    ];

    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: ColorPallete.colorPrimary,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: ColorPallete.colorOrange,
              hoverColor: ColorPallete.colorOrange,
              gap: 8,
              activeColor: Colors.white,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: ColorPallete.colorOrange,
              color: Colors.white,
              tabs: [
                GButton(
                  icon: Icons.movie,
                  text: 'Movie',
                ),
                GButton(
                  icon: Icons.card_travel,
                  text: 'Ticket',
                ),
                GButton(
                  icon: Icons.favorite,
                  text: 'Favorite',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
