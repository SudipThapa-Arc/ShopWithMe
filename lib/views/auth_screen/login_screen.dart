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

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    
    // Add TextEditingControllers
    var emailController = TextEditingController();
    var passwordController = TextEditingController();

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
                          child: forgotpassword.text.color(redColor).make())),
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
                        // First, unfocus any text fields to prevent the pointer binding error
                        FocusScope.of(context).unfocus();
                        
                        if (controller.isCheck.value) {
                          // Add validation for empty fields
                          if (emailController.text.isNotEmpty && 
                              passwordController.text.isNotEmpty) {
                            controller.isLoading(true);
                            
                            try {
                              // Simplified login flow
                              final result = await controller.login(
                                emailController.text.trim(),
                                passwordController.text.trim(),
                              );
                              
                              // If login was successful, navigate to home
                              if (result != null) {
                                // Add a small delay before navigation to ensure focus is properly cleared
                                await Future.delayed(Duration(milliseconds: 100));
                                Get.offAll(() => const Home());
                                VxToast.show(context, msg: "Logged in successfully");
                              }
                            } catch (e) {
                              VxToast.show(context, msg: "Login error: ${e.toString()}");
                            } finally {
                              controller.isLoading(false);
                            }
                          } else {
                            VxToast.show(context, msg: "Please fill all the fields");
                          }
                        } else {
                          VxToast.show(context, 
                            msg: "Please agree to terms & conditions"
                          );
                        }
                      }).box.width(context.screenWidth - 50).make(),
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
