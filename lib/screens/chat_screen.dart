import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';


class ChatScreen extends StatelessWidget {

  ChatScreen({super.key});

  final currentUser =
      FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor: AppColors.background,


      appBar: AppBar(

        backgroundColor:
        AppColors.background,

        elevation: 0,

        title: const Text(
          "Chats",

          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),


      body: StreamBuilder<QuerySnapshot>(

        stream: FirebaseFirestore.instance

            .collection("chats")

            .where(
          "users",
          arrayContains:
          currentUser!.uid,
        )

            .orderBy(
          "lastMessageTime",
          descending: true,
        )

            .snapshots(),


        builder:(context,snapshot){


          if(!snapshot.hasData){

            return const Center(
              child:
              CircularProgressIndicator(),
            );
          }


          final chats =
              snapshot.data!.docs;


          if(chats.isEmpty){

            return const Center(

              child: Text(

                "No chats yet 💬",

                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
            );
          }



          return ListView.builder(

            itemCount:
            chats.length,


            itemBuilder:
                (context,index){


              final data =
              chats[index].data()
              as Map<String,dynamic>;



              return ListTile(


                leading:
                const CircleAvatar(

                  backgroundColor:
                  AppColors.primary,

                  child: Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),



                title: Text(

                  data["otherUserName"]
                      ?? "User",

                  style:
                  const TextStyle(

                    color: Colors.white,

                    fontWeight:
                    FontWeight.bold,
                  ),
                ),



                subtitle: Text(

                  data["lastMessage"]
                      ?? "Start chatting",

                  maxLines:1,

                  overflow:
                  TextOverflow.ellipsis,


                  style:
                  const TextStyle(
                    color:Colors.grey,
                  ),
                ),


                trailing: Text(

                  data["lastMessageTime"] == null

                      ? ""

                      : DateFormat("hh:mm a")
                      .format(
                    data["lastMessageTime"]
                        .toDate(),
                  ),


                  style:
                  const TextStyle(
                    color:Colors.grey,
                    fontSize:12,
                  ),
                ),



                onTap:(){


                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder:(_)=>

                          PersonalChatScreen(

                            chatId:
                            chats[index].id,


                            name:
                            data["otherUserName"]
                                ?? "User",
                          ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}class PersonalChatScreen extends StatefulWidget {

  final String chatId;
  final String name;


  const PersonalChatScreen({

    super.key,

    required this.chatId,
    required this.name,

  });


  @override
  State<PersonalChatScreen> createState()
  =>
      _PersonalChatScreenState();
}



class _PersonalChatScreenState
    extends State<PersonalChatScreen> {


  final TextEditingController
  messageController =
  TextEditingController();


  final ScrollController
  scrollController =
  ScrollController();


  final currentUser =
      FirebaseAuth.instance.currentUser;




  Future<void> sendMessage() async {


    if(messageController.text
        .trim()
        .isEmpty){

      return;

    }



    String msg =
    messageController.text.trim();


    messageController.clear();



    await FirebaseFirestore.instance

        .collection("chats")

        .doc(widget.chatId)

        .collection("messages")

        .add({


      "message": msg,


      "senderId":
      currentUser!.uid,


      "senderEmail":
      currentUser!.email,


      "timestamp":
      FieldValue.serverTimestamp(),


      "isRead": false,


    });





    await FirebaseFirestore.instance

        .collection("chats")

        .doc(widget.chatId)

        .update({


      "lastMessage": msg,


      "lastMessageTime":
      FieldValue.serverTimestamp(),


    });




    Future.delayed(

      const Duration(
          milliseconds: 300),

          (){

        if(scrollController.hasClients){

          scrollController.animateTo(

            scrollController
                .position
                .maxScrollExtent,


            duration:
            const Duration(
                milliseconds:300),


            curve:
            Curves.easeOut,

          );

        }

      },
    );

  }






  @override
  Widget build(BuildContext context) {


    return Scaffold(


      backgroundColor:
      AppColors.background,



      appBar: AppBar(


        backgroundColor:
        AppColors.background,


        elevation:0,


        title: Column(


          crossAxisAlignment:
          CrossAxisAlignment.start,


          children:[


            Text(

              widget.name,


              style:
              const TextStyle(

                color:Colors.white,

                fontWeight:
                FontWeight.bold,

              ),

            ),



            const Text(

              "Online",

              style:
              TextStyle(

                color:Colors.greenAccent,

                fontSize:12,

              ),

            ),

          ],
        ),

      ),





      body: Column(


          children:[




      Expanded(

      child:
      StreamBuilder<QuerySnapshot>(


          stream:
          FirebaseFirestore.instance

              .collection("chats")

          .doc(widget.chatId)

          .collection("messages")

          .orderBy("timestamp")

          .snapshots(),



      builder:
          (context,snapshot){



        if(!snapshot.hasData){


          return const Center(

            child:
            CircularProgressIndicator(),

          );

        }



        final messages =
            snapshot.data!.docs;



        return ListView.builder(


          controller:
          scrollController,


          padding:
          const EdgeInsets.all(16),


          itemCount:
          messages.length,


          itemBuilder:
              (context,index){



            final data =
            messages[index].data()
            as Map<String,dynamic>;



            bool isMe =
                data["senderId"]
                    ==
                    currentUser!.uid;




            return Align(


              alignment:

              isMe

                  ? Alignment.centerRight

                  : Alignment.centerLeft,



              child: Container(


                constraints:
                BoxConstraints(

                  maxWidth:
                  MediaQuery.of(context)
                      .size
                      .width
                      *0.75,

                ),



                margin:
                const EdgeInsets.only(
                    bottom:12),



                padding:
                const EdgeInsets.all(14),



                decoration:
                BoxDecoration(


                  color:

                  isMe

                      ? AppColors.primary

                      : AppColors.cardColor,



                  borderRadius:
                  BorderRadius.circular(18),

                ),




                child: Column(


                  crossAxisAlignment:
                  CrossAxisAlignment.end,


                  children:[



                    Text(


                      data["message"] ?? "",



                      style:
                      const TextStyle(

                        color:Colors.white,

                        fontSize:16,

                      ),

                    ),




                    const SizedBox(
                        height:5),




                    Text(


                      data["timestamp"] == null

                          ? ""

                          :

                      DateFormat("hh:mm a")

                          .format(

                        data["timestamp"]
                            .toDate(),

                      ),



                      style:
                      const TextStyle(

                        color:Colors.white70,

                        fontSize:10,

                      ),

                    ),

                  ],
                ),

              ),

            );

          },

        );

      },

    ),

    ),
            Container(

              padding:
              const EdgeInsets.all(12),


              decoration:
              const BoxDecoration(

                color:
                AppColors.cardColor,

              ),



              child: Row(


                children:[




                  Expanded(


                    child: TextField(


                      controller:
                      messageController,


                      style:
                      const TextStyle(

                        color:
                        Colors.white,

                      ),



                      decoration:
                      InputDecoration(


                        hintText:
                        "Type a message...",


                        hintStyle:
                        const TextStyle(

                          color:
                          Colors.grey,

                        ),



                        filled:true,


                        fillColor:
                        AppColors.background,



                        contentPadding:
                        const EdgeInsets.symmetric(

                          horizontal:18,

                          vertical:14,

                        ),



                        border:
                        OutlineInputBorder(


                          borderRadius:
                          BorderRadius.circular(25),


                          borderSide:
                          BorderSide.none,

                        ),

                      ),

                    ),

                  ),





                  const SizedBox(width:10),




                  CircleAvatar(


                    radius:27,


                    backgroundColor:
                    AppColors.primary,



                    child:
                    IconButton(


                      onPressed:
                      sendMessage,



                      icon:
                      const Icon(


                        Icons.send_rounded,


                        color:
                        Colors.white,

                      ),

                    ),

                  ),

                ],

              ),

            ),

          ],

      ),

    );

  }

}