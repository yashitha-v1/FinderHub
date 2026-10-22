/// ================= PROFILE SCREEN =================
/// REPLACE FULL profile_screen.dart WITH THIS

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'login_screen.dart';
import 'notification_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(

      backgroundColor: AppColors.background,

      body: SafeArea(

        child: SingleChildScrollView(

          padding: const EdgeInsets.all(22),

          child: Column(

            children: [

              /// TOP BAR
              Row(

                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,

                children: [

                  const Text(
                    "Profile",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
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

                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(

                        color: AppColors.cardColor,

                        borderRadius:
                        BorderRadius.circular(18),
                      ),

                      child: const Icon(
                        Icons.notifications_none,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 30),

              /// PROFILE CARD
              Container(

                width: double.infinity,

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(

                  borderRadius:
                  BorderRadius.circular(32),

                  gradient: LinearGradient(

                    colors: [

                      AppColors.primary
                          .withOpacity(0.3),

                      Colors.purple
                          .withOpacity(0.2),
                    ],
                  ),
                ),

                child: Column(

                  children: [

                    CircleAvatar(

                      radius: 58,

                      backgroundColor: Colors.white10,

                      backgroundImage:
                      user?.photoURL != null

                          ? NetworkImage(user!.photoURL!)

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

                    const SizedBox(height: 18),

                    Text(

                      user?.displayName ??
                          "FinderHub User",

                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 8),

                    Text(

                      user?.email ?? "No Email",

                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Row(

                      mainAxisAlignment:
                      MainAxisAlignment.spaceAround,

                      children: [

                        statCard("24", "Reports"),
                        statCard("142", "Chats"),
                        statCard("89", "Saved"),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              /// EDIT PROFILE
              profileButton(

                context,

                icon: Icons.edit,

                title: "Edit Profile",

                subtitle:
                "Change profile details",

                color: Colors.blue,

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

              /// SETTINGS
              profileButton(

                context,

                icon: Icons.settings,

                title: "Settings",

                subtitle:
                "App preferences",

                color: Colors.orange,

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

              /// NOTIFICATIONS
              profileButton(

                context,

                icon:
                Icons.notifications_active,

                title: "Notifications",

                subtitle:
                "Check latest alerts",

                color: Colors.purple,

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

              /// SAVED ITEMS
              profileButton(

                context,

                icon: Icons.favorite_border,

                title: "Saved Items",

                subtitle:
                "Your bookmarked reports",

                color: Colors.redAccent,

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
                          BorderRadius.circular(24),
                        ),

                        title: const Text(

                          "Saved Items",

                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),

                        content: const Text(

                          "No saved items yet",

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
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

              /// HELP
              profileButton(

                context,

                icon: Icons.help_outline,

                title: "Help & Support",

                subtitle:
                "Contact support",

                color: Colors.teal,

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
                          BorderRadius.circular(24),
                        ),

                        title: const Text(

                          "Support",

                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),

                        content: const Text(

                          "finderhub@gmail.com",

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
                              "Close",
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),

              const SizedBox(height: 30),

              /// LOGOUT BUTTON
              SizedBox(

                width: double.infinity,
                height: 60,

                child: ElevatedButton.icon(

                  style: ElevatedButton.styleFrom(

                    backgroundColor: Colors.red,

                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(22),
                    ),
                  ),

                  onPressed: () async {

                    await FirebaseAuth.instance
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

                  icon: const Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),

                  label: const Text(

                    "Logout",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
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

  Widget profileButton(

      BuildContext context, {

        required IconData icon,
        required String title,
        required String subtitle,
        required Color color,
        required VoidCallback onTap,
      }) {

    return Padding(

      padding: const EdgeInsets.only(bottom: 18),

      child: Material(

        color: Colors.transparent,

        child: InkWell(

          borderRadius:
          BorderRadius.circular(24),

          splashColor:
          color.withOpacity(0.2),

          onTap: onTap,

          child: Ink(

            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(

              color: AppColors.cardColor,

              borderRadius:
              BorderRadius.circular(24),

              border: Border.all(
                color: Colors.white10,
              ),
            ),

            child: Row(

              children: [

                Container(

                  padding: const EdgeInsets.all(14),

                  decoration: BoxDecoration(

                    color:
                    color.withOpacity(0.15),

                    borderRadius:
                    BorderRadius.circular(18),
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
                          fontWeight: FontWeight.bold,
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

  Widget statCard(
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