// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:myapp/constants/colors.dart';
import 'package:myapp/constants/styles.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Profile Header Section with Green Background
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Vx.green500,
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  // Top Bar
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      "Profile".text.white.fontFamily(bold).size(22).make(),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                      ),
                    ],
                  ),
                  20.heightBox,
                  // Profile Image and Info
                  Row(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white,
                            child: Image.asset(
                              "assets/images/profile.png",
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: CircleAvatar(
                              radius: 12,
                              backgroundColor: golden,
                              child: const Icon(
                                Icons.edit,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      20.widthBox,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Md Abu Ubayda"
                              .text
                              .white
                              .fontFamily(semibold)
                              .size(16)
                              .make(),
                          5.heightBox,
                          "+8800712346789".text.white.make(),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            20.heightBox,
            // Account Overview Text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: "Account Overview"
                    .text
                    .color(darkFontGrey)
                    .fontFamily(semibold)
                    .make(),
              ),
            ),
            20.heightBox,
            // Menu Options
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          const Icon(Icons.person_outline, color: Colors.blue),
                    ),
                    title: "My Profile"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Vx.green500.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.shopping_bag_outlined,
                          color: Vx.green500),
                    ),
                    title: "My Orders"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.refresh_rounded,
                          color: Colors.purple),
                    ),
                    title: "Refund"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.orange.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child:
                          const Icon(Icons.lock_outline, color: Colors.orange),
                    ),
                    title: "Change Password"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                  ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.pink.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.language, color: Colors.pink),
                    ),
                    title: "Change Language"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
