import 'package:flutter/material.dart';
import '../utils/app_colors.dart';

class ItemDetailsScreen extends StatelessWidget {
  const ItemDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.background,

      body: SingleChildScrollView(

        child: Column(

          children: [

            Stack(

              children: [

                Container(

                  height: 320,
                  width: double.infinity,

                  decoration: const BoxDecoration(

                    image: DecorationImage(

                      image: NetworkImage(
                        "https://images.unsplash.com/photo-1511707171634-5f897ff02aa9",
                      ),

                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                Positioned(

                  top: 50,
                  left: 20,

                  child: CircleAvatar(

                    backgroundColor:
                    Colors.black54,

                    child: IconButton(

                      onPressed: () {

                        Navigator.pop(context);
                      },

                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                Positioned(

                  top: 50,
                  right: 20,

                  child: CircleAvatar(

                    backgroundColor:
                    Colors.black54,

                    child: IconButton(

                      onPressed: () {

                        ScaffoldMessenger.of(
                            context)
                            .showSnackBar(

                          const SnackBar(
                            content:
                            Text("Saved"),
                          ),
                        );
                      },

                      icon: const Icon(
                        Icons.bookmark_border,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),

            Container(

              padding: const EdgeInsets.all(24),

              decoration: const BoxDecoration(

                color: AppColors.background,

                borderRadius:
                BorderRadius.only(

                  topLeft:
                  Radius.circular(35),

                  topRight:
                  Radius.circular(35),
                ),
              ),

              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,

                children: [

                  Row(

                    children: [

                      Expanded(

                        child: Column(

                          crossAxisAlignment:
                          CrossAxisAlignment.start,

                          children: [

                            const Text(
                              "Apple AirPods Pro",

                              style: TextStyle(
                                color:
                                Colors.white,

                                fontSize: 32,

                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),

                            const SizedBox(height: 14),

                            Row(

                              children: [

                                Container(

                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),

                                  decoration:
                                  BoxDecoration(

                                    color:
                                    AppColors.red
                                        .withOpacity(
                                        0.15),

                                    borderRadius:
                                    BorderRadius.circular(
                                        14),
                                  ),

                                  child: const Text(
                                    "LOST",

                                    style:
                                    TextStyle(
                                      color:
                                      AppColors.red,

                                      fontWeight:
                                      FontWeight
                                          .bold,
                                    ),
                                  ),
                                ),

                                const SizedBox(
                                    width: 15),

                                const Icon(
                                  Icons.location_on,
                                  color: Colors.grey,
                                  size: 18,
                                ),

                                const SizedBox(
                                    width: 5),

                                const Text(
                                  "Library Block",

                                  style: TextStyle(
                                    color:
                                    AppColors
                                        .textGrey,

                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 35),

                  infoCard(
                    Icons.calendar_today,
                    "Reported Date",
                    "16 March 2026",
                  ),

                  const SizedBox(height: 18),

                  infoCard(
                    Icons.attach_money,
                    "Reward",
                    "₹1000",
                  ),

                  const SizedBox(height: 18),

                  infoCard(
                    Icons.person,
                    "Reported By",
                    "Rahul Sharma",
                  ),

                  const SizedBox(height: 35),

                  const Text(
                    "Description",

                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight:
                      FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Black Apple AirPods Pro case lost near the library block during afternoon classes. If found please contact immediately.",

                    style: TextStyle(
                      color: AppColors.textGrey,
                      fontSize: 18,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 40),

                  Row(

                    children: [

                      Expanded(

                        child:
                        ElevatedButton.icon(

                          style:
                          ElevatedButton.styleFrom(

                            backgroundColor:
                            AppColors.primary,

                            minimumSize:
                            const Size(0, 65),

                            shape:
                            RoundedRectangleBorder(

                              borderRadius:
                              BorderRadius.circular(
                                  22),
                            ),
                          ),

                          onPressed: () {

                            ScaffoldMessenger.of(
                                context)
                                .showSnackBar(

                              const SnackBar(
                                content:
                                Text(
                                  "Opening Chat",
                                ),
                              ),
                            );
                          },

                          icon: const Icon(
                            Icons.chat,
                            color: Colors.white,
                          ),

                          label: const Text(
                            "Chat",

                            style: TextStyle(
                              color:
                              Colors.white,

                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 18),

                      Expanded(

                        child:
                        ElevatedButton.icon(

                          style:
                          ElevatedButton.styleFrom(

                            backgroundColor:
                            AppColors.green,

                            minimumSize:
                            const Size(0, 65),

                            shape:
                            RoundedRectangleBorder(

                              borderRadius:
                              BorderRadius.circular(
                                  22),
                            ),
                          ),

                          onPressed: () {

                            ScaffoldMessenger.of(
                                context)
                                .showSnackBar(

                              const SnackBar(
                                content: Text(
                                  "Claim Request Sent",
                                ),
                              ),
                            );
                          },

                          icon: const Icon(
                            Icons.check_circle,
                            color: Colors.white,
                          ),

                          label: const Text(
                            "Claim",

                            style: TextStyle(
                              color:
                              Colors.white,

                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget infoCard(
      IconData icon,
      String title,
      String value,
      ) {

    return Container(

      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(

        color: AppColors.cardColor,

        borderRadius:
        BorderRadius.circular(24),
      ),

      child: Row(

        children: [

          Container(

            padding: const EdgeInsets.all(14),

            decoration: BoxDecoration(

              color:
              AppColors.primary
                  .withOpacity(0.15),

              borderRadius:
              BorderRadius.circular(18),
            ),

            child: Icon(
              icon,
              color: AppColors.primary,
            ),
          ),

          const SizedBox(width: 18),

          Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              Text(
                title,

                style: const TextStyle(
                  color:
                  AppColors.textGrey,

                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 5),

              Text(
                value,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}