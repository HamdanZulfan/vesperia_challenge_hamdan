import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../constants/color.dart';
import '../../constants/icon.dart';
import '../../widgets/button_icon.dart';
import 'component/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title: const Text(
            "Sign In",
            style: TextStyle(
              fontSize: 16,
              color: gray900,
              fontWeight: FontWeight.w600,
            ),
          ),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                const SizedBox(height: 16),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    "Hi, Welcome Back",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                const SizedBox(
                  width: double.infinity,
                  child: Text(
                    'Sign in to your account.',
                    style: TextStyle(
                      fontSize: 16,
                      color: gray500,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Phone Number',
                                  style: TextStyle(color: gray900),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: red500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    TextFormField(
                      keyboardType: TextInputType.phone,
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray900),
                      cursorColor: primary,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide:
                              const BorderSide(color: gray200, width: 1.5),
                        ),
                        fillColor: white,
                        filled: true,
                        hintText: 'Phone Number',
                        prefixIcon: const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 14.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(width: 6),
                              Text(
                                '+62',
                                style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: gray900),
                              ),
                              SizedBox(width: 12),
                              SizedBox(
                                width: 1.5,
                                height: 48,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(color: gray100),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      controller: controller.etPhone,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        FilteringTextInputFormatter.deny(RegExp(r'^0')),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Nomor telepon tidak boleh kosong';
                        }
                        if (value.length < 8 || value.length > 16) {
                          return 'Panjang nomor telepon harus antara 8 dan 16 digit';
                        }
                        if (!RegExp(r'^[1-9][0-9]*$').hasMatch(value)) {
                          return 'Nomor telepon tidak valid';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: RichText(
                            text: const TextSpan(
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                              children: [
                                TextSpan(
                                  text: 'Password',
                                  style: TextStyle(color: gray900),
                                ),
                                TextSpan(
                                  text: ' *',
                                  style: TextStyle(color: red500),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ValueListenableBuilder<bool>(
                      valueListenable: controller.isObscure,
                      builder: (context, value, _) {
                        return TextFormField(
                          controller: controller.etPassword,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Kata sandi tidak boleh kosong';
                            } else if (value.length < 8) {
                              return 'Kata sandi harus minimal 8 karakter';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Color(0xffBDBDBD),
                              ),
                            ),
                            border: const OutlineInputBorder(),
                            hintText: 'Password',
                            fillColor: Colors.white,
                            filled: true,
                            prefixIcon: const Padding(
                              padding: EdgeInsets.all(14.0),
                              child: ImageIcon(
                                AssetImage(ic_password),
                              ), // icon is 48px widget.
                            ),
                            suffixIcon: IconButton(
                              splashRadius: 20,
                              onPressed: () => controller.isObscure.value =
                                  !controller.isObscure.value,
                              icon: Icon(
                                value ? Icons.visibility_off : Icons.visibility,
                              ),
                            ),
                          ),
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.text,
                          obscureText: value,
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                loginButton(_formKey),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton(GlobalKey<FormState> formKey) => SizedBox(
        height: 52,
        width: double.infinity,
        child: ButtonIcon(
          buttonColor: primary,
          textColor: white,
          textLabel: "Sign In",
          onClick: () {
            if (formKey.currentState?.validate() ?? false) {
              controller.doLogin();
            }
          },
        ),
      );
}
