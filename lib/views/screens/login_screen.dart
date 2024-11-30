import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:formvalidation/controllers/login_controller.dart';
import 'package:formvalidation/validator.dart';
import 'package:get/get.dart';

import '../../text_field_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = Get.put(LoginController());
  final FocusNode _phoneNumberFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  _SupportState _supportState = _SupportState.unknown;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        return FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 90,
                width: 90,
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(),

              ),
            ),
            Center(
                child: Text(
              'Sign In',
            )),
            Expanded(
              child: Container(
                height: double.infinity,
                decoration: const BoxDecoration(),
                child: SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  // padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 2.h),
                  child: Form(
                    key: controller.formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Text(
                            'Phone number*',
                          ),

                          Obx(() {
                            return MyTextField(
                              focusNode: _phoneNumberFocus,
                              autoValidateMode: (controller.isAutoValidate.value)
                                  ? AutovalidateMode.onUserInteraction
                                  : AutovalidateMode.disabled,
                              controller: controller.phoneNumberC,
                              keyboardType: TextInputType.number,
                              hintText: 'Enter your phone number',
                              // inputFormatters: [LengthLimitingTextInputFormatter(10)],
                              inputFormatters: [
                                PhoneNumberInputFormatter(),
                              ],
                              validator: (value) {
                                return phoneValidator(value);
                              },
                              errorText: (controller.errMsg.value.isNotEmpty &&
                                      (controller.errMsg.value.toLowerCase().contains("phone") ||
                                          controller.errMsg.value
                                              .toLowerCase()
                                              .contains("account")))
                                  ? controller.errMsg.value
                                  : null,
                              onChanged: (p0) {
                                controller.errMsg.value = '';
                              },
                              // hintTextStyle: AppTextStyle().greyTextFontSize11.copyWith(fontWeight: FontWeight.w300),
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              textFieldType: controller.commonTextMessages.numberFormat,
                            );
                          }),

                          Text(
                            'Password*',
                            style: const TextStyle().copyWith(fontSize: 14),
                          ),

                          Obx(
                            () {
                              return MyTextField(
                                focusNode: _passwordFocus,
                                autoValidateMode: (controller.isAutoValidate.value)
                                    ? AutovalidateMode.onUserInteraction
                                    : AutovalidateMode.disabled,
                                controller: controller.passwordC,
                                obscureText: controller.isHide.value,
                                textInputAction: TextInputAction.done,
                                errorText: (controller.errMsg.value.isNotEmpty &&
                                        controller.errMsg.value.toLowerCase().contains("password"))
                                    ? controller.errMsg.value
                                    : null,
                                textFieldType: controller.commonTextMessages.passFormat,
                                hintText: 'Enter your password',
                                validator: (value) {
                                  return controller.validatePasswordField(value);
                                },
                                onChanged: (p0) {
                                  controller.errMsg.value = '';
                                },
                                hintTextStyle:
                                    const TextStyle().copyWith(fontWeight: FontWeight.w300),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                focusBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: InkWell(
                                  onTap: controller.togglePass,
                                  child: Icon(
                                    controller.isHide.value
                                        ? Icons.visibility_off
                                        : Icons.remove_red_eye_outlined,
                                  ),
                                ),
                              );
                            },
                          ),
                          OutlinedButton(
                              onPressed: () async {
                                await controller.onLogInButtonPressed();
                              },
                              child: Text("Sign In")),
                          // PrimaryTextButton(
                          //   height: 50,
                          //   title: "Sign In",
                          //   onTap: () async {
                          //     await controller.onLogInButtonPressed();
                          //   },
                          // ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                // controller.showForgotPasswordBottomSheet();
                              },
                              child: const Text(
                                "Forgot password?",
                                style: TextStyle(
                                  fontFamily: 'ReadexPro',
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  height: 10,
                                  width: double.infinity,
                                  decoration: const BoxDecoration(color: Colors.grey),
                                ),
                              ),
                              Text('OR', style: TextStyle().copyWith(fontSize: 12)),
                              Expanded(
                                child: Container(
                                  width: double.infinity,
                                  decoration: const BoxDecoration(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),

                          Center(
                            child: RichText(
                              text: TextSpan(
                                text: "Create a new Account? ",
                                style: TextStyle().copyWith(fontSize: 14),
                                children: [
                                  TextSpan(
                                    text: " Sign up",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'ReadexPro',
                                        foreground: Paint()
                                          ..shader = const LinearGradient(
                                            colors: [Color(0xFFA0A6FF), Color(0xFF5A65FF)],
                                          ).createShader(
                                            const Rect.fromLTWH(200, 180, 100, 60),
                                          )),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                      Get.toNamed('/signup_screen');
                                        // controller.onSignUpButtonTap();
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
            ),
          ],
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

enum _SupportState {
  unknown,
  supported,
  unsupported,
}
