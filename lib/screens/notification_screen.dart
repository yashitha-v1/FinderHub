import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/app_colors.dart';
import '../utils/time_helper.dart';


class NotificationScreen extends StatelessWidget {

  const NotificationScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      AppColors.background,


      appBar: AppBar(

        backgroundColor:
        AppColors.background,

        elevation: 0,


        title: const Text(

          "Notifications",

          style: TextStyle(

            color: Colors.white,

            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),



      body:
      StreamBuilder<QuerySnapshot>(


        stream:
        FirebaseFirestore.instance

            .collection("notifications")

            .orderBy(
          "createdAt",
          descending: true,
        )

            .snapshots(),



        builder:
            (context, snapshot){



          if(!snapshot.hasData){


            return const Center(

              child:
              CircularProgressIndicator(),

            );

          }



          final notifications =
              snapshot.data!.docs;




          if(notifications.isEmpty){


            return const Center(

              child: Text(

                "No notifications yet 🔔",

                style: TextStyle(

                  color:
                  Colors.white54,

                  fontSize:16,

                ),

              ),

            );

          }




          return ListView.builder(


            padding:
            const EdgeInsets.all(16),


            itemCount:
            notifications.length,



            itemBuilder:
                (context,index){



              final data =
              notifications[index]
                  .data()
              as Map<String,dynamic>;




              return Container(


                margin:
                const EdgeInsets.only(
                    bottom:14),


                padding:
                const EdgeInsets.all(16),



                decoration:
                BoxDecoration(


                  color:
                  AppColors.cardColor,


                  borderRadius:
                  BorderRadius.circular(20),



                  border:
                  Border.all(

                    color:
                    Colors.white10,

                  ),
                ),



                child: Row(


                  children:[



                    CircleAvatar(


                      radius:25,


                      backgroundColor:

                      data["type"] == "Lost"

                          ? Colors.redAccent

                          : Colors.green,



                      child:
                      Icon(

                        data["type"] == "Lost"

                            ? Icons.warning_rounded

                            : Icons.check_circle,


                        color:
                        Colors.white,

                      ),

                    ),




                    const SizedBox(width:15),




                    Expanded(


                      child: Column(


                        crossAxisAlignment:
                        CrossAxisAlignment.start,



                        children:[



                          Text(


                            data["title"] ?? "",


                            style:
                            const TextStyle(

                              color:
                              Colors.white,


                              fontSize:16,


                              fontWeight:
                              FontWeight.bold,

                            ),

                          ),




                          const SizedBox(height:5),




                          Text(


                            data["message"] ?? "",


                            style:
                            const TextStyle(

                              color:
                              Colors.grey,

                            ),

                          ),



                          const SizedBox(height:8),




                          Row(

                            children:[

                              const Icon(

                                Icons.access_time,

                                size:14,

                                color:
                                Colors.grey,

                              ),


                              const SizedBox(width:5),



                              Text(


                                TimeHelper.getTime(

                                  data["createdAt"],

                                ),


                                style:
                                const TextStyle(

                                  color:
                                  Colors.grey,

                                  fontSize:12,

                                ),
                              ),

                            ],

                          ),
                        ],

                      ),

                    ),

                  ],

                ),

              );

            },

          );

        },

      ),

    );

  }

}