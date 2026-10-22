import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

import 'chat_screen.dart';
import 'notification_screen.dart';
import 'profile_screen.dart';
import 'report_found_screen.dart';
import 'report_lost_screen.dart';
import 'search_screen.dart';
import '../utils/time_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState();
}

class _HomeScreenState
    extends State<HomeScreen> {

  int selectedIndex = 0;

  final List<Widget> pages = [

    const HomeContent(),
    const SearchScreen(),
    ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.background,

      body: pages[selectedIndex],

      floatingActionButton:
      Container(

        height: 72,
        width: 72,

        decoration: BoxDecoration(

          shape: BoxShape.circle,

          gradient: LinearGradient(
            colors: [
              AppColors.primary,
              Colors.purple,
            ],
          ),

          boxShadow: [

            BoxShadow(
              color: AppColors.primary
                  .withValues(alpha: 0.4),

              blurRadius: 18,
              spreadRadius: 2,
            ),
          ],
        ),

        child: FloatingActionButton(

          backgroundColor:
          Colors.transparent,

          elevation: 0,

          child: const Icon(
            Icons.add,
            color: Colors.white,
            size: 36,
          ),

          onPressed: () {

            showModalBottomSheet(

              context: context,

              backgroundColor:
              AppColors.cardColor,

              shape:
              const RoundedRectangleBorder(

                borderRadius:
                BorderRadius.vertical(
                  top: Radius.circular(30),
                ),
              ),

              builder: (_) {

                return Padding(

                  padding:
                  const EdgeInsets.all(24),

                  child: Column(

                    mainAxisSize:
                    MainAxisSize.min,

                    children: [

                      Container(

                        width: 60,
                        height: 6,

                        decoration:
                        BoxDecoration(

                          color:
                          Colors.white24,

                          borderRadius:
                          BorderRadius.circular(
                              20),
                        ),
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Create Report",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 28,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 30),

                      actionButton(
                        context,
                        "Report Lost Item",
                        Icons.warning_amber_rounded,
                        Colors.redAccent,
                        const ReportLostScreen(),
                      ),

                      const SizedBox(height: 20),

                      actionButton(
                        context,
                        "Report Found Item",
                        Icons.check_circle_outline,
                        Colors.green,
                        const ReportFoundScreen(),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),

      floatingActionButtonLocation:
      FloatingActionButtonLocation
          .centerDocked,

      bottomNavigationBar:
      BottomAppBar(

        color: AppColors.cardColor,

        shape:
        const CircularNotchedRectangle(),

        notchMargin: 10,

        child: SizedBox(

          height: 78,

          child: Row(

            mainAxisAlignment:
            MainAxisAlignment
                .spaceAround,

            children: [

              navItem(Icons.home, 0),

              navItem(Icons.search, 1),

              const SizedBox(width: 40),

              navItem(
                  Icons.chat_bubble_outline,
                  2),

              navItem(Icons.person, 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget navItem(
      IconData icon,
      int index,
      ) {

    return GestureDetector(

      onTap: () {

        setState(() {

          selectedIndex = index;
        });
      },

      child: AnimatedContainer(

        duration:
        const Duration(
            milliseconds: 250),

        padding:
        const EdgeInsets.all(10),

        decoration: BoxDecoration(

          color: selectedIndex == index

              ? AppColors.primary
              .withValues(alpha: 0.15)

              : Colors.transparent,

          borderRadius:
          BorderRadius.circular(16),
        ),

        child: Icon(

          icon,

          size: 30,

          color: selectedIndex == index

              ? AppColors.primary
              : Colors.grey,
        ),
      ),
    );
  }

  Widget actionButton(

      BuildContext context,
      String title,
      IconData icon,
      Color color,
      Widget page,

      ) {

    return SizedBox(

      width: double.infinity,
      height: 62,

      child: ElevatedButton.icon(

        style:
        ElevatedButton.styleFrom(

          backgroundColor: color,

          elevation: 8,

          shape:
          RoundedRectangleBorder(

            borderRadius:
            BorderRadius.circular(
                20),
          ),
        ),

        onPressed: () {

          Navigator.push(

            context,

            MaterialPageRoute(
              builder: (_) => page,
            ),
          );
        },

        icon: Icon(
          icon,
          color: Colors.white,
        ),

        label: Text(

          title,

          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight:
            FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {

    final user =
        FirebaseAuth.instance.currentUser;

    final userName =
        user?.displayName ?? "User";

    return SafeArea(

      child: SingleChildScrollView(

        padding:
        const EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 10),

            Row(

              mainAxisAlignment:
              MainAxisAlignment
                  .spaceBetween,

              children: [

                Expanded(

                  child: Column(

                    crossAxisAlignment:
                    CrossAxisAlignment
                        .start,

                    children: [

                      Text(
                        "Hello, $userName 👋",

                        style:
                        const TextStyle(
                          color: Colors.grey,
                          fontSize: 18,
                        ),
                      ),

                      const SizedBox(
                          height: 10),

                      const Text(
                        "FinderHub",

                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 42,
                          fontWeight:
                          FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                          height: 8),

                      const Text(
                        "Find lost items instantly",

                        style: TextStyle(
                          color: AppColors
                              .textGrey,
                          fontSize: 17,
                        ),
                      ),
                    ],
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
                    const EdgeInsets.all(
                        14),

                    decoration:
                    BoxDecoration(

                      color:
                      AppColors.cardColor,

                      borderRadius:
                      BorderRadius.circular(
                          18),

                      border: Border.all(
                        color:
                        Colors.white10,
                      ),
                    ),

                    child: const Icon(
                      Icons
                          .notifications_none,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 35),

            Container(

              decoration: BoxDecoration(

                borderRadius:
                BorderRadius.circular(
                    24),
              ),

              child: TextField(

                style: const TextStyle(
                  color: Colors.white,
                ),

                decoration:
                InputDecoration(

                  hintText:
                  "Search lost & found items...",

                  hintStyle:
                  const TextStyle(
                    color: Colors.grey,
                  ),

                  prefixIcon:
                  const Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),

                  filled: true,

                  fillColor:
                  AppColors.cardColor,

                  border:
                  OutlineInputBorder(

                    borderRadius:
                    BorderRadius.circular(
                        24),

                    borderSide:
                    BorderSide.none,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              "Lost Items",

              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            StreamBuilder<QuerySnapshot>(

              stream:
              FirebaseFirestore.instance
                  .collection(
                  "lost_reports")
                  .orderBy(
                "createdAt",
                descending: true,
              )
                  .snapshots(),

              builder:
                  (context, snapshot) {

                if (!snapshot.hasData) {

                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                final reports =
                    snapshot.data!.docs;

                if (reports.isEmpty) {

                  return const Padding(

                    padding:
                    EdgeInsets.all(
                        20),

                    child: Text(
                      "No lost reports yet",

                      style: TextStyle(
                        color:
                        Colors.white54,
                      ),
                    ),
                  );
                }

                return ListView.builder(

                  shrinkWrap: true,

                  physics:
                  const NeverScrollableScrollPhysics(),

                  itemCount:
                  reports.length,

                  itemBuilder:
                      (context, index) {

                    final data =
                    reports[index]
                        .data()
                    as Map<String,
                        dynamic>;

                    return reportCard(
                      context,
                      data,
                      Colors.redAccent,
                      "Lost",
                    );
                  },
                );
              },
            ),

            const SizedBox(height: 35),

            const Text(
              "Found Items",

              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            StreamBuilder<QuerySnapshot>(

              stream:
              FirebaseFirestore.instance
                  .collection(
                  "found_reports")
                  .orderBy(
                "createdAt",
                descending: true,
              )
                  .snapshots(),

              builder:
                  (context, snapshot) {

                if (!snapshot.hasData) {

                  return const Center(
                    child:
                    CircularProgressIndicator(),
                  );
                }

                final reports =
                    snapshot.data!.docs;

                if (reports.isEmpty) {

                  return const Padding(

                    padding:
                    EdgeInsets.all(
                        20),

                    child: Text(
                      "No found reports yet",

                      style: TextStyle(
                        color:
                        Colors.white54,
                      ),
                    ),
                  );
                }

                return ListView.builder(

                  shrinkWrap: true,

                  physics:
                  const NeverScrollableScrollPhysics(),

                  itemCount:
                  reports.length,

                  itemBuilder:
                      (context, index) {

                    final data =
                    reports[index]
                        .data()
                    as Map<String,
                        dynamic>;

                    return reportCard(
                      context,
                      data,
                      Colors.greenAccent,
                      "Found",
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget reportCard(
      BuildContext context,
      Map<String, dynamic> data,
      Color color,
      String type,
      ) {

    return Container(

      margin:
      const EdgeInsets.only(
          bottom: 18),

      padding:
      const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: AppColors.cardColor,

        borderRadius:
        BorderRadius.circular(24),

        border: Border.all(
          color: Colors.white10,
        ),
      ),

      child: Column(

        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: [

          Row(

            mainAxisAlignment:
            MainAxisAlignment
                .spaceBetween,

            children: [

              Expanded(

                child: Text(

                  data["title"] ?? "",

                  style:
                  const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              Container(

                padding:
                const EdgeInsets
                    .symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),

                decoration:
                BoxDecoration(

                  color:
                  color.withValues(
                    alpha: 0.15,
                  ),

                  borderRadius:
                  BorderRadius.circular(
                      20),
                ),

                child: Text(

                  type,

                  style: TextStyle(
                    color: color,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Row(

            children: [

              const Icon(
                Icons.location_on,
                color: Colors.grey,
                size: 18,
              ),

              const SizedBox(width: 6),

              Expanded(

                child: Text(

                  data["location"] ?? "",

                  style:
                  const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          Text(

            data["description"] ?? "",

            style: const TextStyle(
              color: Colors.white70,
              fontSize: 15,
            ),
          ),

          const SizedBox(height: 12),


          Row(

            children: [

              const Icon(
                Icons.access_time_rounded,
                size: 15,
                color: Colors.grey,
              ),


              const SizedBox(width: 6),


              Text(

                TimeHelper.getTime(
                  data["createdAt"],
                ),


                style: const TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),


          const SizedBox(height: 18),
          SizedBox(

            width: double.infinity,
            height: 52,

            child:
            ElevatedButton.icon(

              style:
              ElevatedButton
                  .styleFrom(

                backgroundColor:
                AppColors.primary,

                shape:
                RoundedRectangleBorder(

                  borderRadius:
                  BorderRadius.circular(
                      18),
                ),
              ),

              onPressed: () async {

                final currentUser =
                FirebaseAuth.instance.currentUser!;


                final receiverId =
                data["userId"];


                final chatId =
                currentUser.uid.compareTo(receiverId) > 0

                    ? "${currentUser.uid}_$receiverId"

                    : "${receiverId}_${currentUser.uid}";



                await FirebaseFirestore.instance
                    .collection("chats")
                    .doc(chatId)
                    .set({

                  "users": [

                    currentUser.uid,

                    receiverId,

                  ],


                  "otherUserName":
                  data["userName"] ?? "User",


                  "lastMessage":
                  "Start chatting",


                  "lastMessageTime":
                  FieldValue.serverTimestamp(),


                },
                  SetOptions(merge:true),
                );



                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) =>
                        PersonalChatScreen(

                          chatId: chatId,

                          name:
                          data["userName"] ?? "User",

                        ),
                  ),
                );
              },


              icon: const Icon(
                Icons
                    .chat_bubble_outline,
                color: Colors.white,
              ),

              label: const Text(

                "Message User",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}