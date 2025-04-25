import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/src/presentation/components/buttons/main_confirm_button.dart';
import 'package:sundaymart/src/presentation/components/custom_text_form_field.dart';
import 'package:sundaymart/src/presentation/pages/auth/forgetPassword/controller/forget_password_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/changePassword/controller/change_password_riverpod.dart';
import 'package:sundaymart/src/riverpod/gh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPasswordScreen extends ConsumerStatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ForgetPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    final forgetPasswordController = ref.watch(getForgetPasswordApiProvider);
    forgetPasswordController.resetControllerData();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          (appModel.activeLanguage.languageCode == 'ar')
              ? "نسيان كلمة السر"
              : 'Forget Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: forgetPasswordController.formKey,
        child: RPadding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                100.verticalSpace,
                CustomTextFormField(
                  controller: forgetPasswordController.phoneController,
                  hintText: (appModel.activeLanguage.languageCode == 'ar')
                      ? "رقم الهاتف"
                      : "Phone Number",
                  icon: Icons.phone,
                  iconColor: Colors.black,
                  validator: (value) =>
                      forgetPasswordController.validatePhoneNumber(value,
                          isArabic:
                              (appModel.activeLanguage.languageCode == 'ar')),
                ),
                30.verticalSpace,
                CustomTextFormField(
                  controller: forgetPasswordController.emailController,
                  validator: (value) => forgetPasswordController.validateEmail(
                      value,
                      isArabic: (appModel.activeLanguage.languageCode == 'ar')),
                  hintText: (appModel.activeLanguage.languageCode == 'ar')
                      ? "الإيميل"
                      : "email",
                  icon: Icons.email,
                  iconColor: Colors.black,
                ),
                70.verticalSpace,
                MainConfirmButton(
                    background: Colors.orange,
                    title: (appModel.activeLanguage.languageCode == 'ar')
                        ? "إرسال كلمة السر"
                        : "Change Password",
                    onTap: () {
                      forgetPasswordController.validateForm(context,
                          isArabic:
                              (appModel.activeLanguage.languageCode == 'ar'));
                    })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
