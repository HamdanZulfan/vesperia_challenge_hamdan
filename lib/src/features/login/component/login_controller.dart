import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:entrance_test/src/repositories/user_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../../app/routes/route_name.dart';
import '../../../widgets/snackbar_widget.dart';

class LoginController extends GetxController {
  final UserRepository _userRepository;
  late ValueNotifier<bool> isObscure;

  LoginController({
    required UserRepository userRepository,
  }) : _userRepository = userRepository;

  final etPhone = TextEditingController();
  final etPassword = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    isObscure = ValueNotifier<bool>(true); // Inisialisasi isObscure di onInit
  }

  @override
  void onClose() {
    etPhone.dispose();
    etPassword.dispose();
    isObscure.dispose();
    super.onClose();
  }

  void doLogin() async {
    if (etPhone.text != '85173254399' || etPassword.text != '12345678') {
      SnackbarWidget.showFailedSnackbar('Email atau password salah');
      return;
    }
    await _userRepository.login();
    showSuccessDialog();
  }

  void showSuccessDialog() {
    AwesomeDialog(
      context: Get.context!,
      dialogType: DialogType.success,
      // animType: AnimType.BOTTOMSLIDE,
      title: 'Login Berhasil',
      desc: 'Anda telah berhasil login!',
      btnOkOnPress: () {
        Get.offAllNamed(RouteName.dashboard);
      },
    ).show();
  }
}
