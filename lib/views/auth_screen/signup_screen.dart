import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/consts.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/common_widgets/applogowidget.dart';
import 'package:myapp/common_widgets/common_button.dart';
import 'package:myapp/common_widgets/bgwidget.dart';
// import 'package:velocity_x/velocity_x.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  bool ischeck = false;
  var controller = Get.put(AuthController());
  
  // Add TextEditingControllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.addListener(() {
      print("Name controller updated: '${nameController.text}'");
      print("Name controller trimmed: '${nameController.text.trim()}'");
    });
  }

  @override
  void dispose() {
    // Clean up controllers
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    retypePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogowidget(),
              15.heightBox,
              "Join the $appname".text.fontFamily(bold).size(22).white.make(),
              10.heightBox,
              Column(
                children: [
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: namehint,
                      labelText: name,
                    ),
                  ),
                  5.heightBox,
                  TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      hintText: emailhint,
                      labelText: email,
                    ),
                  ),
                  5.heightBox,
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: passwordhint,
                      labelText: password,
                    ),
                  ),
                  5.heightBox,
                  TextField(
                    controller: retypePasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: passwordhint,
                      labelText: retypepassword,
                    ),
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: redColor,
                        checkColor: whiteColor,
                        value: ischeck,
                        onChanged: (newValue) {
                          setState(() {
                            ischeck = newValue!;
                          });
                        },
                      ),
                      5.widthBox,
                      Expanded(
                          child: RichText(
                              text: const TextSpan(children: [
                        TextSpan(
                            text: "I agree to the ",
                            style: TextStyle(
                                fontFamily: regular, color: fontGrey)),
                        TextSpan(
                            text: "Terms and Conditions & Privacy Policy",
                            style: TextStyle(
                                fontFamily: regular, color: redColor)),
                      ])))
                    ],
                  ),
                  5.heightBox,
                  custombutton(
                      color: ischeck == true ? redColor : lightGrey,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () async {
                        // Debug prints to check input values
                        print("Name: '${nameController.text.trim()}'");
                        print("Email: '${emailController.text.trim()}'");
                        print("Password: '${passwordController.text.trim()}'");
                        print("Retype Password: '${retypePasswordController.text.trim()}'");
                        print("Terms Checked: $ischeck");

                        if (ischeck != true) {
                          VxToast.show(context,
                              msg: "Please agree to Terms & Conditions");
                        } else if (nameController.text.trim().isEmpty) {
                          print("Name validation failed"); // Debug print
                          VxToast.show(context, msg: "Please enter name");
                        } else if (emailController.text.trim().isEmpty) {
                          VxToast.show(context, msg: "Please enter email");
                        } else if (passwordController.text.trim().isEmpty) {
                          VxToast.show(context, msg: "Please enter password");
                        } else if (passwordController.text != retypePasswordController.text) {
                          VxToast.show(context,
                              msg: "Passwords don't match");
                        } else {
                          try {
                            controller.isLoading(true);
                            await controller.registerUser(
                              emailController.text.trim(),
                              passwordController.text.trim(),
                            ).then((value) async {
                              if (value != null) {
                                print("Registration successful, storing user data..."); // Debug print
                                await controller.storeUserData(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                  name: nameController.text.trim(),
                                  uid: value.user!.uid,
                                );
                                VxToast.show(context, msg: "Account created successfully");
                                Get.back();
                              }
                            });
                          } catch (e) {
                            print("Error during registration: $e"); // Debug print
                            VxToast.show(context, msg: e.toString());
                          } finally {
                            controller.isLoading(false);
                          }
                        }
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  RichText(
                      text: const TextSpan(children: [
                    TextSpan(
                        text: alreadyhaveaccount,
                        style: TextStyle(fontFamily: bold, color: fontGrey)),
                    TextSpan(
                        text: login,
                        style: TextStyle(fontFamily: bold, color: redColor))
                  ])).onTap(() {
                    Get.back();
                  })
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 50)
                  .shadowSm
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    ));
  }
}
