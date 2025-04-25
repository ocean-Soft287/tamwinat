import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/core/constants/icon_broken.dart';
import 'package:sundaymart/src/core/utils/dialog_helper.dart';
import 'package:sundaymart/src/presentation/components/buttons/main_confirm_button.dart';
import 'package:sundaymart/src/presentation/components/custom_text_form_field.dart';
import 'package:sundaymart/src/presentation/pages/main/changePassword/controller/change_password_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/updateAccount/controller/update_account_riverpod.dart';
import 'package:sundaymart/src/riverpod/gh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UpdateAccountScreen extends ConsumerStatefulWidget {
  const UpdateAccountScreen({super.key});

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<UpdateAccountScreen> {
  @override
  void initState() {
    super.initState();
    final getUpdateAccountApiProviderController =
        ref.read(getUpdateAccountApiProvider);
    getUpdateAccountApiProviderController.getFromApiData(context);

  }

  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            (appModel.activeLanguage.languageCode == 'ar')
                ? "تعديل معلومات الحساب"
                : 'Edit account information',
            style: const TextStyle(color: Colors.black),
          ),
        ),
        body: Consumer(
          builder: (context, ref, child) {
            final getUpdateAccountApiProviderController =
                ref.watch(getUpdateAccountApiProvider);
            return   !getUpdateAccountApiProviderController
                    .isLoadUpdateAccountPage
                ? Center(
                    child: Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? "جاري التحميل ...."
                          : 'Loading....',
                    ),
                  )
                : Form(
                    key: getUpdateAccountApiProviderController.formKey,
                    child: RPadding(
                      padding: REdgeInsets.symmetric(horizontal: 16),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            100.verticalSpace,

                            CustomTextFormField(
                              controller: getUpdateAccountApiProviderController
                                  .phoneController,
                              hintText:
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "رقم الهاتف"
                                      : "Phone Number",
                              icon: Icons.phone,
                              iconColor: Colors.black,
                              readOnly: true,
                            ),
                            20.verticalSpace,
                            CustomTextFormField(
                              controller: getUpdateAccountApiProviderController
                                  .firstNameController,
                              validator: (value) =>
                                  getUpdateAccountApiProviderController
                                      .validateField(value,
                                          isArabic: (appModel.activeLanguage
                                                  .languageCode ==
                                              'ar')),
                              hintText:
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "الإسم الأول"
                                      : "First Name",
                              iconColor: Colors.black,
                              icon: Icons.person,
                            ),
                            20.verticalSpace,
                            CustomTextFormField(
                              controller: getUpdateAccountApiProviderController
                                  .lastNameController,
                              validator: (value) =>
                                  getUpdateAccountApiProviderController
                                      .validateField(value,
                                          isArabic: (appModel.activeLanguage
                                                  .languageCode ==
                                              'ar')),
                              hintText:
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "الإسم الاخير"
                                      : "Last Name",
                              iconColor: Colors.black,
                              icon: Icons.person,
                            ),
                            20.verticalSpace,
                            CustomTextFormField(
                              controller: getUpdateAccountApiProviderController
                                  .emailController,
                              validator: (value) =>
                                  getUpdateAccountApiProviderController
                                      .validateEmail(value,
                                          isArabic: (appModel.activeLanguage
                                                  .languageCode ==
                                              'ar')),
                              hintText:
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "الإيميل"
                                      : "email",
                              icon: Icons.email,
                              iconColor: Colors.black,
                            ),
                            50.verticalSpace,
                            MainConfirmButton(
                                background: Colors.orange,
                                title: (appModel.activeLanguage.languageCode ==
                                        'ar')
                                    ? "تعديل معلومات الحساب"
                                    : 'Edit Account Information',
                                onTap: () {
                                  getUpdateAccountApiProviderController
                                      .validateForm(context,
                                          isArabic: (appModel.activeLanguage
                                                  .languageCode ==
                                              'ar'));
                                })
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ));
  }
}
