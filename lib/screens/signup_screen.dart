import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends State<SignupScreen> {

  final nameController =
  TextEditingController();

  final emailController =
  TextEditingController();

  final passwordController =
  TextEditingController();

  final confirmController =
  TextEditingController();

  bool obscure1 = true;
  bool obscure2 = true;

  bool isLoading = false;

  void signup() async {

    String name =
    nameController.text.trim();

    String email =
    emailController.text.trim();

    String password =
    passwordController.text.trim();

    String confirm =
    confirmController.text.trim();

    if (name.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirm.isEmpty) {

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
        "Password must be minimum 6 characters",
      );

      return;
    }

    if (password != confirm) {

      showMessage(
          "Passwords do not match");

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(

        email: email,
        password: password,
      );

      await FirebaseAuth.instance
          .currentUser
          ?.updateDisplayName(name);

      if (!mounted) return;

      showMessage(
        "Account created successfully 🎉",
      );

      await Future.delayed(
        const Duration(seconds: 1),
      );

      Navigator.pushReplacement(

        context,

        MaterialPageRoute(
          builder: (_) =>
          const HomeScreen(),
        ),
      );

    } on FirebaseAuthException catch (e) {

      if (e.code ==
          'email-already-in-use') {

        showMessage(
          "Account already exists. Please login.",
        );

      } else if (e.code ==
          'invalid-email') {

        showMessage(
          "Invalid email address",
        );

      } else if (e.code ==
          'weak-password') {

        showMessage(
          "Password is too weak",
        );

      } else {

        showMessage(
          e.message ??
              "Signup Failed",
        );
      }

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

          child: Padding(

            padding:
            const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 20,
            ),

            child: Column(

              crossAxisAlignment:
              CrossAxisAlignment.start,

              children: [

                const SizedBox(height: 30),

                Center(

                  child: Container(

                    height: 100,
                    width: 100,

                    decoration: BoxDecoration(

                      color:
                      AppColors.primary
                          .withOpacity(0.15),

                      shape: BoxShape.circle,
                    ),

                    child: const Icon(
                      Icons.person_add_alt_1_rounded,
                      color:
                      AppColors.primary,
                      size: 50,
                    ),
                  ),
                ),

                const SizedBox(height: 40),

                const Text(
                  "Create Account",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Join FinderHub and connect instantly",

                  style: TextStyle(
                    color:
                    AppColors.textGrey,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Create your premium experience 🚀",

                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight:
                    FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 40),

                buildField(

                  controller:
                  nameController,

                  hint: "Full Name",

                  icon:
                  Icons.person_outline,
                ),

                const SizedBox(height: 20),

                buildField(

                  controller:
                  emailController,

                  hint: "Email Address",

                  icon:
                  Icons.email_outlined,
                ),

                const SizedBox(height: 20),

                passwordField(

                  controller:
                  passwordController,

                  hint: "Password",

                  obscure: obscure1,

                  onTap: () {

                    setState(() {
                      obscure1 =
                      !obscure1;
                    });
                  },
                ),

                const SizedBox(height: 20),

                passwordField(

                  controller:
                  confirmController,

                  hint:
                  "Confirm Password",

                  obscure: obscure2,

                  onTap: () {

                    setState(() {
                      obscure2 =
                      !obscure2;
                    });
                  },
                ),

                const SizedBox(height: 35),

                SizedBox(

                  width: double.infinity,
                  height: 60,

                  child: ElevatedButton(

                    style:
                    ElevatedButton.styleFrom(

                      backgroundColor:
                      AppColors.primary,

                      shape:
                      RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            18),
                      ),

                      elevation: 8,
                    ),

                    onPressed:
                    isLoading
                        ? null
                        : signup,

                    child: isLoading

                        ? const CircularProgressIndicator(
                      color: Colors.white,
                    )

                        : const Text(
                      "Create Account",

                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                Center(

                  child: Row(

                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [

                      const Text(
                        "Already have an account? ",

                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 15,
                        ),
                      ),

                      GestureDetector(

                        onTap: () {
                          Navigator.pop(
                              context);
                        },

                        child: const Text(
                          "Login",

                          style: TextStyle(
                            color:
                            AppColors.primary,
                            fontSize: 15,
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
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

        contentPadding:
        const EdgeInsets.symmetric(
          vertical: 22,
        ),

        border: OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(18),

          borderSide:
          BorderSide.none,
        ),

        focusedBorder:
        OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(18),

          borderSide:
          const BorderSide(
            color:
            AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }

  Widget passwordField({

    required TextEditingController
    controller,

    required String hint,

    required bool obscure,

    required VoidCallback onTap,

  }) {

    return TextField(

      controller: controller,

      obscureText: obscure,

      style: const TextStyle(
        color: Colors.white,
      ),

      decoration: InputDecoration(

        hintText: hint,

        hintStyle: const TextStyle(
          color: Colors.grey,
        ),

        prefixIcon: const Icon(
          Icons.lock_outline,
          color: AppColors.primary,
        ),

        suffixIcon: IconButton(

          onPressed: onTap,

          icon: Icon(

            obscure

                ? Icons.visibility_outlined

                : Icons.visibility_off_outlined,

            color: Colors.grey,
          ),
        ),

        filled: true,
        fillColor:
        AppColors.cardColor,

        contentPadding:
        const EdgeInsets.symmetric(
          vertical: 22,
        ),

        border: OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(18),

          borderSide:
          BorderSide.none,
        ),

        focusedBorder:
        OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(18),

          borderSide:
          const BorderSide(
            color:
            AppColors.primary,
            width: 2,
          ),
        ),
      ),
    );
  }
}