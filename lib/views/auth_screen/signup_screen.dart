import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/constants/consts.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/common_widgets/applogowidget.dart';
import 'package:myapp/common_widgets/common_button.dart';
import 'package:myapp/common_widgets/text_fields.dart';
import 'package:myapp/common_widgets/bgwidget.dart';
// import 'package:velocity_x/velocity_x.dart';

class Signupscreen extends StatefulWidget {
  const Signupscreen({super.key});

  @override
  State<Signupscreen> createState() => _SignupscreenState();
}

class _SignupscreenState extends State<Signupscreen> {
  bool ischeck = false;
  @override
  Widget build(BuildContext context) {
    Get.put(AuthController());

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
                  customtextfield(
                    hint: namehint,
                    title: name,
                  ),
                  customtextfield(
                    hint: emailhint,
                    title: email,
                  ),
                  customtextfield(
                    hint: passwordhint,
                    title: password,
                  ),
                  customtextfield(
                    hint: passwordhint,
                    title: retypepassword,
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
                      onPress: () {
                        if (ischeck != true) {
                          VxToast.show(context,
                              msg: "Please agree to Terms & Conditions");
                        } else {
                          Get.back();
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
