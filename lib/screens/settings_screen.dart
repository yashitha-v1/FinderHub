/// ================= SETTINGS SCREEN =================
/// REPLACE FULL settings_screen.dart WITH THIS

import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() =>
      _SettingsScreenState();
}

class _SettingsScreenState
    extends State<SettingsScreen> {

  bool notifications = true;
  bool darkMode = true;
  bool location = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.background,

      appBar: AppBar(

        backgroundColor:
        AppColors.cardColor,

        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding: const EdgeInsets.all(22),

        child: Column(

          children: [

            settingSwitch(

              icon:
              Icons.notifications_active,

              title:
              "Notifications",

              subtitle:
              "Enable notifications",

              color:
              Colors.orange,

              value:
              notifications,

              onChanged: (v) {

                setState(() {
                  notifications = v;
                });

                ScaffoldMessenger.of(context)
                    .showSnackBar(

                  SnackBar(
                    content: Text(

                      v
                          ? "Notifications Enabled"
                          : "Notifications Disabled",
                    ),
                  ),
                );
              },
            ),

            settingSwitch(

              icon:
              Icons.dark_mode,

              title:
              "Dark Mode",

              subtitle:
              "Premium dark appearance",

              color:
              Colors.indigo,

              value:
              darkMode,

              onChanged: (v) {

                setState(() {
                  darkMode = v;
                });
              },
            ),

            settingSwitch(

              icon:
              Icons.location_on,

              title:
              "Location",

              subtitle:
              "Allow location access",

              color:
              Colors.green,

              value:
              location,

              onChanged: (v) {

                setState(() {
                  location = v;
                });
              },
            ),

            settingsButton(

              context,

              icon:
              Icons.lock_outline,

              title:
              "Privacy",

              subtitle:
              "Manage privacy settings",

              color:
              Colors.redAccent,

              onTap: () {

                showDialog(

                  context: context,

                  builder: (_) {

                    return AlertDialog(

                      backgroundColor:
                      AppColors.cardColor,

                      title: const Text(
                        "Privacy",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),

                      content: const Text(

                        "Privacy settings opened",

                        style: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    );
                  },
                );
              },
            ),

            settingsButton(

              context,

              icon:
              Icons.info_outline,

              title:
              "About App",

              subtitle:
              "FinderHub v1.0",

              color:
              Colors.cyan,

              onTap: () {

                showAboutDialog(

                  context: context,

                  applicationName:
                  "FinderHub",

                  applicationVersion:
                  "1.0.0",
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget settingSwitch({

    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {

    return Container(

      margin:
      const EdgeInsets.only(bottom: 18),

      padding:
      const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: AppColors.cardColor,

        borderRadius:
        BorderRadius.circular(24),
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
              BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color: color,
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
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget settingsButton(

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
          BorderRadius.circular(24),

          onTap: onTap,

          child: Ink(

            padding:
            const EdgeInsets.all(20),

            decoration: BoxDecoration(

              color: AppColors.cardColor,

              borderRadius:
              BorderRadius.circular(24),
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
                    BorderRadius.circular(18),
                  ),

                  child: Icon(
                    icon,
                    color: color,
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
}