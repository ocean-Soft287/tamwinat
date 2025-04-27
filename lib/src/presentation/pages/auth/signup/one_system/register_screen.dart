import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymart/src/presentation/pages/auth/chooseLocation/controller/choose_location_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/auth/chooseLocation/screen/choose_location.dart';
import 'package:sundaymart/src/presentation/pages/auth/signup/one_system/register_riverpod.dart';

import '../../../../../riverpod/gh.dart';
import '../../../../components/components.dart';
import '../../../../theme/app_colors.dart';
import '../../../main/shop/cart/checkout/oneSystem/Controller/checkout_riverpod.dart';
import '../../../main/shop/cart/checkout/oneSystem/widget/text_form_field_onsystem.dart';
import '../../login/one_system/login_riverpod.dart';
import '../../login/one_system/login_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  bool agreedToTerms = false;
  var floorControllerCheckOutOnSystem = TextEditingController();
  var blockNumberControllerCheckOutOnSystem = TextEditingController();
  var nameControllerCheckOutOnSystem = TextEditingController();
  var keyFormCheckOutOnSystem = GlobalKey<FormState>();
  var mobileNumberControllerCheckOutOnSystem = TextEditingController();
  var emailControllerCheckOutOnSystem = TextEditingController();
  var lastNameControllerCheckOutOnSystem = TextEditingController();
  var passwordControllerCheckOutOnSystem = TextEditingController();
  var regionNameControllerCheckOutOnSystem = TextEditingController();
  var districtNameControllerCheckOutOnSystem = TextEditingController();
  var streetControllerCheckOutOnSystem = TextEditingController();
  var houseControllerCheckOutOnSystem = TextEditingController();
  var gadaNumberControllerCheckOutOnSystem = TextEditingController();
  var apartmentNumberControllerCheckOutOnSystem = TextEditingController();
  var addressNotsControllerCheckOutOnSystem = TextEditingController();
  Map<String, dynamic>? selectedDistrict;
  Map<String, dynamic>?selectedGovernorate;
  String? ValueselectedDistrict = 'اختار المنطقه';
  bool _passwordVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    ref.read(locationProvider).resetAdress();
  }

  @override
  Widget build(BuildContext context) {
    final locationController = ref.read(locationProvider);
    final lang = ref.watch(appModelProvider);
    return KeyboardDismisser(
      child: Scaffold(
          backgroundColor: AppColors.mainBackground(),
          extendBody: true,
          appBar: CommonAppBar(
            title: (lang.activeLanguage.languageCode == 'ar')
                ? 'تسجيل حساب جديد'
                : 'Register a new account',
            onLeadingPressed: context.popRoute,
          ),
          body: SingleChildScrollView(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                    key: keyFormCheckOutOnSystem,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        5.verticalSpace,
                        MyStyledTextField(
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          label: (lang.activeLanguage.languageCode == 'ar')
                              ? 'الاسم الاول'
                              : 'Frist Name',
                          hintText: (lang.activeLanguage.languageCode == 'ar')
                              ? 'الاسم الاول'
                              : 'Frist Name',
                          suffixIconData: const Icon(
                            Icons.person,
                          ),
                          controller: nameControllerCheckOutOnSystem,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return (lang.activeLanguage.languageCode == 'ar')
                                  ? 'هذا الحقل مطلوب'
                                  : 'Required field';
                            }
                            return null;
                          },
                        ),
                        13.verticalSpace,
                        MyStyledTextField(
                          maxLength: 50,
                          keyboardType: TextInputType.text,
                          label: (lang.activeLanguage.languageCode == 'ar')
                              ? 'الاسم الاخير '
                              : 'Last Name',
                          hintText: (lang.activeLanguage.languageCode == 'ar')
                              ? 'الاسم الاخير '
                              : 'Mobile Number',

                          controller: lastNameControllerCheckOutOnSystem,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty||value.length<8) {
                          //     return (lang.activeLanguage.languageCode == 'ar')? 'هذا الحقل مطلوب':'Required field Please enter at least 8 digits.';
                          //   }
                          //   return null;
                          // },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return (lang.activeLanguage.languageCode == 'ar')
                                  ? 'هذا الحقل مطلوب'
                                  : 'Required field';
                            }
                            return null;
                          },
                        ),
                        13.verticalSpace,

                        MyStyledTextField(
                          maxLength: 50,
                          keyboardType: TextInputType.emailAddress,
                          label: (lang.activeLanguage.languageCode == 'ar')
                              ? 'البريد الالكترونى'
                              : 'Email address',
                          hintText: (lang.activeLanguage.languageCode == 'ar')
                              ? 'البريد الالكترونى '
                              : 'Email ',
                          suffixIconData: const Icon(
                            Icons.email,
                          ),
                          controller: emailControllerCheckOutOnSystem,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return (lang.activeLanguage.languageCode == 'ar')
                                  ? 'هذا الحقل مطلوب'
                                  : 'This field is required';
                            } else if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
                                .hasMatch(value)) {
                              return (lang.activeLanguage.languageCode == 'ar')
                                  ? 'البريد الالكتروني غير صحيح يرجي التأكد'
                                  : 'Email not correct, please check it';
                            } else {
                              return null;
                            }
                          },
                        ),
                        13.verticalSpace,

                        MyStyledTextField(
                          maxLength: 8,
                          keyboardType: TextInputType.phone,
                          label: (lang.activeLanguage.languageCode == 'ar')
                              ? 'رقم الموبيل'
                              : 'Mobile Number',
                          hintText: (lang.activeLanguage.languageCode == 'ar')
                              ? 'رقم الموبيل'
                              : 'Mobile Number',
                          suffixIconData: Icon(Icons.call),
                          controller: mobileNumberControllerCheckOutOnSystem,
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
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return (lang.activeLanguage.languageCode == 'ar')
                                  ? 'هذا الحقل مطلوب'
                                  : 'Required field';
                            }
                            return null;
                          },
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
                              ? 'كلمه المرور (يجب ان لاتحتوي علي ارقام عربية)'
                              : 'Password',
                          controller: passwordControllerCheckOutOnSystem,
                          keyboardType: TextInputType.text,
                        ),
                        13.verticalSpace,
                        // MyStyledTextField(
                        //
                        //   maxLength:50,
                        //   label:(lang.activeLanguage.languageCode == 'ar')?'ااسم المنطقه':'Region Name' ,
                        //   hintText: (lang.activeLanguage.languageCode == 'ar')?'المنطقه':'Region' ,
                        //
                        //   controller: regionNameControllerCheckOutOnSystem,
                        //
                        //   keyboardType: TextInputType.text,
                        // ),

                        // Text(
                        //   (lang.activeLanguage.languageCode == 'ar')?
                        //   'المحافظه':'Governorate',
                        //
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.w500,
                        //     fontSize: 14.sp,
                        //     fontFamily: 'Monadi',
                        //     color: AppColors.black,
                        //   ),
                        //
                        // ),
                        // 5.verticalSpace,
                        // Consumer(builder:(context,ref ,child)
                        // {
                        //   final listGovernorate = ref.watch(getDataGovernoratesFromApiProviderr);
                        //   DistrictName ??= listGovernorate.dataGovernorates.first;
                        //
                        //   return
                        //     Container(
                        //       padding: EdgeInsets.all(16.0),
                        //       decoration: BoxDecoration(
                        //         color: Colors.white,
                        //
                        //         borderRadius: BorderRadius.circular(25.0),
                        //       ),
                        //       child: DropdownButton<Map<String, dynamic>>(
                        //         isExpanded: true,
                        //         value: DistrictName,
                        //         onChanged: (newValue) {
                        //           setState(() {
                        //             DistrictName = newValue;
                        //             print(DistrictName);
                        //           });
                        //         },
                        //         items: listGovernorate.dataGovernorates.map((district) {
                        //           return DropdownMenuItem<Map<String, dynamic>>(
                        //             value: district,
                        //
                        //             child: Center(
                        //               child: Text(
                        //                 (lang.activeLanguage.languageCode == 'ar')?
                        //                 district["GovernorateName"]: district["GovernorateEName"],
                        //
                        //                 style: TextStyle(
                        //                   fontWeight: FontWeight.w500,
                        //                   fontSize: 14.sp,
                        //                   fontFamily: 'Monadi',
                        //                   color: AppColors.black,
                        //                 ),
                        //               ),
                        //             ),
                        //           );
                        //         }).toList(),
                        //       ),
                        //     );
                        //
                        // }),
                        5.verticalSpace,
                        Text(
                          (lang.activeLanguage.languageCode == 'ar') ? 'المحافظة' : 'Governorate',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            fontFamily: 'Monadi',
                            color: AppColors.black,
                          ),
                        ),
                        5.verticalSpace,
                        Consumer(builder: (context, ref, child) {
                          final listGovernorates = ref.watch(getDataFromApiProviderr);

                          if (listGovernorates.governoratesList == null || listGovernorates.governoratesList.isEmpty) {
                            return Text(
                              (lang.activeLanguage.languageCode == 'ar')
                                  ? 'لا توجد بيانات للعرض'
                                  : 'No data available',
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                                fontFamily: 'Monadi',
                                color: AppColors.black,
                              ),
                            );
                          }


                          //selectedGovernorate ??= listGovernorates.governoratesList.first;
                         // listGovernorates.getDataListAddress(governorateId: selectedGovernorate!['GovernorateID']);
                          return Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: DropdownButton<Map<String, dynamic>>(
                              isExpanded: true,
                              value: selectedGovernorate,
                              onChanged: (newValue) {
                                setState(() {
                                  selectedGovernorate = newValue;
                                  selectedDistrict = null; // إعادة التعيين عند تغيير المحافظة
                                });
                                print(selectedGovernorate);
                                listGovernorates.getDataListAddress(governorateId: selectedGovernorate!['GovernorateID']);
                              },
                              underline: Container(),
                              items: listGovernorates.governoratesList.map((governorate) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: governorate,
                                  child: Center(
                                    child: Text( (lang.activeLanguage.languageCode == 'ar')?
                                    governorate["GovernorateName"] ??
                                        (lang.activeLanguage.languageCode == 'ar' ? 'غير معروف' : 'Unknown'):
                                    governorate["GovernorateEName"]??''
                                      ,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        fontFamily: 'Monadi',
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }),

                        10.verticalSpace,

                        Text(
                          (lang.activeLanguage.languageCode == 'ar') ? 'المنطقه' : 'Region',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp,
                            fontFamily: 'Monadi',
                            color: AppColors.black,
                          ),
                        ),

                        5.verticalSpace,

                        Consumer(builder: (context, ref, child) {
                          final listAddress = ref.watch(getDataFromApiProviderr);

                          return Container(
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: DropdownButton<Map<String, dynamic>>(
                              isExpanded: true,
                              value: (listAddress.dataAddressList.isNotEmpty) ? selectedDistrict : null,
                              onChanged: (listAddress.dataAddressList.isEmpty)
                                  ? null // تعطيل القائمة إذا لم تكن هناك بيانات
                                  : (newValue) {
                                setState(() {
                                  selectedDistrict = newValue;
                                });
                              },
                              underline: Container(),
                              items: listAddress.dataAddressList.map((district) {
                                return DropdownMenuItem<Map<String, dynamic>>(
                                  value: district,
                                  child: Center(
                                    child: Text(
                                      (lang.activeLanguage.languageCode == 'ar')
                                          ? district["DistrictName"]
                                          : district["DistrictEName"],
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 14.sp,
                                        fontFamily: 'Monadi',
                                        color: AppColors.black,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          );
                        }),


                        13.verticalSpace,

                        Consumer(builder: (context, ref, child) {
                          final locationController =
                              ref.watch(locationProvider);
                          return locationController.isSelectedAdress
                              ? Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          debugPrint("Edit");
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ChooseLocation(
                                                        isArabic: (lang
                                                                .activeLanguage
                                                                .languageCode ==
                                                            'ar'),
                                                      )));
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                        )),
                                    Flexible(
                                      child: Text(
                                        locationController.getAddress,
                                        textDirection: TextDirection.ltr,
                                        textAlign: TextAlign.center,
                                        maxLines:
                                            null, // Set maxLines to null for unlimited lines
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                          fontFamily: 'Monadi',
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ChooseLocation(
                                                  isArabic: (lang.activeLanguage
                                                          .languageCode ==
                                                      'ar'),
                                                )));
                                  },
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.location_on,
                                        color: Colors.orange,
                                        size: 30,
                                      ),
                                      10.horizontalSpace,
                                      Text(
                                        (lang.activeLanguage.languageCode ==
                                                'ar')
                                            ? "حدد الإحداثيات"
                                            : "Select Coordinates",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14.sp,
                                          fontFamily: 'Monadi',
                                          color: AppColors.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                        }),

                        20.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: MyStyledTextField(
                                maxLength: 2,
                                label:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'القطعه'
                                        : 'Block',
                                hintText:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'القطعه'
                                        : 'Block',
                                controller:
                                    blockNumberControllerCheckOutOnSystem,
                                validator: (value) {
                                  if (locationController.isSelectedAdress) {
                                    return null;
                                  } else if (value == null || value.isEmpty) {
                                    return (lang.activeLanguage.languageCode ==
                                            'ar')
                                        ? 'هذا الحقل مطلوب'
                                        : 'Required field';
                                  }
                                  return null;
                                },
                                keyboardType: TextInputType.number,
                              ),
                            ),
                            5.horizontalSpace,
                            Expanded(
                              child: MyStyledTextField(
                                keyboardType: TextInputType.number,
                                maxLength: 100000,
                                label:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? ' الشارع'
                                        : 'Street ',
                                hintText:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'الشارع'
                                        : 'Street ',
                                controller: streetControllerCheckOutOnSystem,
                                validator: (value) {
                                  if (locationController.isSelectedAdress) {
                                    return null;
                                  } else if (value == null || value.isEmpty) {
                                    return (lang.activeLanguage.languageCode ==
                                            'ar')
                                        ? 'هذا الحقل مطلوب'
                                        : 'Required field';
                                  }
                                  return null;
                                },
                              ),
                            )
                          ],
                        ),

                        // MyStyledTextField(
                        //   keyboardType: TextInputType.text,
                        //   maxLength:50 ,
                        //
                        //   label:(lang.activeLanguage.languageCode == 'ar')?'اسم الحى':'District Name' ,
                        //   hintText:(lang.activeLanguage.languageCode == 'ar')?'اسم الحى':'District Name' ,
                        //
                        //   controller: districtNameControllerCheckOutOnSystem,
                        //   validator: (value) {
                        //     if (value == null || value.isEmpty) {
                        //       return (lang.activeLanguage.languageCode == 'ar')? 'هذا الحقل مطلوب':'Required field';
                        //     }
                        //     return null;
                        //   },
                        //
                        // ),

                        13.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: MyStyledTextField(
                                keyboardType: TextInputType.number,
                                maxLength: 100000,
                                label:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'المنزل'
                                        : 'House No.',
                                hintText:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'المنزل '
                                        : 'House No.',
                                controller: houseControllerCheckOutOnSystem,
                                validator: (value) {
                                  if (locationController.isSelectedAdress) {
                                    return null;
                                  } else if (value == null || value.isEmpty) {
                                    return 'هذا الحقل مطلوب';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            5.horizontalSpace,
                            Expanded(
                              child: MyStyledTextField(
                                keyboardType: TextInputType.number,
                                maxLength: 100000,
                                label:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'الجاده'
                                        : 'Gada.',
                                hintText:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'الجاده(اختيارى)'
                                        : 'Gada.(optional)',
                                controller:
                                    gadaNumberControllerCheckOutOnSystem,
                              ),
                            )
                          ],
                        ),
                        13.verticalSpace,
                        Row(
                          children: [
                            Expanded(
                              child: MyStyledTextField(
                                maxLength: 50,
                                keyboardType: TextInputType.number,

                                label:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'الدور'
                                        : 'Floor (Optional)',
                                hintText:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'الدور (اختيارى)'
                                        : 'Floor (Optional)',

                                controller: floorControllerCheckOutOnSystem,
                                // validator: (value) {
                                //   if (value == null || value.isEmpty) {
                                //     return 'هذا الحقل مطلوب';
                                //   }
                                //   return null;
                                // },
                              ),
                            ),
                            5.horizontalSpace,
                            Expanded(
                              child: MyStyledTextField(
                                maxLength: 50,
                                keyboardType: TextInputType.number,
                                label:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'الشقه'
                                        : 'Flat ',
                                hintText:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'الشقه (اختيارى)'
                                        : 'Flat (optional)',
                                controller:
                                    apartmentNumberControllerCheckOutOnSystem,
                              ),
                            ),
                          ],
                        ),
                        30.verticalSpace,
                        MyStyledTextField(
                          maxLength: 1500,
                          keyboardType: TextInputType.text,

                          label: (lang.activeLanguage.languageCode == 'ar')
                              ? 'ملاحظات العنوان'
                              : 'address Nots ',
                          hintText: (lang.activeLanguage.languageCode == 'ar')
                              ? 'ملاحظات العنوان'
                              : 'address nots (Optional)',

                          controller: addressNotsControllerCheckOutOnSystem,
                          // validator: (value) {
                          //   if (value == null || value.isEmpty) {
                          //     return 'هذا الحقل مطلوب';
                          //   }
                          //   return null;
                          // },
                        ),

                        15.verticalSpace,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Checkbox(
                              value: agreedToTerms,
                              onChanged: (value) {
                                setState(() {
                                  agreedToTerms = value ?? false;
                                });
                              },
                            ),
                            Text((lang.activeLanguage.languageCode == 'ar')
                                ? 'أوافق على الشروط والأحكام'
                                : 'I agree to the terms and conditions'),
                          ],
                        ),
                        25.verticalSpace,

                        Consumer(
                          builder: (context, ref, child) {
                            final registerProvide = ref.watch(registerProvider);

                            return MainConfirmButton(
                                background: Colors.orange,
                                title:
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? 'تسجيل حساب جديد'
                                        : 'Register an account Account',
                                onTap: () {
                                  final locationController =
                                      ref.read(locationProvider);
                                  // if (!locationController.isSelectedAdress) {
                                  //   print("Ok");
                                  //   locationController.validateAdress(context,
                                  //       isArabic:
                                  //           (lang.activeLanguage.languageCode ==
                                  //               'ar'));
                                  //   print("Ok");
                                  //   return;
                                  // }
                                  if (keyFormCheckOutOnSystem.currentState!
                                          .validate() &&
                                      (agreedToTerms == true)) {
                                    registerProvide.RegisterAccount(
                                        context: context,
                                        Gada: gadaNumberControllerCheckOutOnSystem
                                            .text,
                                        Email: emailControllerCheckOutOnSystem
                                            .text,
                                        CustomerPhone:
                                            mobileNumberControllerCheckOutOnSystem
                                                .text,
                                        ArabicName:
                                            nameControllerCheckOutOnSystem.text,
                                        HouseNo: houseControllerCheckOutOnSystem
                                            .text,
                                        PassWord:
                                            passwordControllerCheckOutOnSystem
                                                .text,
                                        DistrictName:
                                        selectedDistrict!["DistrictName"],

                                        regiontName:(lang.activeLanguage.languageCode == 'ar')? selectedGovernorate!['GovernorateName']: selectedGovernorate!['GovernorateEName'],
                                        StreetName:
                                            streetControllerCheckOutOnSystem
                                                .text,
                                        LastName:
                                            lastNameControllerCheckOutOnSystem
                                                .text,
                                        Floor: floorControllerCheckOutOnSystem
                                            .text,
                                        Block:
                                            blockNumberControllerCheckOutOnSystem
                                                .text,
                                        Apartment:
                                            apartmentNumberControllerCheckOutOnSystem
                                                .text,
                                        AddressNotes:
                                            addressNotsControllerCheckOutOnSystem
                                                .text,
                                        customerAdress:
                                            locationController.getAddress,
                                        placeId: locationController.getPlactId);
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
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: Text(
                                  (lang.activeLanguage.languageCode == 'ar')
                                      ? 'هل لديك حساب'
                                      : 'do you have an account',
                                  style: TextStyle(color: Colors.grey)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()),
                                );
                              },
                              child: Text(
                                  (lang.activeLanguage.languageCode == 'ar')
                                      ? 'تسجيل دخول'
                                      : 'Login',
                                  style: TextStyle(color: Colors.orange)),
                            ),
                          ],
                        ),

                        200.verticalSpace,
                      ],
                    ))),
          )),
    );
  }
}

Future<void> saveValueDeliveryValue(String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  prefs.setString('DeliveryValue', value);
}
