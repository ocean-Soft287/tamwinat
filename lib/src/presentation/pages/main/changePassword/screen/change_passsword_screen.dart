import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/src/presentation/components/buttons/main_confirm_button.dart';
import 'package:sundaymart/src/presentation/components/custom_text_form_field.dart';
import 'package:sundaymart/src/presentation/pages/main/changePassword/controller/change_password_riverpod.dart';
import 'package:sundaymart/src/riverpod/gh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    final changePasswordController = ref.watch(getCahngePasswordApiProvider);
    changePasswordController.resetController();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          (appModel.activeLanguage.languageCode == 'ar')
              ? "تغيير كلمة السر"
              : 'change Password',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Form(
        key: changePasswordController.formKey,
        child: RPadding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                100.verticalSpace,
                CustomTextFormField(
                  controller: changePasswordController.oldpassWordController,
                  validator: (value) =>
                      changePasswordController.validatePasword(value,
                          isArabic:
                              (appModel.activeLanguage.languageCode == 'ar')),
                  hintText: (appModel.activeLanguage.languageCode == 'ar')
                      ? "كلمة السر القديمة"
                      : "old password",
                  icon: null,
                  eyes: true,
                  obscureText: true,
                  iconColor: Colors.black,
                ),
                20.verticalSpace,
                CustomTextFormField(
                  controller: changePasswordController.newPassWordController,
                  validator: (value) =>
                      changePasswordController.validatePasword(value,
                          isArabic:
                              (appModel.activeLanguage.languageCode == 'ar')),
                  hintText: (appModel.activeLanguage.languageCode == 'ar')
                      ? "كلمة السر الجديدة"
                      : "new password",
                  icon: null,
                  eyes: true,
                  obscureText: true,
                  iconColor: Colors.black,
                ),
                20.verticalSpace,
                CustomTextFormField(
                  controller:
                      changePasswordController.confirmNewPassWordController,
                  validator: (value) =>
                      changePasswordController.validateConfirmPasword(value,
                          isArabic:
                              (appModel.activeLanguage.languageCode == 'ar')),
                  hintText: (appModel.activeLanguage.languageCode == 'ar')
                      ? "تأكيد كلمة السر"
                      : "password confirmation",
                  icon: null,
                  eyes: true,
                  obscureText: true,
                  iconColor: Colors.black,
                ),
                50.verticalSpace,
                MainConfirmButton(
                    background: Colors.orange,
                    title: (appModel.activeLanguage.languageCode == 'ar')
                        ? "تغيير كلمة السر"
                        : "Change Password",
                    onTap: () {
                      changePasswordController.validateForm(context,
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
