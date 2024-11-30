import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../common_text_messages.dart';
import '../views/screens/login_screen.dart';
import 'login_controller.dart';


class SignUpController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final CommonTextMessages commonTextMessages = CommonTextMessages();
  TextEditingController nameC = TextEditingController();
  TextEditingController mobileC = TextEditingController();
  TextEditingController emailC = TextEditingController();
  TextEditingController passwordC = TextEditingController();
  LoginController loginController = Get.find<LoginController>();
  final scrollController = ScrollController();
  final widgetKey = List.generate(4, (index) => GlobalKey());
  RxBool tabIndex = true.obs;
  RxBool isAutoValidate = false.obs;
  RxBool isHide = true.obs;
  RxInt serviceType = 0.obs;
  RxString errMsg = ''.obs;
  final focusNodePhoneNumber = FocusNode();
  // late KeyboardActionsConfig config;

  //clear filed value
  void clearVariable() {
    isAutoValidate.value = false;
    nameC.clear();
    emailC.clear();
    mobileC.clear();
    passwordC.clear();
    update();
  }

  togglePass() {
    isHide.value = !isHide.value;
  }

  //on sign up button tap
  Future<void> onSignUpButtonPressed() async {
    isAutoValidate.value = true;
    FocusScopeNode currentFocus = FocusScope.of(Get.context!);

    if (formKey.currentState!.validate()) {
      currentFocus.unfocus();
      clearVariable();
      // signUpUser();
    } else {
      validatescroll();
    }
  }

  void validatescroll() {
    if (nameC.text.isEmpty) {
      _scrollToTextField(widgetKey[0]);
    } else if (mobileC.text.isEmpty) {
      _scrollToTextField(widgetKey[1]);
    } else if (emailC.text.isEmpty) {
      _scrollToTextField(widgetKey[2]);
    } else if (passwordC.text.isEmpty) {
      _scrollToTextField(widgetKey[3]);
    }
  }

  void _scrollToTextField(GlobalKey key) {
    final RenderBox renderBox = key.currentContext!.findRenderObject() as RenderBox;
    final position = renderBox.localToGlobal(Offset.zero);
    final yOffset = position.dy + scrollController.offset - (Get.height / 2);
    scrollController.animateTo(
      yOffset,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeInOut,
    );
  }

  //on sign In button tap
  onSignInButtonTap() {
    clearVariable();
    Get.off(() => const LoginScreen());
  }

  //check validation for name field value
  String? validateNameField(String? value) {
    if (value!.isEmpty) {
      return "Please enter your full name".tr;
    } else if (value.length < 3) {
      return "Name must be 3 character long".tr;
    }
    return null;
  }

  //check validation for password field value
  String? validatePasswordField(String? value) {
    RegExp passwordValid = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}$');

    if (value!.isEmpty) {
      return "Please enter your password".tr;
    } else if (!passwordValid.hasMatch(value)) {
      return "Your password should be at least 8 characters long, and contain at least one uppercase letter, one lowercase letter, one number, and one special character (e.g., ! @ # ?)".tr;
    }
    return null;
  }

  //check validation for mobile number field value
  String? validateMobileField(String? value) {
    if (value!.isEmpty) {
      return "Please enter your phone number";
    }
    return null;
  }

  //sign up method
  // Future<void> signUpUser() async {
  //   // Show loading indicator
  //   Loader.show();
  //   Map<String, dynamic> data = <String, dynamic>{"fullName": nameC.text, "userType": serviceType.value == 0 ? "Customer" : "ServiceProvider", "phoneNumber": loginController.phoneFormat(mobileC.text), "email": emailC.text, "password": passwordC.text};
  //
  //   debugPrint("register data :$data");
  //   var response = await networkDioHttp.postRequest(
  //     url: ApiAppConstants.apiEndPoint + ApiAppConstants.register,
  //     isHeader: false,
  //     isBody: true,
  //     name: "SignupOtpVerification",
  //     bodyData: data,
  //   );
  //   // Hide loading indicator after request is sent
  //   Loader.hide();
  //   debugPrint(response?.statusCode.toString());
  //   // Process response
  //   if (response != null) {
  //     RegisterModal registerModal = RegisterModal.fromJson(response.data);
  //     if (registerModal.status == 201) {
  //       // CustomSnackBar.showGetXSnackBar(toastType: ToastType.success, message: registerModal.message ?? "");
  //       dataStorage.write(AppStrings.number, registerModal.data?.phoneNumber);
  //       dataStorage.write(AppStrings.serviceType, registerModal.data?.userType);
  //       dataStorage.write(AppStrings.userole, registerModal.data?.userType);
  //       dataStorage.write(AppStrings.oldPass, passwordC.text);
  //       clearVariable();
  //       debugPrint("${registerModal.data?.phoneNumber}");
  //       Get.to(() => VerificationPhoneOtpScreen(otp: registerModal.data?.verificationCode, phoneNumber: registerModal.data?.phoneNumber, userType: registerModal.data?.userType));
  //       errMsg.value = '';
  //       dataStorage.remove(AppStrings.isNotification);
  //       update();
  //     } else {
  //       errMsg.value = registerModal.error;
  //       // CustomSnackBar.showGetXSnackBar(toastType: ToastType.error, message: registerModal.error ?? "");
  //       update();
  //     }
  //   }
  // }
}
