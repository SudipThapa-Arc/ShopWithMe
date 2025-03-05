import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopwithme/constants/consts.dart';
import 'package:shopwithme/constants/common_lists.dart';
import 'package:shopwithme/views/auth_screen/signup_screen.dart';
import 'package:shopwithme/controllers/auth_controller.dart';
import 'package:shopwithme/common_widgets/applogowidget.dart';
import 'package:shopwithme/common_widgets/bgwidget.dart';
import 'package:shopwithme/common_widgets/text_fields.dart';

import '../../common_widgets/common_button.dart';
import '../home_screen/home.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late AuthController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.put(AuthController());
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogowidget(),
              15.heightBox,
              "Log in to $appname".text.fontFamily(bold).size(22).white.make(),
              10.heightBox,
              Column(
                children: [
                  customtextfield(
                    hint: emailhint,
                    title: email,
                    controller: emailController,
                    isPass: false,
                  ),
                  5.heightBox,
                  customtextfield(
                    hint: passwordhint,
                    title: password,
                    controller: passwordController,
                    isPass: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgotpassword.text.color(redColor).make()
                    )
                  ),
                  5.heightBox,
                  Row(
                    children: [
                      Obx(
                        () => Checkbox(
                          activeColor: redColor,
                          checkColor: whiteColor,
                          value: controller.isCheck.value,
                          onChanged: (newValue) {
                            controller.toggleCheckbox();
                          },
                        ),
                      ),
                      5.widthBox,
                      Expanded(
                        child: RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "I agree to the ",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: fontGrey,
                                ),
                              ),
                              TextSpan(
                                text: "Terms and Conditions & Privacy Policy",
                                style: TextStyle(
                                  fontFamily: regular,
                                  color: redColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  5.heightBox,
                  custombutton(
                    title: login,
                    textColor: whiteColor,
                    color: redColor,
                    onPress: () async {
                      if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                        VxToast.show(context, msg: "Please fill all fields");
                        return;
                      }

                      if (!controller.isCheck.value) {
                        VxToast.show(context, msg: "Please agree to terms & conditions");
                        return;
                      }

                      try {
                        controller.isLoading(true);
                        // Show loading indicator
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => const Center(child: CircularProgressIndicator()),
                        );
                        
                        await controller.login(
                          emailController.text.trim(),
                          passwordController.text.trim(),
                        ).then((value) {
                          // Hide loading indicator
                          Navigator.pop(context);
                          if (value != null) {
                            VxToast.show(context, msg: "Logged in successfully");
                            Get.offAll(() => const Home());
                          }
                        });
                      } catch (e) {
                        // Hide loading indicator if error occurs
                        Navigator.pop(context);
                        VxToast.show(context, msg: e.toString());
                      } finally {
                        controller.isLoading(false);
                      }
                    }
                  ).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  createaccount.text.color(fontGrey).make(),
                  10.heightBox,
                  custombutton(
                      title: signup,
                      textColor: whiteColor,
                      color: goldencolor,
                      onPress: () {
                        Get.to(() => Signupscreen());
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  loginwith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          3,
                          (index) => Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                      radius: 25,
                                      backgroundColor: lightGrey,
                                      child: Image.asset(
                                        socialIconList[index],
                                        width: 20,
                                      )))
                              .box
                              .margin(const EdgeInsets.all(8))
                              .rounded
                              .make()))
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
