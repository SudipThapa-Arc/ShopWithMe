import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/common_widgets/applogowidget.dart';
import 'package:myapp/common_widgets/common_button.dart';
import 'package:myapp/common_widgets/text_fields.dart';
import 'package:myapp/common_widgets/bgwidget.dart';
// import 'package:velocity_x/velocity_x.dart';

class Signupscreen extends StatelessWidget {
  const Signupscreen({super.key});

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
                    title: retypepassword,
                  ),
                  Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () {},
                          child: forgotpassword.text.color(redColor).make())),
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
                              text: TextSpan(children: [
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
                      color: controller.isCheck.value ? redColor : lightGrey,
                      title: signup,
                      textColor: whiteColor,
                      onPress: () {
                        if (controller.isCheck.value != true) {
                          VxToast.show(context,
                              msg: "Please agree to Terms & Conditions");
                        } else {
                          Get.back();
                        }
                      }).box.width(context.screenWidth - 50).make(),
                  10.heightBox,
                  RichText(
                      text: TextSpan(children: [
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
