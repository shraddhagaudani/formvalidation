// ignore_for_file: deprecated_member_use

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:formvalidation/common_text_messages.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final CommonTextMessages commonTextMessages = CommonTextMessages();

  TextEditingController phoneNumberC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  RxBool isAutoValidate = false.obs;
  RxBool isHide = true.obs;
  RxBool isauth = true.obs;
  RxBool switchValue = false.obs;
  RxBool serviceProviderSwitchValue = false.obs;
  RxString errMsg = ''.obs;
  final focusNodePhoneNumber = FocusNode();

  //pass toggle
  togglePass() {
    isHide.value = !isHide.value;
  }

  String? validatePasswordField(String? value) {
    RegExp passwordValid = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

    if (value!.isEmpty) {
      return "Please enter your password".tr;
    } else if (!passwordValid.hasMatch(value)) {
      return "Your password should be at least 8 characters long, and contain at least one uppercase letter, one lowercase letter, one number, and one special character (e.g., ! @ # ?)".tr;
    }
    return null;
  }

  //check validation for field value
  String? validateString(String value, String type) {
    if (value.isEmpty) {
      return "$type is required";
    }
    return null;
  }

  //on SignIn Button tap
  Future<void> onLogInButtonPressed() async {
    isAutoValidate.value = true;
    FocusScopeNode currentFocus = FocusScope.of(Get.context!);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
    if (formKey.currentState!.validate()) {
      clearVariable();
      // Call the loginUser() method to initiate the login process

    }
  }


  //clear filed data
  void clearVariable() {
    isAutoValidate.value = false;
    phoneNumberC.clear();
    passwordC.clear();
    update();
  }


  //phone format set
  String? phoneFormat(String value) {
    return value.replaceAll(")", "").replaceAll("(", "").replaceAll("-", "").replaceAll(" ", "");
  }
}
