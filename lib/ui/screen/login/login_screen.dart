import 'package:cinema_app/data/repositories/auth_repository.dart';
import 'package:cinema_app/ui/screen/login/cubit/login_cubit.dart';
import 'package:cinema_app/ui/screen/login/cubit/login_state.dart';
import 'package:cinema_app/ui/screen/main_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void dispose() {
    usernameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  // Fungsi untuk otentikasi biometrik
  Future<void> _authenticateWithBiometrics() async {
    try {
      bool isAuthenticated = await auth.authenticate(
        localizedReason: 'Gunakan sidik jari atau Face ID untuk login',
        options: AuthenticationOptions(biometricOnly: true),
      );

      if (isAuthenticated) {
        // Jika otentikasi berhasil, langsung masuk ke halaman utama
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MainPage()),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Autentikasi gagal: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text("Konfirmasi"),
                content: Text("Yakin ingin keluar?"),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text("Tidak"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: Text("Ya"),
                  ),
                ],
              ),
            ) ??
            false;
      },
      child: Scaffold(
        backgroundColor: Colors.grey,
        appBar: AppBar(
          backgroundColor: Colors.black,
        ),
        body: BlocProvider(
          create: (context) => AuthCubit(AuthRepository()),
          child: BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoaded) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Welcome, ${state.user.firstName}!')),
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MainPage()),
                );
              } else if (state is AuthFailed) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Error: ${state.message}')),
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.movie_outlined, size: 100),
                    Text(
                      'Toyota\nMovie App',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        prefixIcon: Icon(Icons.person),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final isObscure =
                            context.read<AuthCubit>().isPasswordVisible;
                        return TextField(
                          controller: passwordController,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            prefixIcon: Icon(Icons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                context
                                    .read<AuthCubit>()
                                    .togglePasswordVisibility();
                              },
                              icon: Icon(
                                isObscure
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                              ),
                            ),
                            border: OutlineInputBorder(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 20),
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        if (state is AuthLoading) {
                          return CircularProgressIndicator();
                        }
                        return SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.grey),
                              padding:
                                  MaterialStateProperty.all(EdgeInsets.all(16)),
                            ),
                            onPressed: () {
                              final username = usernameController.text;
                              final password = passwordController.text;
                              context
                                  .read<AuthCubit>()
                                  .login(username, password);
                            },
                            child: Text(
                              'Login',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    // Tombol Biometric
                    TextButton.icon(
                      onPressed: _authenticateWithBiometrics,
                      icon: Icon(Icons.fingerprint, size: 28),
                      label: Text(''),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
