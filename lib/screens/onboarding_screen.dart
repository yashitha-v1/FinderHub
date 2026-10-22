import 'package:flutter/material.dart';

import '../utils/app_colors.dart';
import 'login_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() =>
      _OnboardingScreenState();
}

class _OnboardingScreenState
    extends State<OnboardingScreen> {

  final PageController pageController =
  PageController();

  int currentIndex = 0;

  final List<Map<String, dynamic>>
  pages = [

    {
      "icon": Icons.search,
      "title": "Find Lost Items",
      "subtitle":
      "Search and recover lost belongings quickly around campus.",
    },

    {
      "icon":
      Icons.notifications_active,

      "title": "Instant Alerts",

      "subtitle":
      "Receive real-time notifications when someone reports your item.",
    },

    {
      "icon": Icons.chat,

      "title": "Secure Chats",

      "subtitle":
      "Connect safely with users and recover items faster.",
    },
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      AppColors.background,

      body: SafeArea(

        child: Column(

          children: [

            Expanded(

              child: PageView.builder(

                controller:
                pageController,

                itemCount:
                pages.length,

                onPageChanged:
                    (index) {

                  setState(() {

                    currentIndex =
                        index;
                  });
                },

                itemBuilder:
                    (context, index) {

                  return Padding(

                    padding:
                    const EdgeInsets.all(
                        24),

                    child: Column(

                      mainAxisAlignment:
                      MainAxisAlignment
                          .center,

                      children: [

                        Container(

                          padding:
                          const EdgeInsets
                              .all(40),

                          decoration:
                          BoxDecoration(

                            shape:
                            BoxShape.circle,

                            gradient:
                            LinearGradient(

                              colors: [

                                AppColors
                                    .primary,

                                Colors.purple,
                              ],
                            ),

                            boxShadow: [

                              BoxShadow(

                                color:
                                AppColors
                                    .primary
                                    .withOpacity(
                                    0.4),

                                blurRadius:
                                35,
                              ),
                            ],
                          ),

                          child: Icon(

                            pages[index]
                            ["icon"],

                            size: 100,

                            color:
                            Colors.white,
                          ),
                        ),

                        const SizedBox(
                            height: 60),

                        Text(

                          pages[index]
                          ["title"],

                          textAlign:
                          TextAlign.center,

                          style:
                          const TextStyle(

                            color:
                            Colors.white,

                            fontSize: 36,

                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                            height: 25),

                        Text(

                          pages[index]
                          ["subtitle"],

                          textAlign:
                          TextAlign.center,

                          style:
                          const TextStyle(

                            color:
                            AppColors
                                .textGrey,

                            fontSize: 18,

                            height: 1.7,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Row(

              mainAxisAlignment:
              MainAxisAlignment.center,

              children: List.generate(

                pages.length,

                    (index) {

                  return AnimatedContainer(

                    duration:
                    const Duration(
                        milliseconds:
                        300),

                    margin:
                    const EdgeInsets
                        .symmetric(
                      horizontal: 5,
                    ),

                    height: 10,

                    width:
                    currentIndex ==
                        index
                        ? 35
                        : 10,

                    decoration:
                    BoxDecoration(

                      color:
                      currentIndex ==
                          index
                          ? AppColors
                          .primary
                          : Colors.grey,

                      borderRadius:
                      BorderRadius
                          .circular(
                          20),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 40),

            Padding(

              padding:
              const EdgeInsets.symmetric(
                horizontal: 24,
              ),

              child: SizedBox(

                width: double.infinity,
                height: 62,

                child: ElevatedButton(

                  style:
                  ElevatedButton.styleFrom(

                    backgroundColor:
                    AppColors.primary,

                    shape:
                    RoundedRectangleBorder(

                      borderRadius:
                      BorderRadius
                          .circular(
                          22),
                    ),
                  ),

                  onPressed: () {

                    if (currentIndex ==
                        pages.length - 1) {

                      Navigator
                          .pushReplacement(

                        context,

                        MaterialPageRoute(
                          builder: (_) =>
                          const LoginScreen(),
                        ),
                      );
                    }

                    else {

                      pageController
                          .nextPage(

                        duration:
                        const Duration(
                          milliseconds:
                          400,
                        ),

                        curve:
                        Curves.easeInOut,
                      );
                    }
                  },

                  child: Text(

                    currentIndex ==
                        pages.length - 1
                        ? "Get Started"
                        : "Next",

                    style:
                    const TextStyle(

                      color:
                      Colors.white,

                      fontSize: 20,

                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}