import 'package:flutter/material.dart';
import 'package:shopwithme/constants/colors.dart';
import 'package:shopwithme/constants/styles.dart';
import 'package:get/get.dart';
import 'dart:math';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:shopwithme/controllers/auth_controller.dart';
import 'package:shopwithme/models/user_model.dart';
import 'package:shopwithme/services/user_service.dart';

export 'edit_profile.dart';

class EditProfile extends StatefulWidget {
  final UserModel currentUser;
  
  const EditProfile({
    super.key,
    required this.currentUser,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  File? _selectedImage;
  final AuthController _authController = Get.find<AuthController>();
  final UserService _userService = UserService();
  UserModel? currentUser;

  @override
  void initState() {
    super.initState();
    _initializeUserData();
  }

  void _initializeUserData() {
    currentUser = widget.currentUser;
    _nameController.text = currentUser?.name ?? '';
    _emailController.text = currentUser?.email ?? '';
    _phoneController.text = currentUser?.phone ?? '';
    _addressController.text = currentUser?.address ?? '';
  }

  Future<void> _saveChanges() async {
    try {
      if (currentUser == null) return;

      String? imageUrl = currentUser!.imageUrl;
      
      // Upload new image if selected
      if (_selectedImage != null) {
        imageUrl = await _userService.uploadProfileImage(currentUser!.id, _selectedImage!);
      }

      final updatedUser = UserModel(
        id: currentUser!.id,
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        imageUrl: imageUrl,
      );

      await _userService.updateUser(updatedUser);
      await _authController.refreshUserData();

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: whiteColor,
        snackPosition: SnackPosition.BOTTOM,
      );

      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update profile: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: whiteColor,
      );
    }
  }

  Future<void> _pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );
      
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to pick image: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: whiteColor,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    final bool isLargeScreen = screenSize.width > 1200;
    final double maxContentWidth = isLargeScreen ? 1200 : screenSize.width;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: redColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: whiteColor,
            size: min(screenSize.width * 0.05, 24),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
            color: whiteColor,
            fontFamily: bold,
            fontSize: min(screenSize.width * 0.045, 22),
          ),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            width: maxContentWidth,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(min(screenSize.width * 0.04, 20)),
              child: Column(
                children: [
                  // Profile Image Section
                  Stack(
                    children: [
                      Container(
                        height: min(screenSize.width * 0.3, 150),
                        width: min(screenSize.width * 0.3, 150),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: redColor, width: 3),
                          image: _selectedImage != null
                              ? DecorationImage(
                                  image: FileImage(_selectedImage!),
                                  fit: BoxFit.cover,
                                )
                              : const DecorationImage(
                                  image: NetworkImage(
                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCbC1JPjywAh3dxU_TJkwR98f9DSx1IOlPEg&s",
                                  ),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: golden,
                              shape: BoxShape.circle,
                              border: Border.all(color: whiteColor, width: 2),
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              color: whiteColor,
                              size: min(screenSize.width * 0.045, 20),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: min(screenSize.width * 0.06, 30)),

                  // Form Fields
                  buildTextField(
                    controller: _nameController,
                    hint: "Full Name",
                    icon: Icons.person_outline,
                    screenSize: screenSize,
                  ),
                  buildTextField(
                    controller: _emailController,
                    hint: "Email Address",
                    icon: Icons.email_outlined,
                    screenSize: screenSize,
                  ),
                  buildTextField(
                    controller: _phoneController,
                    hint: "Phone Number",
                    icon: Icons.phone_outlined,
                    screenSize: screenSize,
                  ),
                  buildTextField(
                    controller: _addressController,
                    hint: "Address",
                    icon: Icons.location_on_outlined,
                    screenSize: screenSize,
                    maxLines: 3,
                  ),
                  SizedBox(height: min(screenSize.width * 0.06, 30)),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    height: min(screenSize.height * 0.07, 50),
                    child: ElevatedButton(
                      onPressed: _saveChanges,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: redColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                          color: whiteColor,
                          fontFamily: bold,
                          fontSize: min(screenSize.width * 0.04, 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    required Size screenSize,
    int maxLines = 1,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: min(screenSize.width * 0.04, 20)),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: darkFontGrey.withOpacity(0.5),
            fontSize: min(screenSize.width * 0.035, 16),
          ),
          prefixIcon: Icon(icon, color: redColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: whiteColor,
          contentPadding: EdgeInsets.symmetric(
            horizontal: min(screenSize.width * 0.04, 20),
            vertical: min(screenSize.width * 0.03, 15),
          ),
        ),
      ),
    );
  }
}