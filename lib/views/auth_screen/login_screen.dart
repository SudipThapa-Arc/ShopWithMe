import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:myapp/consts/consts.dart';
import 'package:myapp/controllers/auth_controller.dart';
import 'package:myapp/widgets_common/applogowidget.dart';
import 'package:myapp/widgets_common/bgwidget.dart';
import 'package:myapp/widgets_common/text_fields.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());

    return bgWidget(
        child: Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.screenHeight * 0.1),
            applogowidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).size(22).white.make(),
            10.heightBox,
            Column(
              children: [
                customtextfield(
                    hint: emailhint,
                    title: email,
                    controller: controller.emailController.value),
                customtextfield(
                    hint: passwordhint,
                    title: password,
                    controller: controller.passwordController.value),
              ],
            )
                .box
                .white
                .rounded
                .padding(EdgeInsets.all(16))
                .width(context.screenWidth - 100)
                .height(context.screenHeight * 0.5)
                .make(),
            ElevatedButton(
              onPressed: () {
                controller.loginUser();
              },
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    ));
  }
}
