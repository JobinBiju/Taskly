import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:taskly/app/global_widgets/input_text_feild.dart';
import 'package:taskly/app/global_widgets/proceed_button.dart';
import 'package:taskly/app/modules/home/views/home_view.dart';
import 'package:taskly/app/modules/welcome/controllers/welcome_controller.dart';

class LoginView extends GetView<WelcomeController> {
  final WelcomeController controller = Get.put(WelcomeController());
  @override
  Widget build(BuildContext context) {
    Size size = Get.size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          width: size.width,
          padding: EdgeInsets.only(
              top: size.height * 0.12,
              left: size.width * 0.15,
              right: size.width * 0.15),
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: size.width * 0.35,
                width: size.width * 0.35,
                padding: EdgeInsets.symmetric(vertical: size.height * 0.03),
                decoration: BoxDecoration(
                  color: Color(0xffeeeeee),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: SvgPicture.asset(
                  'assets/icons/taskly_logo.svg',
                ),
              ),
              SizedBox(height: size.height * 0.08),
              InputTextFormField(
                hintText: 'First name',
                controller: controller.firstNameController,
              ),
              SizedBox(height: size.height * 0.03),
              InputTextFormField(
                hintText: 'Last name (Optional)',
                controller: controller.lastNameController,
              ),
              SizedBox(height: size.height * 0.03),
              InputTextFormField(
                hintText: 'Email',
                controller: controller.emailController,
              ),
              SizedBox(height: size.height * 0.03),
              GetBuilder<WelcomeController>(
                init: controller,
                builder: (_) => ToggleButtons(
                  children: [
                    Image(image: AssetImage('assets/images/male-user-1.png')),
                    Image(image: AssetImage('assets/images/female-user-1.png')),
                  ],
                  borderRadius: BorderRadius.circular(15),
                  color: Color(0xffeeeeee),
                  renderBorder: false,
                  fillColor: Color(0xffffc045).withOpacity(0.68),
                  splashColor: Color(0xffffc045),
                  constraints: BoxConstraints.expand(
                      height: size.width * 0.14, width: size.width * 0.14),
                  isSelected: controller.selectedToggleGender,
                  onPressed: controller.onToggledGender,
                ),
              ),
              SizedBox(height: size.height * 0.07),
              ProceedButton(
                size: size,
                onPress: () {
                  Get.offAll(() => HomeView());
                },
                title: 'Register',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
