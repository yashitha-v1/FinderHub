import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../utils/app_colors.dart';
import 'home_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends State<LoginScreen> {

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  bool obscurePassword = true;

  bool isLoading = false;

  void login() async {

    String email =
    emailController.text.trim();

    String password =
    passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {

      showMessage(
          "Please fill all fields");

      return;
    }

    if (!email.contains("@")) {

      showMessage(
          "Enter valid email");

      return;
    }

    if (password.length < 6) {

      showMessage(
          "Password minimum 6 characters");

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(

        email: email,
        password: password,
      );

      if (!mounted) return;

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      if (e.code == 'user-not-found') {

        showMessage(
          "No account found. Please sign up.",
        );

      } else if (e.code == 'wrong-password') {

        showMessage(
          "Incorrect password",
        );

      } else if (e.code == 'invalid-email') {

        showMessage(
          "Invalid email address",
        );

      } else {

        showMessage(
          e.message ?? "Login Failed",
        );
      }

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> signInWithGoogle() async {

    try {

      setState(() {
        isLoading = true;
      });

      final GoogleSignInAccount? googleUser =
      await GoogleSignIn().signIn();

      if (googleUser == null) {

        setState(() {
          isLoading = false;
        });

        return;
      }

      final GoogleSignInAuthentication
      googleAuth =
      await googleUser.authentication;

      final credential =
      GoogleAuthProvider.credential(

        accessToken:
        googleAuth.accessToken,

        idToken:
        googleAuth.idToken,
      );

      await FirebaseAuth.instance
          .signInWithCredential(
        credential,
      );

      if (!mounted) return;

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (_) =>
          const HomeScreen(),
        ),
      );

    } catch (e) {

      showMessage(
        "Google Sign-In Failed",
      );

    } finally {

      setState(() {
        isLoading = false;
      });
    }
  }

  void showMessage(String text) {

    ScaffoldMessenger.of(context)
        .showSnackBar(

      SnackBar(

        backgroundColor:
        AppColors.primary,

        behavior:
        SnackBarBehavior.floating,

        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(14),
        ),

        content: Text(

          text,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      AppColors.background,

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
          const EdgeInsets.all(24),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 60),

              Center(

                child: Column(

                  children: [

                    Container(

                      padding:
                      const EdgeInsets.all(25),

                      decoration:
                      BoxDecoration(

                        shape: BoxShape.circle,

                        gradient:
                        LinearGradient(
                          colors: [
                            AppColors.primary,
                            Colors.purple,
                          ],
                        ),

                        boxShadow: [

                          BoxShadow(
                            color:
                            AppColors.primary
                                .withOpacity(0.5),

                            blurRadius: 30,
                          ),
                        ],
                      ),

                      child: const Icon(
                        Icons.search,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),

                    const SizedBox(height: 25),

                    ShaderMask(

                      shaderCallback:
                          (bounds) {

                        return const LinearGradient(

                          colors: [
                            Colors.blue,
                            Colors.purple,
                          ],

                        ).createShader(bounds);
                      },

                      child: const Text(
                        "FinderHub",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 44,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Find lost items instantly",

                      style: TextStyle(
                        color:
                        AppColors.textGrey,
                        fontSize: 18,
                      ),
                    ),

                    const SizedBox(height: 10),

                    const Text(
                      "Welcome back 👋",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 60),

              buildField(
                controller:
                emailController,
                hint: "Email",
                icon: Icons.email,
              ),

              const SizedBox(height: 25),

              TextField(

                controller:
                passwordController,

                obscureText:
                obscurePassword,

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration:
                InputDecoration(

                  hintText: "Password",

                  hintStyle:
                  const TextStyle(
                    color: Colors.grey,
                  ),

                  prefixIcon:
                  const Icon(
                    Icons.lock,
                    color:
                    AppColors.primary,
                  ),

                  suffixIcon:
                  IconButton(

                    onPressed: () {

                      setState(() {

                        obscurePassword =
                        !obscurePassword;
                      });
                    },

                    icon: Icon(

                      obscurePassword
                          ? Icons.visibility
                          : Icons.visibility_off,

                      color: Colors.grey,
                    ),
                  ),

                  filled: true,
                  fillColor:
                  AppColors.cardColor,

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(
                        22),

                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(

                width: double.infinity,
                height: 65,

                child: ElevatedButton(

                  style:
                  ElevatedButton.styleFrom(

                    backgroundColor:
                    AppColors.primary,

                    elevation: 10,

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          22),
                    ),
                  ),

                  onPressed:
                  isLoading
                      ? null
                      : login,

                  child: isLoading

                      ? const CircularProgressIndicator(
                    color: Colors.white,
                  )

                      : const Text(
                    "Login",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              SizedBox(

                width: double.infinity,
                height: 65,

                child:
                OutlinedButton.icon(

                  style:
                  OutlinedButton.styleFrom(

                    side:
                    const BorderSide(
                      color:
                      Colors.white24,
                    ),

                    shape:
                    RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          22),
                    ),
                  ),

                  onPressed:
                  isLoading
                      ? null
                      : signInWithGoogle,

                  icon: const Icon(
                    Icons.g_mobiledata,
                    color: Colors.white,
                    size: 40,
                  ),

                  label: const Text(
                    "Continue with Google",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              Center(

                child: TextButton(

                  onPressed: () {

                    Navigator.push(

                      context,

                      MaterialPageRoute(
                        builder: (_) =>
                        const SignupScreen(),
                      ),
                    );
                  },

                  child: const Text(

                    "New to FinderHub? Create Account",

                    style: TextStyle(
                      color:
                      AppColors.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildField({

    required TextEditingController
    controller,

    required String hint,

    required IconData icon,

  }) {

    return TextField(

      controller: controller,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(

        hintText: hint,

        hintStyle: const TextStyle(
          color: Colors.grey,
        ),

        prefixIcon: Icon(
          icon,
          color: AppColors.primary,
        ),

        filled: true,
        fillColor:
        AppColors.cardColor,

        border: OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(22),

          borderSide:
          BorderSide.none,
        ),
      ),
    );
  }
}