import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReportFoundScreen extends StatefulWidget {
  const ReportFoundScreen({super.key});

  @override
  State<ReportFoundScreen> createState() =>
      _ReportFoundScreenState();
}

class _ReportFoundScreenState
    extends State<ReportFoundScreen> {

  final titleController =
  TextEditingController();

  final locationController =
  TextEditingController();

  final descriptionController =
  TextEditingController();

  File? selectedImage;

  bool isLoading = false;

  Future<void> pickImage() async {

    final picker = ImagePicker();

    final image = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (image != null) {

      setState(() {

        selectedImage =
            File(image.path);
      });
    }
  }

  Future<void> submitReport() async {

    String title =
    titleController.text.trim();

    String location =
    locationController.text.trim();

    String description =
    descriptionController.text.trim();

    if (title.isEmpty ||
        location.isEmpty ||
        description.isEmpty) {

      showMessage(
          "Please fill all fields and select image");

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {

      final user =
          FirebaseAuth.instance.currentUser;

      await FirebaseFirestore.instance
          .collection("found_reports")
          .add({

        "title": title,

        "location": location,

        "description": description,

        "imageUrl": "",

        "type": "Found",

        "userName":
        user?.displayName ?? "User",

        "userEmail":
        user?.email ?? "",

        "userId":
        user?.uid ?? "",


        "createdAt":
        FieldValue.serverTimestamp(),

      });
      await FirebaseFirestore.instance
          .collection("notifications")
          .add({

        "title": "New Lost Item 🔴",

        "message":
        "${user?.displayName ?? "Someone"} reported $title",

        "type": "Lost",

        "createdAt":
        FieldValue.serverTimestamp(),

      });


      if (!mounted) return;

      showMessage(
        "Found Item Report Submitted ✅",
      );

      Navigator.pop(context);

    } catch (e) {

      showMessage(
        e.toString(),
      );

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

        shape:
        RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(
              14),
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

      appBar: AppBar(

        backgroundColor:
        AppColors.background,

        elevation: 0,

        centerTitle: true,

        title: const Text(
          "Report Found Item",

          style: TextStyle(
            color: Colors.white,
            fontWeight:
            FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(

        padding:
        const EdgeInsets.all(24),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            const SizedBox(height: 10),

            const Text(
              "Found something?",

              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
                fontWeight:
                FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Fill the details below to create a report.",

              style: TextStyle(
                color:
                AppColors.textGrey,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 35),

            buildField(
              controller:
              titleController,
              hint: "Item Name",
              icon:
              Icons.inventory_2,
            ),

            const SizedBox(height: 24),

            buildField(
              controller:
              locationController,
              hint: "Found Location",
              icon:
              Icons.location_on,
            ),

            const SizedBox(height: 24),

            TextField(

              controller:
              descriptionController,

              maxLines: 5,

              style: const TextStyle(
                color: Colors.white,
              ),

              decoration:
              InputDecoration(

                hintText:
                "Describe the item",

                hintStyle:
                const TextStyle(
                  color: Colors.grey,
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

            GestureDetector(

              onTap: pickImage,

              child: Container(

                height: 220,
                width: double.infinity,

                decoration:
                BoxDecoration(

                  color:
                  AppColors.cardColor,

                  borderRadius:
                  BorderRadius.circular(
                      24),

                  border: Border.all(
                    color: Colors.white10,
                  ),
                ),

                child: selectedImage == null

                    ? Column(

                  mainAxisAlignment:
                  MainAxisAlignment
                      .center,

                  children: const [

                    Icon(
                      Icons.cloud_upload,
                      color:
                      AppColors.primary,
                      size: 60,
                    ),

                    SizedBox(height: 15),

                    Text(
                      "Upload Item Image",

                      style: TextStyle(
                        color:
                        Colors.white,

                        fontSize: 18,

                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ],
                )

                    : ClipRRect(

                  borderRadius:
                  BorderRadius.circular(
                      24),

                  child: Image.file(

                    selectedImage!,

                    fit: BoxFit.cover,
                    width:
                    double.infinity,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 40),

            SizedBox(

              width: double.infinity,
              height: 62,

              child: ElevatedButton(

                style:
                ElevatedButton.styleFrom(

                  backgroundColor:
                  Colors.green,

                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(
                        22),
                  ),
                ),

                onPressed:
                isLoading
                    ? null
                    : submitReport,

                child: isLoading

                    ? const CircularProgressIndicator(
                  color: Colors.white,
                )

                    : const Text(
                  "Submit Report",

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
          ],
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

        border: OutlineInputBorder(

          borderRadius:
          BorderRadius.circular(22),

          borderSide:
          BorderSide.none,
        ),
      ),
    );
  }
}