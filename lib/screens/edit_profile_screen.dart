import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'login_screen.dart';
import 'settings_screen.dart';
import 'notification_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() =>
      _ProfileScreenState();
}

class _ProfileScreenState
    extends State<ProfileScreen> {

  bool isDarkMode = true;

  @override
  Widget build(BuildContext context) {

    final user =
        FirebaseAuth.instance.currentUser;

    return Scaffold(

      backgroundColor:
      AppColors.background,

      body: SafeArea(

        child: SingleChildScrollView(

          padding:
          const EdgeInsets.all(22),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              /// TOP BAR
              Row(

                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "My Profile",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  GestureDetector(

                    onTap: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                          const NotificationScreen(),
                        ),
                      );
                    },

                    child: Container(

                      padding:
                      const EdgeInsets.all(14),

                      decoration:
                      BoxDecoration(

                        color:
                        AppColors.cardColor,

                        borderRadius:
                        BorderRadius.circular(
                            18),

                        border: Border.all(
                          color: Colors.white10,
                        ),
                      ),

                      child: Stack(

                        children: [

                          const Icon(
                            Icons.notifications_none,
                            color: Colors.white,
                            size: 28,
                          ),

                          Positioned(

                            right: 0,
                            top: 0,

                            child: Container(

                              height: 10,
                              width: 10,

                              decoration:
                              const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// PROFILE CARD
              AnimatedContainer(

                duration:
                const Duration(milliseconds: 300),

                padding:
                const EdgeInsets.all(24),

                decoration: BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(32),

                  gradient: LinearGradient(

                    colors: [

                      AppColors.primary
                          .withOpacity(0.25),

                      Colors.purple
                          .withOpacity(0.2),
                    ],
                  ),

                  border: Border.all(
                    color: Colors.white10,
                  ),

                  boxShadow: [

                    BoxShadow(
                      color: Colors.black
                          .withOpacity(0.2),

                      blurRadius: 20,
                    ),
                  ],
                ),

                child: Column(

                  children: [

                    Stack(

                      children: [

                        Hero(

                          tag: "profile",

                          child: CircleAvatar(

                            radius: 58,

                            backgroundColor:
                            Colors.white10,

                            backgroundImage:
                            user?.photoURL != null

                                ? NetworkImage(
                                user!.photoURL!)

                                : null,

                            child:
                            user?.photoURL == null

                                ? const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 60,
                            )

                                : null,
                          ),
                        ),

                        Positioned(

                          bottom: 0,
                          right: 0,

                          child: GestureDetector(

                            onTap: () {

                              ScaffoldMessenger.of(
                                  context)
                                  .showSnackBar(

                                const SnackBar(
                                  content:
                                  Text("Edit profile photo"),
                                ),
                              );
                            },

                            child: Container(

                              padding:
                              const EdgeInsets.all(10),

                              decoration:
                              BoxDecoration(

                                shape:
                                BoxShape.circle,

                                gradient:
                                LinearGradient(
                                  colors: [
                                    AppColors.primary,
                                    Colors.purple,
                                  ],
                                ),
                              ),

                              child: const Icon(
                                Icons.edit,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    Text(

                      user?.displayName ??
                          "FinderHub User",

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(

                      user?.email ??
                          "No Email",

                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 25),

                    Row(

                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,

                      children: [

                        profileStat(
                            "24",
                            "Reports"),

                        profileStat(
                            "142",
                            "Messages"),

                        profileStat(
                            "89",
                            "Saved"),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 35),

              /// PROFILE OPTIONS
              profileTile(

                context,

                icon:
                Icons.edit_outlined,

                title:
                "Edit Profile",

                subtitle:
                "Update profile details",

                color:
                Colors.blue,

                onTap: () {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    const SnackBar(
                      content:
                      Text("Edit Profile Clicked"),
                    ),
                  );
                },
              ),

              profileTile(

                context,

                icon:
                Icons.settings_outlined,

                title:
                "Settings",

                subtitle:
                "App preferences",

                color:
                Colors.orange,

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                      const SettingsScreen(),
                    ),
                  );
                },
              ),

              profileTile(

                context,

                icon:
                Icons.notifications_active_outlined,

                title:
                "Notifications",

                subtitle:
                "Check latest alerts",

                color:
                Colors.purple,

                onTap: () {

                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (_) =>
                      const NotificationScreen(),
                    ),
                  );
                },
              ),

              profileTile(

                context,

                icon:
                Icons.favorite_border,

                title:
                "Saved Items",

                subtitle:
                "Your bookmarked reports",

                color:
                Colors.redAccent,

                onTap: () {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    const SnackBar(
                      content:
                      Text("Saved Items Opened"),
                    ),
                  );
                },
              ),

              profileTile(

                context,

                icon:
                Icons.help_outline,

                title:
                "Help & Support",

                subtitle:
                "Need help?",

                color:
                Colors.teal,

                onTap: () {

                  showDialog(

                    context: context,

                    builder: (_) {

                      return AlertDialog(

                        backgroundColor:
                        AppColors.cardColor,

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              24),
                        ),

                        title: const Text(
                          "Support",

                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),

                        content: const Text(
                          "Contact support at finderhub@gmail.com",

                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),

                        actions: [

                          TextButton(

                            onPressed: () {
                              Navigator.pop(context);
                            },

                            child: const Text(
                              "OK",
                              style: TextStyle(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

              /// DARK MODE SWITCH
              Container(

                margin:
                const EdgeInsets.only(
                    bottom: 18),

                padding:
                const EdgeInsets.all(20),

                decoration: BoxDecoration(

                  color: AppColors.cardColor,

                  borderRadius:
                  BorderRadius.circular(26),

                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),

                child: Row(

                  children: [

                    Container(

                      padding:
                      const EdgeInsets.all(14),

                      decoration:
                      BoxDecoration(

                        color:
                        Colors.indigo
                            .withOpacity(0.15),

                        borderRadius:
                        BorderRadius.circular(
                            18),
                      ),

                      child: const Icon(
                        Icons.dark_mode_outlined,
                        color: Colors.indigo,
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 18),

                    const Expanded(

                      child: Column(

                        crossAxisAlignment:
                        CrossAxisAlignment.start,

                        children: [

                          Text(
                            "Dark Mode",

                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight:
                              FontWeight.bold,
                            ),
                          ),

                          SizedBox(height: 4),

                          Text(
                            "Premium dark appearance",

                            style: TextStyle(
                              color: Colors.white60,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Switch(

                      value: isDarkMode,

                      onChanged: (value) {

                        setState(() {

                          isDarkMode = value;
                        });

                        ScaffoldMessenger.of(
                            context)
                            .showSnackBar(

                          SnackBar(
                            content: Text(

                              value
                                  ? "Dark Mode Enabled"
                                  : "Dark Mode Disabled",
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              /// LOGOUT
              GestureDetector(

                onTap: () async {

                  showDialog(

                    context: context,

                    builder: (_) {

                      return AlertDialog(

                        backgroundColor:
                        AppColors.cardColor,

                        shape:
                        RoundedRectangleBorder(
                          borderRadius:
                          BorderRadius.circular(
                              24),
                        ),

                        title: const Text(
                          "Logout",

                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),

                        content: const Text(
                          "Are you sure you want to logout?",

                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),

                        actions: [

                          TextButton(

                            onPressed: () {

                              Navigator.pop(context);
                            },

                            child: const Text(
                              "Cancel",
                              style: TextStyle(
                                color: Colors.grey,
                              ),
                            ),
                          ),

                          ElevatedButton(

                            style:
                            ElevatedButton.styleFrom(
                              backgroundColor:
                              Colors.red,
                            ),

                            onPressed: () async {

                              await FirebaseAuth
                                  .instance
                                  .signOut();

                              if (context.mounted) {

                                Navigator.pushAndRemoveUntil(

                                  context,

                                  MaterialPageRoute(

                                    builder: (_) =>
                                    const LoginScreen(),
                                  ),

                                      (route) => false,
                                );
                              }
                            },

                            child: const Text(
                              "Logout",
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },

                child: Container(

                  width: double.infinity,

                  padding:
                  const EdgeInsets.all(20),

                  decoration: BoxDecoration(

                    borderRadius:
                    BorderRadius.circular(28),

                    gradient:
                    LinearGradient(

                      colors: [
                        Colors.red.shade400,
                        Colors.red.shade700,
                      ],
                    ),
                  ),

                  child: const Row(

                    mainAxisAlignment:
                    MainAxisAlignment.center,

                    children: [

                      Icon(
                        Icons.logout,
                        color: Colors.white,
                      ),

                      SizedBox(width: 12),

                      Text(
                        "Logout",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileTile(

      BuildContext context, {

        required IconData icon,
        required String title,
        required String subtitle,
        required Color color,
        required VoidCallback onTap,
      }) {

    return Padding(

      padding:
      const EdgeInsets.only(bottom: 18),

      child: Material(

        color: Colors.transparent,

        child: InkWell(

          borderRadius:
          BorderRadius.circular(26),

          splashColor:
          color.withOpacity(0.2),

          onTap: onTap,

          child: Ink(

            padding:
            const EdgeInsets.all(20),

            decoration: BoxDecoration(

              color: AppColors.cardColor,

              borderRadius:
              BorderRadius.circular(26),

              border: Border.all(
                color: Colors.white10,
              ),
            ),

            child: Row(

              children: [

                Container(

                  padding:
                  const EdgeInsets.all(14),

                  decoration:
                  BoxDecoration(

                    color:
                    color.withOpacity(0.15),

                    borderRadius:
                    BorderRadius.circular(
                        18),
                  ),

                  child: Icon(
                    icon,
                    color: color,
                    size: 28,
                  ),
                ),

                const SizedBox(width: 18),

                Expanded(

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment.start,

                    children: [

                      Text(

                        title,

                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(

                        subtitle,

                        style: const TextStyle(
                          color: Colors.white60,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white54,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileStat(
      String value,
      String title,
      ) {

    return Column(

      children: [

        Text(

          value,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 6),

        Text(

          title,

          style: const TextStyle(
            color: Colors.white70,
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}