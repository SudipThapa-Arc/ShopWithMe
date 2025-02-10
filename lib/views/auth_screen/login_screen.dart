import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/consts/social_icons.dart';
import 'package:myapp/views/auth_screen/signup_screen.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/common_widgets/applogowidget.dart';
import 'package:myapp/common_widgets/bgwidget.dart';
import 'package:myapp/common_widgets/text_fields.dart';

import '../../common_widgets/common_button.dart';
import '../home_screen/home.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

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
              "Log in to $appname".text.fontFamily(bold).size(22).white.make(),
              10.heightBox,
              Column(
                children: [
                  customtextfield(
                    hint: emailhint,
                    title: email,
                  ),
                  5.heightBox,
                  customtextfield(
                    hint: passwordhint,
                    title: password,
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
                      onPress: () {
                        Get.to(() => Home());
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
