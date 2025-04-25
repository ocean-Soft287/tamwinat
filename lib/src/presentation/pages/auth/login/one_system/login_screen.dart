import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/src/presentation/pages/auth/forgetPassword/screnn/forget_password_screen.dart';
import 'package:sundaymart/src/presentation/pages/auth/signup/one_system/register_riverpod.dart';

import '../../../../../../main.dart';
import '../../../../../riverpod/gh.dart';
import '../../../../components/components.dart';
import '../../../../theme/app_colors.dart';
import '../../../main/shop/cart/checkout/oneSystem/widget/text_form_field_onsystem.dart';
import '../../signup/one_system/register_screen.dart';

import 'CashHelper.dart';
import 'login_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  final bool isCanPop;
  const LoginScreen({super.key, this.isCanPop = true});
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _passwordVisible = false;
  var keyFormCheckOutOnSystem = GlobalKey<FormState>();
  var customPhoneControllerCheckOutOnSystem = TextEditingController();
  var passwordControllerCheckOutOnSystem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(appModelProvider);
    return KeyboardDismisser(
      child: Scaffold(
          backgroundColor: AppColors.mainBackground(),
          extendBody: true,
          appBar: CommonAppBar(
            title: (lang.activeLanguage.languageCode == 'ar')
                ? 'تسجيل دخول'
                : 'Login', // context.popRoute
            onLeadingPressed: widget.isCanPop
                ? context.popRoute
                : () => debugPrint("Can not pop"),
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                    key: keyFormCheckOutOnSystem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        50.verticalSpace,
                        MyStyledTextField(
                          maxLength: 8,
                          keyboardType: TextInputType.phone,
                          label: (lang.activeLanguage.languageCode == 'ar')
                              ? 'رقم الموبيل'
                              : 'Mobial Number',
                          hintText: (lang.activeLanguage.languageCode == 'ar')
                              ? 'رقم الموبيل'
                              : 'Mobial Number',
                          controller: customPhoneControllerCheckOutOnSystem,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return (lang.activeLanguage.languageCode == 'ar')
                                  ? 'هذا الحقل مطلوب'
                                  : 'This field is required';
                            } else if (value.length != 8 ||
                                !(value.startsWith('4') ||
                                    value.startsWith('5') ||
                                    value.startsWith('6') ||
                                    value.startsWith('9'))) {
                              return (lang.activeLanguage.languageCode == 'ar')
                                  ? '  رقم الهاتف غير صحيح او الارقام لا تحتوي علي ارقام انجليزية يرجي التأكد   ا'
                                  : 'The Mobile Number not correct please check the mobile number';
                            } else {
                              return null;
                            }
                          },
                        ),
                        13.verticalSpace,
                        MyStyledTextField(
                          obscureText: !_passwordVisible,
                          suffixIconData: IconButton(
                            icon: Icon(
                              color: Colors.orange,
                              _passwordVisible
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                            onPressed: () {
                              setState(() {
                                _passwordVisible = !_passwordVisible;
                              });
                            },
                          ),
                          maxLength: 9999,
                          label: (lang.activeLanguage.languageCode == 'ar')
                              ? 'كلمه المرور'
                              : 'Password',
                          hintText: (lang.activeLanguage.languageCode == 'ar')
                              ? 'كلمه المرور'
                              : 'Password',
                          controller: passwordControllerCheckOutOnSystem,
                          keyboardType: TextInputType.text,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return (lang.activeLanguage.languageCode == 'ar')
                                  ? 'هذا الحقل مطلوب'
                                  : 'Required field';
                            }

                            return null;
                          },
                        ),
                        RPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgetPasswordScreen()),
                              );
                            },
                            child: Text(
                              (lang.activeLanguage.languageCode == 'ar')
                                  ? "نسيت كلمة السر"
                                  : "Forget Password",
                              style: GoogleFonts.inter(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                letterSpacing: -0.4,
                                color: Colors.orange,
                              ),
                            ),
                          ),
                        ),
                        30.verticalSpace,
                        Consumer(
                          builder: (context, ref, child) {
                            final loginProvide = ref.watch(loginProviderr);

                            return MainConfirmButton(
                                background: Colors.orange,
                                title:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'تسجيل دخول'
                                        : 'Login',
                                onTap: () {
                                  if (keyFormCheckOutOnSystem.currentState!
                                      .validate()) {
                                    loginProvide.LoginUser(
                                        isArabic:
                                            (lang.activeLanguage.languageCode ==
                                                'ar'),
                                        context: context,
                                        CustomPhonee:
                                            customPhoneControllerCheckOutOnSystem
                                                .text,

                                        PassWord:
                                            passwordControllerCheckOutOnSystem
                                                .text);


                                      UserPhoneAll=customPhoneControllerCheckOutOnSystem
                                          .text;
                                      print('USER PHONE ALLL------ ${UserPhoneAll}');

                                  }
                                });
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterScreen()),
                                );
                              },
                              child: Text(
                                  (lang.activeLanguage.languageCode == 'ar')
                                      ? 'تسجيل حساب جديد'
                                      : 'Register',
                                  style: TextStyle(color: Colors.orange)),
                            ),
                          ],
                        ),
                      ],
                    ))),
          )),
    );
  }
}
