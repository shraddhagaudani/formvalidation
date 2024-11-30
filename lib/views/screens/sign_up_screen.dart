import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../controllers/sign_up_controller.dart';
import '../../text_field_widget.dart';
import '../../validator.dart';
import 'login_screen.dart';



class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> with SingleTickerProviderStateMixin {
  final SignUpController controller = Get.put(SignUpController());
  // final ProfileController profileController = Get.find<ProfileController>();
  // late TabController tabController;
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _email = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusScope.of(context).unfocus();
      },
      child: Scaffold(



        // backgroundColor: GetColor().bgColor,
        body:
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // customHeight(7.h),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.off(() => const LoginScreen());
                  //   },
                  //   // child: SvgPicture.asset(
                  //   //   AppAsset.leftArrow,
                  //   //   height: 3.h,
                  //   //   width: 6.w,
                  //   //   colorFilter: ColorFilter.mode(GetColor().blackColor, BlendMode.srcIn),
                  //   // ),
                  // ),
                  Center(
                    child: Container(
                      height: 90,
                      width: 90,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        // borderRadius: circular28BorderRadius,
                      ),
                      // child: Image.asset(
                      //   // "assets/images/png/app_logo.png",
                      // ),
                    ),
                  ),
                  Center(child: Text('Sign Up', style: TextStyle().copyWith(fontSize: 26))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(10), boxShadow: [
                          BoxShadow(
                            // color: isDark.value ? Colors.transparent : greyColor,
                            blurRadius: 4.0,
                            offset: const Offset(0, 3),
                            spreadRadius: -1,
                          ),
                        ]),
                        child: Obx(() {
                          return Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (!controller.tabIndex.isTrue) {
                                    controller.tabIndex.value = !controller.tabIndex.value;
                                  }
                                  controller.serviceType.value = 0;
                                  debugPrint("${controller.serviceType.value}");
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: controller.tabIndex.isTrue ? Colors.black : Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 1),
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 9, vertical: 1),
                                        child: Text(
                                          "Customer",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: controller.tabIndex.isTrue ? FontWeight.w500 : FontWeight.w400,
                                            fontFamily: 'ReadexPro',
                                            foreground: Paint()
                                              ..shader = controller.tabIndex.isTrue
                                                  ? const LinearGradient(
                                                      colors: [
                                                        Color(0xFFA0A6FF),
                                                        Color(0xFF5A65FF),
                                                      ],
                                                    ).createShader(
                                                      const Rect.fromLTWH(30, 50, 90, 60),
                                                    )
                                                  : const LinearGradient(
                                                      colors: [Colors.grey, Colors.grey],
                                                    ).createShader(const Rect.fromLTWH(0, 0, 100, 60)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (!controller.tabIndex.isFalse) {
                                    controller.tabIndex.value = !controller.tabIndex.value;
                                    controller.serviceType.value = 1;
                                    debugPrint("${controller.serviceType.value}");
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: controller.tabIndex.isFalse ? Colors.black : Colors.transparent),
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 1),
                                    child: Container(
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.black),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 4.5, vertical: 1),
                                        child: Text("Service Provider",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: controller.tabIndex.isFalse ? FontWeight.w500 : FontWeight.w400,
                                              fontFamily: 'ReadexPro',
                                              foreground: Paint()
                                                ..shader = controller.tabIndex.isFalse
                                                    ? const LinearGradient(
                                                        colors: [Color(0xFFA0A6FF), Color(0xFF5A65FF)],
                                                      ).createShader(const Rect.fromLTWH(200, 180, 100, 60))
                                                    : const LinearGradient(
                                                        colors: [Colors.grey, Colors.grey],
                                                      ).createShader(const Rect.fromLTWH(0, 0, 100, 60)),
                                            )),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ],
                  ),
                   Expanded(
                     child: Container(
                       width: double.infinity,
                        height: double.infinity,
                        decoration: const BoxDecoration(),
                        child: SingleChildScrollView(
                          physics: const ClampingScrollPhysics(),
                          controller: controller.scrollController,
                          child: Form(
                            key: controller.formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text('Full Name*', ),
                                Obx(() {
                                  return MyTextField(
                                    key: controller.widgetKey[0],
                                    controller: controller.nameC,
                                    autoValidateMode: (controller.isAutoValidate.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                    textFieldType: controller.commonTextMessages.nameFormat,
                                    keyboardType: TextInputType.text,
                                    hintText: 'Enter your name',
                                    inputFormatters: [CapitalizeWordsFormatter()],
                                    hintTextStyle: TextStyle().copyWith(fontWeight: FontWeight.w300),
                                    validator: (value) {
                                      return controller.validateNameField(value);
                                    },
                                    textInputAction: TextInputAction.next,
                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
                                    focusBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
                                  );
                                }),
                                Text('Phone Number*', ),
                                Obx(() {
                                  return MyTextField(
                                    focusNode: _phoneNumberFocus,
                                    key: controller.widgetKey[1],
                                    controller: controller.mobileC,
                                    autoValidateMode: (controller.isAutoValidate.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                    keyboardType: TextInputType.number,
                                    textInputAction: TextInputAction.next,
                                    hintText: 'Enter your phone Number',
                                    errorText: (controller.errMsg.value.isNotEmpty && controller.errMsg.value.toString().toLowerCase().contains("phone")) ? controller.errMsg.value : null,
                                    hintTextStyle: TextStyle().copyWith(fontWeight: FontWeight.w300),
                                    validator: (value) {
                                      return phoneValidator(value);
                                    },
                                    onChanged: (p0) {
                                      controller.errMsg.value = '';
                                    },
                                    // inputFormatters: [LengthLimitingTextInputFormatter(10)],
                                    inputFormatters: [
                                      PhoneNumberInputFormatter(),
                                    ],
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: Colors.red),
                                    ),
                                    focusBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: Colors.black),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(color: Colors.black),
                                    ),
                                    textFieldType: AutofillHints.telephoneNumber,
                                  );
                                }),
                                Text('Email*', ),
                                Obx(() {
                                  return MyTextField(
                                    focusNode: _email,
                                    key: controller.widgetKey[2],
                                    controller: controller.emailC,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.next,
                                    hintText: 'Enter your email',
                                    errorText: (controller.errMsg.value.isNotEmpty && controller.errMsg.value.contains("Email")) ? controller.errMsg.value : null,
                                    autoValidateMode: (controller.isAutoValidate.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                    textFieldType: controller.commonTextMessages.emailFormat,
                                    hintTextStyle: TextStyle().copyWith(fontWeight: FontWeight.w300),
                                    validator: (value) {
                                      return validateEmailField(value);
                                    },
                                    onChanged: (p0) {
                                      controller.errMsg.value = '';
                                    },
                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
                                    focusBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
                                  );
                                }),
                                Text('Password*',),
                                Obx(() {
                                  return MyTextField(
                                    key: controller.widgetKey[3],
                                    controller: controller.passwordC,
                                    keyboardType: TextInputType.text,
                                    textInputAction: TextInputAction.done,
                                    hintText: 'Enter your password',
                                    hintTextStyle: TextStyle().copyWith(fontWeight: FontWeight.w300),
                                    autoValidateMode: (controller.isAutoValidate.value) ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
                                    textFieldType: controller.commonTextMessages.passFormat,
                                    obscureText: controller.isHide.value,
                                    validator: (value) {
                                      return controller.validatePasswordField(value);
                                    },
                                    suffixIcon: InkWell(
                                      onTap: controller.togglePass,
                                      child: Icon(
                                        controller.isHide.value ? Icons.visibility_off : Icons.remove_red_eye_outlined,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.red)),
                                    focusBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
                                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: const BorderSide(color: Colors.black)),
                                  );
                                }),
                                ElevatedButton(onPressed: ()async{
                                  await controller.onSignUpButtonPressed();
                                }, child: Text("Sign Up")),
                                // PrimaryTextButton(
                                //   height: 6.h,
                                //   title: "Sign Up",
                                //   onTap: () async {
                                //     await controller.onSignUpButtonPressed();
                                //     profileController.getServiceUserDetails();
                                //   },
                                // ),
                                Center(
                                  child: RichText(
                                    text: TextSpan(
                                      text: "Already have a account? ",
                                   
                                      children: [
                                        TextSpan(
                                          text: " Sign In",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'ReadexPro',
                                              foreground: Paint()
                                                ..shader = const LinearGradient(
                                                  colors: [Color(0xFFA0A6FF), Color(0xFF5A65FF)],
                                                ).createShader(
                                                  const Rect.fromLTWH(0.0, 0.0, 250.0, 60.0),
                                                )),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              controller.onSignInButtonTap();
                                            },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                   ),

                ],
              ),
            ),
        ),

      
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller.errMsg.value = '';
  }
}
