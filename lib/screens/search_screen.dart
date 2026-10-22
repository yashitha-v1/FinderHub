import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() =>
      _SearchScreenState();
}

class _SearchScreenState
    extends State<SearchScreen> {

  final TextEditingController
  searchController =
  TextEditingController();

  String searchText = "";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      AppColors.background,

      body: SafeArea(

        child: Padding(

          padding:
          const EdgeInsets.all(24),

          child: Column(

            crossAxisAlignment:
            CrossAxisAlignment.start,

            children: [

              const SizedBox(height: 10),

              const Text(

                "Search Items",

                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight:
                  FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              const Text(

                "Find lost belongings quickly",

                style: TextStyle(
                  color:
                  AppColors.textGrey,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 30),

              TextField(

                controller:
                searchController,

                style:
                const TextStyle(
                  color:
                  Colors.white,
                ),

                onChanged: (value) {

                  setState(() {

                    searchText =
                        value.toLowerCase();
                  });
                },

                decoration:
                InputDecoration(

                  hintText:
                  "Search items...",

                  hintStyle:
                  const TextStyle(
                    color:
                    Colors.grey,
                  ),

                  prefixIcon:
                  const Icon(
                    Icons.search,
                    color:
                    Colors.grey,
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

              const SizedBox(height: 30),

              Expanded(

                child:
                StreamBuilder<QuerySnapshot>(

                  stream:
                  FirebaseFirestore.instance
                      .collection(
                      "lost_reports")
                      .snapshots(),

                  builder:
                      (context,
                      lostSnapshot) {

                    if (!lostSnapshot
                        .hasData) {

                      return const Center(
                        child:
                        CircularProgressIndicator(),
                      );
                    }

                    return StreamBuilder<
                        QuerySnapshot>(

                      stream:
                      FirebaseFirestore
                          .instance
                          .collection(
                          "found_reports")
                          .snapshots(),

                      builder:
                          (context,
                          foundSnapshot) {

                        if (!foundSnapshot
                            .hasData) {

                          return const Center(
                            child:
                            CircularProgressIndicator(),
                          );
                        }

                        final allDocs = [

                          ...lostSnapshot
                              .data!.docs,

                          ...foundSnapshot
                              .data!.docs,
                        ];

                        final filtered =
                        allDocs.where(
                                (doc) {

                              final data =
                              doc.data()
                              as Map<String,
                                  dynamic>;

                              final title =
                              data["title"]
                                  .toString()
                                  .toLowerCase();

                              final desc =
                              data["description"]
                                  .toString()
                                  .toLowerCase();

                              return title.contains(
                                  searchText) ||

                                  desc.contains(
                                      searchText);
                            }).toList();

                        if (filtered
                            .isEmpty) {

                          return Center(

                            child: Column(

                              mainAxisAlignment:
                              MainAxisAlignment
                                  .center,

                              children: [

                                Icon(

                                  Icons
                                      .search_off,

                                  color:
                                  Colors
                                      .white24,

                                  size: 90,
                                ),

                                const SizedBox(
                                    height:
                                    20),

                                const Text(

                                  "No matching items found",

                                  style:
                                  TextStyle(
                                    color:
                                    Colors
                                        .white70,

                                    fontSize:
                                    22,

                                    fontWeight:
                                    FontWeight
                                        .bold,
                                  ),
                                ),

                                const SizedBox(
                                    height:
                                    10),

                                const Text(

                                  "Try searching with another keyword",

                                  style:
                                  TextStyle(
                                    color:
                                    Colors
                                        .grey,

                                    fontSize:
                                    16,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView
                            .builder(

                          itemCount:
                          filtered.length,

                          itemBuilder:
                              (context,
                              index) {

                            final data =
                            filtered[
                            index]
                                .data()
                            as Map<String,
                                dynamic>;

                            final bool
                            isLost =
                                data["type"] ==
                                    "Lost";

                            return Container(

                              margin:
                              const EdgeInsets
                                  .only(
                                  bottom:
                                  18),

                              padding:
                              const EdgeInsets
                                  .all(20),

                              decoration:
                              BoxDecoration(

                                color:
                                AppColors
                                    .cardColor,

                                borderRadius:
                                BorderRadius.circular(
                                    24),

                                border:
                                Border.all(
                                  color:
                                  Colors
                                      .white10,
                                ),
                              ),

                              child:
                              Column(

                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                                children: [

                                  Row(

                                    mainAxisAlignment:
                                    MainAxisAlignment
                                        .spaceBetween,

                                    children: [

                                      Expanded(

                                        child:
                                        Text(

                                          data["title"]
                                              ??
                                              "",

                                          style:
                                          const TextStyle(
                                            color:
                                            Colors.white,

                                            fontSize:
                                            22,

                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                      ),

                                      Container(

                                        padding:
                                        const EdgeInsets.symmetric(
                                          horizontal:
                                          12,

                                          vertical:
                                          6,
                                        ),

                                        decoration:
                                        BoxDecoration(

                                          color: isLost

                                              ? Colors.redAccent.withValues(alpha: 0.15)

                                              : Colors.green.withValues(alpha: 0.15),

                                          borderRadius:
                                          BorderRadius.circular(20),
                                        ),

                                        child:
                                        Text(

                                          isLost
                                              ? "Lost"
                                              : "Found",

                                          style:
                                          TextStyle(

                                            color: isLost
                                                ? Colors.redAccent
                                                : Colors.greenAccent,

                                            fontWeight:
                                            FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height:
                                      14),

                                  Row(

                                    children: [

                                      const Icon(
                                        Icons.location_on,
                                        color:
                                        Colors.grey,
                                        size: 18,
                                      ),

                                      const SizedBox(
                                          width:
                                          6),

                                      Text(

                                        data["location"]
                                            ??
                                            "",

                                        style:
                                        const TextStyle(
                                          color:
                                          Colors.grey,

                                          fontSize:
                                          15,
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(
                                      height:
                                      12),

                                  Text(

                                    data["description"]
                                        ??
                                        "",

                                    style:
                                    const TextStyle(
                                      color:
                                      Colors.white70,

                                      fontSize:
                                      15,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}