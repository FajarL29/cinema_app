// ignore_for_file: public_member_api_docs, sort_constructors_first
//import 'package:cinema_app/ui/screen/home/home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:local_auth/local_auth.dart';

import 'package:cinema_app/ui/constant/color_pallete.dart';
import 'package:cinema_app/ui/screen/login/login_screen.dart';
import 'package:cinema_app/ui/screen/user/cubit/user_cubit.dart';
import 'package:cinema_app/ui/screen/webview/webview_screen.dart';

class ProfileScreen extends StatefulWidget {
  final Function (int index) onChangePage;

  const ProfileScreen({
    super.key,
    required this.onChangePage,
  });
  
  @override
  
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isBiometricActive = false;




  @override
  void initState() {
    super.initState();
    _loadBiometricSetting();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPallete.colorPrimary,
      appBar: AppBar(
        backgroundColor: ColorPallete.colorPrimary,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'My Profile',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.settings, color: Colors.white),
        ],
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 10),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLoaded) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage('${state.data.image}'),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${state.data.firstName} ${state.data.lastName}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${state.data.email}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 30),
                      _buildProfileOption(Icons.card_travel, 'Ticket', onTap: () {
                      widget.onChangePage(1);
                      } ),
                      _buildProfileOption(Icons.favorite, 'Favorite', onTap: () {
                        widget.onChangePage(2);
                      }),
                      _buildProfileOption(
                        Icons.policy, 'Privacy',
                        onTap: () {
                          if (kIsWeb) {
                            openWebPage(url: 'https://www.instagram.com/?hl=en');
                          } else {
                            Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WebViewScreen(
                            url: 'https://www.google.com/',
                          ),
                        ),
                      );
                          } 
                        
                      }),
                      _buildProfileOption(Icons.contact_phone, 'Contact', onTap: launchWhatsApp),
                      ListTile(
                        leading: Icon(Icons.fingerprint, color: Colors.white,),
                        title: Text('Login Biometric'),
                        trailing: Switch(
                          value: _isBiometricActive, 
                          onChanged: (value) {
                            _toggleBiometroc(value, dynamic);
                          }
                          ),
                          onTap: () {
                            _toggleBiometroc(!_isBiometricActive, dynamic);
                          },
                      ),
                      _buildLogoutOption(context),
                    ],
                  );
                } else if (state is UserFailed) {
                  return Center(
                    child: Text(
                      state.message,
                      style: const TextStyle(color: Colors.white),
                    ),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(IconData icon, String title, {required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            Icon(icon, color: Colors.white,),
            const SizedBox(
              width: 10,
            ),
            Expanded(child: Text(title,
            style: const  TextStyle(
              color: Colors.white,
              fontSize: 16,

            ),),
            ),
            const Icon(Icons.navigate_next, color: Colors.white,)
          ],
        ),
      ),
    );
  }

Future<void> _loadBiometricSetting() async {
  final prefs = await SharedPreferences.getInstance();
  setState(() {
    _isBiometricActive = prefs.getBool('isBiometricActive') ?? false;

  });
}

Future<void> _toggleBiometroc(bool value, dynamic auth) async {
  final prefs = await SharedPreferences.getInstance();
  
  bool canCheckBiometrics = await auth.canCheckBiometrics;
  bool isDeviceSupported = await auth.isDeviceSupported();
  
  if (canCheckBiometrics && isDeviceSupported) {
    try {
      bool authenticated = await auth.authenticate(
        localizedReason: 'Verifikasi fingerprint untuk mengaktifkan login biometrik',
        options: const AuthenticationOptions(
          stickyAuth: true, // Agar tetap aktif di latar belakang
          biometricOnly: true, // Hanya gunakan biometrik
        ),
      );

      if (authenticated) {
        setState(() {
          _isBiometricActive = value;
        });
        await prefs.setBool('isBiometricActive', value);
      }
    } catch (e) {
      print("Error autentikasi: $e");
    }
  } else {
    print("Biometrik tidak didukung pada perangkat ini.");
  }
}



  Widget _buildLogoutOption(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: GestureDetector(
        onTap: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: LoginScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        child: Row(
          children: [
            Icon(Icons.logout_outlined, color: Colors.red),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Log out',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.red),
          ],
        ),
      ),
    );
  }

  void launchWhatsApp() async {
  final Uri whatsappUri = Uri.parse('https://wa.me/083148697741'); // Tambahkan nomor di sini
  if (await canLaunchUrl(whatsappUri)) {
    await launchUrl(whatsappUri, mode: LaunchMode.externalApplication);
  } else {
    throw 'Could not launch WhatsApp';
  }
  }

  Future<void> openWebPage({required String url}) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw "Tidak bisa membuka $url";
    }
  }
}