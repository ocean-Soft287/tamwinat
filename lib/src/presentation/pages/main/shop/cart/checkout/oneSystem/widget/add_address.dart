import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/auth/login/one_system/CashHelper.dart';
import 'package:sundaymart/src/presentation/pages/auth/chooseLocation/controller/choose_location_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/model/address_model.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/text_form_field_onsystem.dart';
import '../../../../../../../../riverpod/gh.dart';
import '../../../../../../../components/components.dart';
import '../../../../../../../theme/app_colors.dart';
import '../Controller/add_address_riverpod.dart';
import '../Controller/basct_shop_contrroller.dart';
import '../Controller/checkout_riverpod.dart';
import '../checkoutOneSystem.dart';

class AddAddress extends ConsumerStatefulWidget {
  List<Map<String, dynamic>> newmyList;
  List<Map<String, dynamic>> imageList;

  AddAddress({super.key, required this.newmyList, required this.imageList});

  @override
  _AddAddressState createState() => _AddAddressState();
}

class _AddAddressState extends ConsumerState<AddAddress> {
  var nameControllerCheckOutOnSystem = TextEditingController();
  var keyFormCheckOutOnSystem = GlobalKey<FormState>();
  var mobileNumberControllerCheckOutOnSystem = TextEditingController();
  var addressControllerCheckOutOnSystem = TextEditingController();
  var districtNameControllerCheckOutOnSystem = TextEditingController();
  var blockNumberControllerCheckOutOnSystem = TextEditingController();
  var gadaNumberControllerCheckOutOnSystem = TextEditingController();
  var streetControllerCheckOutOnSystem = TextEditingController();
  var houseControllerCheckOutOnSystem = TextEditingController();
  var emailControllerCheckOutOnSystem = TextEditingController();
  var scondPhoneControllerCheckOutOnSystem = TextEditingController();
  var apartmentControllerCheckOutOnSystem = TextEditingController();
  var floorControllerCheckOutOnSystem = TextEditingController();
  var addressNotsControllerCheckOutOnSystem = TextEditingController();
  var flatNumberControllerCheckOutOnSystem = TextEditingController();
  Map<String, dynamic>? selectedDistrict;
  Map<String, dynamic>? selectedGovernorate;
  String? ValueselectedDistrict = 'اختار المنطقه';

  @override
  void initState() {
    super.initState();
    ref.read(locationProvider).resetAdress();
    final savedPhone = CacheHelper.getData(key: 'PhoneUser');
    mobileNumberControllerCheckOutOnSystem.text =
        (UserPhone ?? savedPhone ?? '').toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // ref.read(locationProvider).resetAdress();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(appModelProvider);
    final locationController = ref.read(locationProvider);
    return Scaffold(
      backgroundColor: AppColors.mainBackground(),
      extendBody: true,
      appBar: CommonAppBar(
        title: (lang.activeLanguage.languageCode == 'ar')
            ? 'ادخل العنوان'
            : 'Address',
        onLeadingPressed: () => Navigator.pop(context),
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
                      label:
                          (lang.activeLanguage.languageCode == 'ar') ? ' ' : '',
                      hintText: (lang.activeLanguage.languageCode == 'ar')
                          ? 'الاسم الكامل'
                          : 'Full Name',
                      suffixIconData: const Icon(
                        Icons.person,
                      ),
                      controller: nameControllerCheckOutOnSystem,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return (lang.activeLanguage.languageCode == 'ar')
                              ? 'هذا الحقل مطلوب'
                              : 'Required field';
                        } else {
                          return null;
                        }
                      },
                    ),
                    // 5.verticalSpace,
                    // MyStyledTextField(
                    //   maxLength: 50,
                    //   keyboardType: TextInputType.emailAddress,
                    //   label: (lang.activeLanguage.languageCode == 'ar')
                    //       ? 'البريد الالكترونى'
                    //       : 'Email address',
                    //   hintText: (lang.activeLanguage.languageCode == 'ar')
                    //       ? 'البريد الالكترونى (اختيارى )'
                    //       : 'Email (Optional)',
                    //   suffixIconData: const Icon(
                    //     Icons.person,
                    //   ),
                    //   controller: emailControllerCheckOutOnSystem,
                    //   validator: (value) {
                    //     final trimmedValue = value?.trim();
                    //     if (trimmedValue?.isNotEmpty == true) {
                    //       final emailRegex = RegExp(
                    //         r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                    //       );
                    //       if (!emailRegex.hasMatch(trimmedValue!)) {
                    //         return lang.activeLanguage.languageCode == 'ar'
                    //             ? 'البريد الالكتروني غير صحيح يرجي التأكد'
                    //             : 'Email not correct, please check it';
                    //       }
                    //     }
                    //     return null;
                    //   },
                    // ),
                    // 13.verticalSpace,

                    MyStyledTextField(
                      maxLength: 8,
                      label: (lang.activeLanguage.languageCode == 'ar')
                          ? ''
                          : '',
                      hintText: (lang.activeLanguage.languageCode == 'ar')
                          ? 'رقم الهاتف'
                          : 'Mobile Number',
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
                                value.startsWith('٤') ||
                                value.startsWith('٥') ||
                                value.startsWith('٦') ||
                                value.startsWith('٩') ||
                                value.startsWith('9'))) {
                          return (lang.activeLanguage.languageCode == 'ar')
                              ? 'رقم الهاتف غير صحيح يرجي التأكد من رقم الهاتف'
                              : 'The Mobile Number not correct please check the mobile number';
                        } else {
                          return null;
                        }
                      },
                      keyboardType: TextInputType.phone,
                    ),
                    8.verticalSpace,
                    // MyStyledTextField(
                    //
                    //   maxLength: 8,
                    //   label:(lang.activeLanguage.languageCode == 'ar')?'رقم الهاتق':'Mobile Number' ,
                    //   hintText:(lang.activeLanguage.languageCode == 'ar')? 'رقم الهاتف الاحتياطى (اختيارى)':'Mobile Number (Optional)',
                    //   controller: scondPhoneControllerCheckOutOnSystem,
                    //
                    //
                    //   keyboardType: TextInputType.phone,
                    // ),
                    // 13.verticalSpace,
                    4.verticalSpace,
                    Consumer(builder: (context, ref, child) {
                      final listGovernorates =
                          ref.watch(getDataFromApiProviderr);

                      if (listGovernorates.governoratesList == null ||
                          listGovernorates.governoratesList.isEmpty) {
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
                          hint: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                (lang.activeLanguage.languageCode == 'ar')
                                    ? 'اختر المحافظة'
                                    : 'Choose Governorate',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  fontFamily: 'Monadi',
                                  color: AppColors.gray,
                                ),
                              ),
                            ),
                          ),
                          onChanged: (newValue) {
                            setState(() {
                              selectedGovernorate = newValue;
                              selectedDistrict =
                                  null; // إعادة التعيين عند تغيير المحافظة
                            });
                            print(selectedGovernorate);
                            listGovernorates.getDataListAddress(
                                governorateId:
                                    selectedGovernorate!['GovernorateID']);
                          },
                          underline: Container(),
                          items: listGovernorates.governoratesList
                              .map((governorate) {
                            return DropdownMenuItem<Map<String, dynamic>>(
                              value: governorate,
                              child: Text(
                                  (lang.activeLanguage.languageCode == 'ar')
                                      ? governorate["GovernorateName"] ??
                                          (lang.activeLanguage.languageCode ==
                                                  'ar'
                                              ? 'غير معروف'
                                              : 'Unknown')
                                      : governorate["GovernorateEName"] ?? '',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.sp,
                                    fontFamily: 'Monadi',
                                    color: AppColors.black,
                                  ),
                                ),
                            );
                          }).toList(),
                        ),
                      );
                    }),

                    8.verticalSpace,

                    4.verticalSpace,

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
                          value: (listAddress.dataAddressList.isNotEmpty)
                              ? selectedDistrict
                              : null,
                          hint: Align(
                            alignment: AlignmentDirectional.centerStart,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                
                                (lang.activeLanguage.languageCode == 'ar')
                                    ? 'اختر المنطقه'
                                    : 'Choose Region',
                                    textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  fontFamily: 'Monadi',
                                  color: AppColors.gray,
                                ),
                              ),
                            ),
                          ),
                          onChanged: (listAddress.dataAddressList.isEmpty)
                              ? null // تعطيل القائمة إذا لم تكن هناك بيانات
                              : (newValue) {
                                  setState(() {
                                    selectedDistrict = newValue;
                                  });
                                  print(selectedDistrict!["DeliveryValue"]);
                                },
                          underline: Container(),
                          items: listAddress.dataAddressList.map((district) {
                            return DropdownMenuItem<Map<String, dynamic>>(
                              value: district,
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
                            );
                          }).toList(),
                        ),
                      );
                    }),

                    // 13.verticalSpace,

                    const SizedBox.shrink(),

                    // 20.verticalSpace,
                    // InkWell(
                    //
                    //   onTap: () {
                    //     Navigator.push(
                    //       context,
                    //
                    //       MaterialPageRoute(builder: (context) => MapScreen()),
                    //     ).then((value) {
                    //
                    //       setState(() {
                    //         ValueselectedDistrict=value.subLocality;
                    //       });
                    //
                    //
                    //       print(value.subLocality.runtimeType);
                    //       flatNumberControllerCheckOutOnSystem.text=value.street;
                    //       print('Returned value from bottom sheet: ${value.street}');
                    //       print('Returned value from bottom sheet: ${value.street}');
                    //
                    //     });
                    //
                    //
                    //
                    //   },
                    //   child: Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Icon(
                    //         Icons.location_on,color:Colors.orange,
                    //
                    //       ),
                    //       Text((lang.activeLanguage.languageCode == 'ar')?
                    //       'حدد الأحداثيات':'Specify The coordinates',
                    //         style: TextStyle(fontSize: 16.sp, fontFamily: 'Monadi',),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    // 8.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MyStyledTextField(
                            maxLength: 2,
                            label: (lang.activeLanguage.languageCode == 'ar')
                                ? ''
                                : '',
                            hintText: (lang.activeLanguage.languageCode == 'ar')
                                ? 'القطعه'
                                : 'Block',
                            controller: blockNumberControllerCheckOutOnSystem,
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
                            label: (lang.activeLanguage.languageCode == 'ar')
                                ? ' '
                                : ' ',
                            hintText: (lang.activeLanguage.languageCode == 'ar')
                                ? 'الشارع'
                                : 'Street',
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
                    // 8.verticalSpace,

                    Row(
                      children: [
                        Expanded(
                          child: MyStyledTextField(
                            keyboardType: TextInputType.number,
                            maxLength: 100000,
                            label: (lang.activeLanguage.languageCode == 'ar')
                                ? ''
                                : '',
                            hintText: (lang.activeLanguage.languageCode == 'ar')
                                ? 'المنزل '
                                : 'House No.',
                            controller: houseControllerCheckOutOnSystem,
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
                        ),
                        5.horizontalSpace,
                        Expanded(
                          child: MyStyledTextField(
                            keyboardType: TextInputType.number,
                            maxLength: 100000,
                            label: (lang.activeLanguage.languageCode == 'ar')
                                ? ''
                                : '',
                            hintText: (lang.activeLanguage.languageCode == 'ar')
                                ? 'الجاده'
                                : 'Gada',
                            controller: gadaNumberControllerCheckOutOnSystem,
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
                    // 8.verticalSpace,
                    Row(
                      children: [
                        Expanded(
                          child: MyStyledTextField(
                            maxLength: 50,
                            keyboardType: TextInputType.number,

                            label: (lang.activeLanguage.languageCode == 'ar')
                                ? ''
                                : '',
                            hintText: (lang.activeLanguage.languageCode == 'ar')
                                ? 'الطابق (اختيارى)'
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
                            label: (lang.activeLanguage.languageCode == 'ar')
                                ? ''
                                : ' ',
                            hintText: (lang.activeLanguage.languageCode == 'ar')
                                ? 'الشقه (اختيارى)'
                                : 'Flat (optional)',
                            controller: flatNumberControllerCheckOutOnSystem,
                          ),
                        ),
                      ],
                    ),
                    // 8.verticalSpace,
                    MyStyledTextField(
                      maxLength: 250,
                      keyboardType: TextInputType.multiline,
                      maxLines: 4,
                      label: (lang.activeLanguage.languageCode == 'ar')
                          ? ''
                          : '',
                      hintText: (lang.activeLanguage.languageCode == 'ar')
                          ? 'اكتب أي ملاحظات إضافية'
                          : 'Write any additional notes',
                      controller: addressNotsControllerCheckOutOnSystem,
                    ),

                    16.verticalSpace,
                    Padding(
                        padding:
                            REdgeInsets.only(left: 16, right: 16, bottom: 36),
                        child: MainConfirmButton(
                          title: (lang.activeLanguage.languageCode == 'ar')
                              ? ' اضافه عنوان'
                              : 'Create Address',
                          background: Colors.orange.shade600,
                          onTap: () {
                            /*

UPDATEADRESS HERE
ناقص هتضيف بقا معلومات
المكان و placeIdعندك
في الصفحة دي
                            */
                            // final locationController =
                            //     ref.read(locationProvider);
                            // if (!locationController.isSelectedAdress) {
                            //   print("Ok");
                            //   locationController.validateAdress(context,
                            //       isArabic: (lang.activeLanguage.languageCode ==
                            //           'ar'));
                            //   print("Ok");
                            //   return;
                            // }

                            print(selectedDistrict!["DistrictName"]);
                            ref.watch(getAddressFromApiProvider);

                            print(
                                "Gamalllllllllllllllllllllllllllllllllllll4444444444");
                            print(
                                'addressNotsControllerCheckOutOnSystem  ${addressNotsControllerCheckOutOnSystem.text}');
                            print(
                                'flatNumberControllerCheckOutOnSystem  ${flatNumberControllerCheckOutOnSystem.text}');
                            print(
                                'addressNotsControllerCheckOutOnSystem  ${apartmentControllerCheckOutOnSystem.text}');
                            print(
                                'flatNumberControllerCheckOutOnSystem  ${floorControllerCheckOutOnSystem.text}');

                            if (keyFormCheckOutOnSystem.currentState!
                                .validate()) {
                              if (UserPhone != null) {
                                setState(() {
                                  UserPhone = null;
                                });
                              }

                              final address = AddressModel(
                                customerID: null,
                                arabicName: nameControllerCheckOutOnSystem.text,
                                englishName:
                                    nameControllerCheckOutOnSystem.text,
                                customerPhone: UserPhone ??
                                    mobileNumberControllerCheckOutOnSystem.text,
                                lastName: null,
                                passWord: null,
                                email: emailControllerCheckOutOnSystem.text,
                                regionId: null,
                                regionName: (lang.activeLanguage.languageCode ==
                                        'ar')
                                    ? selectedGovernorate!['GovernorateName']
                                    : selectedGovernorate!['GovernorateEName'],
                                placeId: locationController.getPlactId,
                                districtName: selectedDistrict!["DistrictName"],
                                streetName:
                                    streetControllerCheckOutOnSystem.text,
                                gada: gadaNumberControllerCheckOutOnSystem.text,
                                houseNo: houseControllerCheckOutOnSystem.text,
                                block:
                                    blockNumberControllerCheckOutOnSystem.text,
                                floor: floorControllerCheckOutOnSystem.text,
                                apartment:
                                    apartmentControllerCheckOutOnSystem.text,
                                addressNotes:
                                    addressNotsControllerCheckOutOnSystem.text,
                                customerAddress: locationController.getAddress,
                                billValue: double.tryParse(
                                        selectedDistrict?["BillValue"]
                                                ?.toString() ??
                                            '0') ??
                                    0.0,
                                paymentMethod:
                                    selectedDistrict!["PaymentMethod"]
                                        .toString(),
                                deliveryValue: double.tryParse(
                                        selectedDistrict?["DeliveryValue"]
                                                ?.toString() ??
                                            '0') ??
                                    0.0,
                                districtName2:
                                    selectedDistrict!["DistrictName"],
                                districtEName2:
                                    selectedDistrict!["DistrictEName2"],
                                token: null,
                                mapCustomerAddress:
                                    locationController.getAddress,
                                mapPlaceID: locationController.getPlactId,
                                addressID: null,
                                customerLastName: null,
                                regionID3:
                                    selectedGovernorate?["GovernorateID"],
                                regionname3:
                                    selectedGovernorate?["GovernorateName"],
                                regionEname3:
                                    selectedGovernorate?["GovernorateEName"],
                                addressNotes3: null,
                                address: null,
                                mainAddress: 0,
                                customerWork: null,
                              );

                              ref
                                  .read(getAddressFromApiProvider)
                                  .passAddressToGuest(address: address);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutPageOne(
                                          address: address,
                                          newmyList: widget.newmyList,
                                          gada:
                                              gadaNumberControllerCheckOutOnSystem
                                                  .text,

                                          apartmentControllerCheckOutOnSystem:
                                              flatNumberControllerCheckOutOnSystem
                                                  .text,
                                          BlockNumberControllerCheckOutOnSystem:
                                              blockNumberControllerCheckOutOnSystem
                                                  .text,

                                          emailControllerCheckOutOnSystem:
                                              emailControllerCheckOutOnSystem
                                                  .text,
                                          floorControllerCheckOutOnSystem:
                                              floorControllerCheckOutOnSystem
                                                  .text,
                                          HouseControllerCheckOutOnSystem:
                                              houseControllerCheckOutOnSystem
                                                  .text,
                                          mobileNumberControllerCheckOutOnSystem:
                                              mobileNumberControllerCheckOutOnSystem
                                                  .text,
                                          nameControllerCheckOutOnSystem:
                                              nameControllerCheckOutOnSystem
                                                  .text,
                                          BilleValue:
                                              selectedDistrict!["BillValue"] ??
                                                  3.5,
                                          PaymentMethod: selectedDistrict![
                                              "PaymentMethod"],

                                          // scondPhoneControllerCheckOutOnSystem: scondPhoneControllerCheckOutOnSystem.text,
                                          StreetControllerCheckOutOnSystem:
                                              streetControllerCheckOutOnSystem
                                                  .text,
                                          ValueselectedDistrict:
                                              selectedDistrict!["DistrictName"],
                                          regionName: (lang.activeLanguage
                                                      .languageCode ==
                                                  'ar')
                                              ? selectedGovernorate![
                                                  'GovernorateName']
                                              : selectedGovernorate![
                                                  'GovernorateEName'],
                                          DeliveryValue: selectedDistrict![
                                              "DeliveryValue"],
                                          titleNotes:
                                              addressNotsControllerCheckOutOnSystem
                                                  .text,
                                          customerAdressMap:
                                              locationController.getAddress,
                                          placeId:
                                              locationController.getPlactId,
                                        )),
                              );
                            }
                          },
                        )),
                  ],
                ))),
      ),
      // bottomNavigationBar:
      //
      //
      // Padding(
      // padding: REdgeInsets.only(left: 16, right: 16, bottom: 36),
      // child: MainConfirmButton(title:(lang.activeLanguage.languageCode == 'ar')?' اضافه عنوان': 'Create Address',
      //   background: Colors.orange.shade600,
      //   onTap: (){
      //     print(selectedDistrict!["DistrictName"]);
      //
      //     print('addressNotsControllerCheckOutOnSystem  ${addressNotsControllerCheckOutOnSystem.text}');
      //     print('flatNumberControllerCheckOutOnSystem  ${flatNumberControllerCheckOutOnSystem.text}');
      //     print('addressNotsControllerCheckOutOnSystem  ${apartmentControllerCheckOutOnSystem.text}');
      //     print('flatNumberControllerCheckOutOnSystem  ${floorControllerCheckOutOnSystem.text}');
      //
      //     if(keyFormCheckOutOnSystem.currentState!.validate()) {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => CheckoutPageOne(
      //
      //           newmyList: widget.newmyList,
      //          gada: gadaNumberControllerCheckOutOnSystem.text,
      //
      //           apartmentControllerCheckOutOnSystem: flatNumberControllerCheckOutOnSystem.text,
      //           BlockNumberControllerCheckOutOnSystem: blockNumberControllerCheckOutOnSystem.text,
      //
      //           emailControllerCheckOutOnSystem: emailControllerCheckOutOnSystem.text,
      //           floorControllerCheckOutOnSystem: floorControllerCheckOutOnSystem.text,
      //           HouseControllerCheckOutOnSystem: houseControllerCheckOutOnSystem.text,
      //           mobileNumberControllerCheckOutOnSystem: mobileNumberControllerCheckOutOnSystem.text,
      //           nameControllerCheckOutOnSystem: nameControllerCheckOutOnSystem.text,
      //           BilleValue: selectedDistrict!["BillValue"],
      //           PaymentMethod:selectedDistrict!["PaymentMethod"],
      //
      //           // scondPhoneControllerCheckOutOnSystem: scondPhoneControllerCheckOutOnSystem.text,
      //           StreetControllerCheckOutOnSystem:streetControllerCheckOutOnSystem.text ,
      //           ValueselectedDistrict: selectedDistrict!["DistrictName"],
      //           DeliveryValue:selectedDistrict!["DeliveryValue"],
      //           titleNotes:addressNotsControllerCheckOutOnSystem.text,
      //
      //         )),
      //       );
      //
      //
      //     }
      //   },
      //
      // )
      //
      // ),
    );
  }
}

class AddNewAddress extends ConsumerStatefulWidget {
  Map<String, dynamic>? editAddress;
  AddNewAddress({super.key, this.editAddress});
  @override
  _AddNewAddressState createState() => _AddNewAddressState();
}

class _AddNewAddressState extends ConsumerState<AddNewAddress> {
  var keyFormCheckOutOnSystem = GlobalKey<FormState>();

  var districtNameControllerCheckOutOnSystem = TextEditingController();
  var regionNameControllerCheckOutOnSystem = TextEditingController();
  var blockNumberControllerCheckOutOnSystem = TextEditingController();
  var gadaNumberControllerCheckOutOnSystem = TextEditingController();
  var streetControllerCheckOutOnSystem = TextEditingController();
  var houseControllerCheckOutOnSystem = TextEditingController();

  var apartmentNumberControllerCheckOutOnSystem = TextEditingController();
  var apartmentControllerCheckOutOnSystem = TextEditingController();
  var floorControllerCheckOutOnSystem = TextEditingController();
  var addressNotsControllerCheckOutOnSystem = TextEditingController();

  Map<String, dynamic>? selectedDistrict;
  Map<String, dynamic>? selectedGovernorate;
  String? ValueselectedDistrict = 'اختار المنطقه';
  @override
  Widget build(BuildContext context) {
    final addNewAddress = ref.watch(addAddressProvider);
    final listAddressUser = ref.watch(getAddressFromApiProvider);
    final lang = ref.watch(appModelProvider);
    final locationController = ref.read(locationProvider);
    if (widget.editAddress != null) {
      regionNameControllerCheckOutOnSystem.text =
          widget.editAddress!["Regionname3"].toString() ?? '';
      blockNumberControllerCheckOutOnSystem.text =
          widget.editAddress!["Block"].toString() ?? '';
      districtNameControllerCheckOutOnSystem.text =
          widget.editAddress!["DistrictName2"].toString() ?? '';
      apartmentNumberControllerCheckOutOnSystem.text =
          widget.editAddress!["Apartment"].toString() ?? '';
      apartmentControllerCheckOutOnSystem.text =
          widget.editAddress!["Apartment"].toString() ?? '';
      streetControllerCheckOutOnSystem.text =
          widget.editAddress!["StreetName"].toString() ?? '';
      gadaNumberControllerCheckOutOnSystem.text =
          widget.editAddress!["Gada"].toString() ?? '';
      houseControllerCheckOutOnSystem.text =
          widget.editAddress!["HouseNo"].toString() ?? '';
      floorControllerCheckOutOnSystem.text =
          widget.editAddress!["Floor"].toString() ?? '';
      addressNotsControllerCheckOutOnSystem.text =
          widget.editAddress!["AddressNotes"].toString() ?? '';
    }

    return KeyboardDismisser(
      child: Scaffold(
        backgroundColor: AppColors.mainBackground(),
        extendBody: true,
        appBar: CommonAppBar(
          title: (lang.activeLanguage.languageCode == 'ar')
              ? 'اضافه عنوان جديد'
              : "Add a new address",
          onLeadingPressed: () => Navigator.pop(context),
        ),
        body: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Form(
                  key: keyFormCheckOutOnSystem,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      10.verticalSpace,
                      Text(
                        (lang.activeLanguage.languageCode == 'ar')
                            ? 'المحافظة'
                            : 'Governorate',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14.sp,
                          fontFamily: 'Monadi',
                          color: AppColors.black,
                        ),
                      ),
                      5.verticalSpace,
                      Consumer(builder: (context, ref, child) {
                        final listGovernorates =
                            ref.watch(getDataFromApiProviderr);

                        if (listGovernorates.governoratesList == null ||
                            listGovernorates.governoratesList.isEmpty) {
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

                        if (widget.editAddress != null &&
                          widget.editAddress!["GovernorateName"] != null) {
                          selectedGovernorate ??=
                            listGovernorates.governoratesList.firstWhere(
                          (governorate) =>
                            governorate["GovernorateName"] ==
                            widget.editAddress!["GovernorateName"],
                          orElse: () =>
                            listGovernorates.governoratesList.first,
                          );
                        }

                        return Container(
                          padding: const EdgeInsets.all(2.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          child: DropdownButton<Map<String, dynamic>>(
                            isExpanded: true,
                            value: selectedGovernorate,
                            hint: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                (lang.activeLanguage.languageCode == 'ar')
                                    ? 'اختر المحافظة'
                                    : 'Choose Governorate',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  fontFamily: 'Monadi',
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                selectedGovernorate = newValue;
                                selectedDistrict =
                                    null; // إعادة التعيين عند تغيير المحافظة
                              });
                              print(selectedGovernorate);
                              listGovernorates.getDataListAddress(
                                  governorateId:
                                      selectedGovernorate!['GovernorateID']);
                            },
                            underline: Container(),
                            items: listGovernorates.governoratesList
                                .map((governorate) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: governorate,
                                child: Text(
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? governorate["GovernorateName"] ??
                                            (lang.activeLanguage.languageCode ==
                                                    'ar'
                                                ? 'غير معروف'
                                                : 'Unknown')
                                        : governorate["GovernorateEName"] ?? '',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.sp,
                                      fontFamily: 'Monadi',
                                      color: AppColors.black,
                                    ),
                                  ),
                              );
                            }).toList(),
                          ),
                        );
                      }),
                      10.verticalSpace,
                      Text(
                        (lang.activeLanguage.languageCode == 'ar')
                            ? 'المنطقه'
                            : 'Region',
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
                            value: (listAddress.dataAddressList.isNotEmpty)
                                ? selectedDistrict
                                : null,
                            hint: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text(
                                (lang.activeLanguage.languageCode == 'ar')
                                    ? 'اختر المنطقه'
                                    : 'Choose Region',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14.sp,
                                  fontFamily: 'Monadi',
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                            onChanged: (listAddress.dataAddressList.isEmpty)
                                ? null // تعطيل القائمة إذا لم تكن هناك بيانات
                                : (newValue) {
                                    setState(() {
                                      selectedDistrict = newValue;
                                    });
                                    print(selectedDistrict!["DeliveryValue"]);
                                  },
                            underline: Container(),
                            items: listAddress.dataAddressList.map((district) {
                              return DropdownMenuItem<Map<String, dynamic>>(
                                value: district,
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
                              );
                            }).toList(),
                          ),
                        );
                      }),
                      // 20.verticalSpace,
                      const SizedBox.shrink(),
                      20.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: MyStyledTextField(
                              maxLength: 2,
                              label: (lang.activeLanguage.languageCode == 'ar')
                                  ? 'القطعه'
                                  : 'Block',
                              hintText:
                                  (lang.activeLanguage.languageCode == 'ar')
                                      ? 'القطعه'
                                      : 'Block',
                              controller: blockNumberControllerCheckOutOnSystem,
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
                              label: (lang.activeLanguage.languageCode == 'ar')
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
                      13.verticalSpace,
                      Row(
                        children: [
                          Expanded(
                            child: MyStyledTextField(
                              keyboardType: TextInputType.number,
                              maxLength: 100000,
                              label: (lang.activeLanguage.languageCode == 'ar')
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
                              label: (lang.activeLanguage.languageCode == 'ar')
                                  ? 'الجاده'
                                  : 'Gada.',
                              hintText:
                                  (lang.activeLanguage.languageCode == 'ar')
                                      ? 'الجاده(اختيارى)'
                                      : 'Gada.(optional)',
                              controller: gadaNumberControllerCheckOutOnSystem,
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
                              label: (lang.activeLanguage.languageCode == 'ar')
                                  ? 'الدور'
                                  : 'Floor (Optional)',
                              hintText:
                                  (lang.activeLanguage.languageCode == 'ar')
                                      ? 'الدور (اختيارى)'
                                      : 'Floor (Optional)',
                              controller: floorControllerCheckOutOnSystem,
                            ),
                          ),
                          5.horizontalSpace,
                          Expanded(
                            child: MyStyledTextField(
                              maxLength: 50,
                              keyboardType: TextInputType.number,
                              label: (lang.activeLanguage.languageCode == 'ar')
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
                      13.verticalSpace,
                      MyStyledTextField(
                        maxLength: 250,
                        keyboardType: TextInputType.text,
                        label: (lang.activeLanguage.languageCode == 'ar')
                            ? 'ملاحظات (اختياري)'
                            : 'Notes (Optional)',
                        hintText: (lang.activeLanguage.languageCode == 'ar')
                            ? 'اكتب أي ملاحظات إضافية'
                            : 'Write any additional notes',
                        controller: addressNotsControllerCheckOutOnSystem,
                      ),
                      20.verticalSpace,
                    ],
                  ))),
        ),
        bottomNavigationBar: Padding(
            padding: REdgeInsets.only(left: 16, right: 16, bottom: 36),
            child: (widget.editAddress == null)
                ? MainConfirmButton(
                    title: (lang.activeLanguage.languageCode == 'ar')
                        ? 'اضافه عنوان جديد'
                        : "Add a new address",
                    background: Colors.orange.shade600,
                    onTap: () {
                      print("Gamallllllllllllllllllllllllllllllllll");
                      final locationController = ref.read(locationProvider);

                      print(selectedDistrict!["DistrictName"]);
                      print(selectedGovernorate!['GovernorateName']);
                      // if (!locationController.isSelectedAdress) {
                      //   print("Ok");
                      //   locationController.validateAdress(context,
                      //       isArabic: (lang.activeLanguage.languageCode == 'ar'));
                      //   print("Ok");
                      //   return;
                      // }
                      if (keyFormCheckOutOnSystem.currentState!.validate()) {
                        addNewAddress.addAddressFu(
                            context: context,
                            regionName:
                                (lang.activeLanguage.languageCode == 'ar')
                                    ? selectedGovernorate!['GovernorateName']
                                    : selectedGovernorate!['GovernorateEName'],
                            Block: blockNumberControllerCheckOutOnSystem.text,
                            Floor: floorControllerCheckOutOnSystem.text,
                            StreetName: streetControllerCheckOutOnSystem.text,
                            HouseNo: houseControllerCheckOutOnSystem.text,
                            Gada: gadaNumberControllerCheckOutOnSystem.text,
                            Apartment: apartmentControllerCheckOutOnSystem.text,
                            DistriictName: selectedDistrict!["DistrictName"],
                            customerAdressValue: locationController.getAddress,
                            placeIdValue: locationController.getPlactId);

                        ref.watch(getAddressFromApiProvider);
                        listAddressUser.getAddresss();

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => CheckoutPageOne(
                        //
                        //     newmyList: widget.newmyList,
                        //     gada: gadaNumberControllerCheckOutOnSystem.text,
                        //
                        //     apartmentControllerCheckOutOnSystem: apartmentControllerCheckOutOnSystem.text,
                        //     BlockNumberControllerCheckOutOnSystem: blockNumberControllerCheckOutOnSystem.text,
                        //
                        //     emailControllerCheckOutOnSystem: emailControllerCheckOutOnSystem.text,
                        //     floorControllerCheckOutOnSystem: floorControllerCheckOutOnSystem.text,
                        //     HouseControllerCheckOutOnSystem: houseControllerCheckOutOnSystem.text,
                        //     mobileNumberControllerCheckOutOnSystem: mobileNumberControllerCheckOutOnSystem.text,
                        //     nameControllerCheckOutOnSystem: nameControllerCheckOutOnSystem.text,
                        //     // scondPhoneControllerCheckOutOnSystem: scondPhoneControllerCheckOutOnSystem.text,
                        //     StreetControllerCheckOutOnSystem:streetControllerCheckOutOnSystem.text ,
                        //     ValueselectedDistrict: selectedDistrict!["DistrictName"],
                        //     DeliveryValue:selectedDistrict!["DeliveryValue"],
                        //     titleNotes:addressNotsControllerCheckOutOnSystem.text ,
                        //
                        //   )),
                        // );
                      }
                    },
                  )
                : MainConfirmButton(
                    title: (lang.activeLanguage.languageCode == 'ar')
                        ? 'تعديل العنوان'
                        : 'Edit Address',
                    background: Colors.orange.shade600,
                    onTap: () {
                      print(selectedDistrict!["DistrictName"]);

                      if (keyFormCheckOutOnSystem.currentState!.validate()) {
                        addNewAddress.editAddressFu(
                            context: context,
                            Block: blockNumberControllerCheckOutOnSystem.text,
                            Floor: floorControllerCheckOutOnSystem.text,
                            StreetName: streetControllerCheckOutOnSystem.text,
                            HouseNo: houseControllerCheckOutOnSystem.text,
                            Gada: gadaNumberControllerCheckOutOnSystem.text,
                            Apartment: apartmentControllerCheckOutOnSystem.text,
                            DistriictName: selectedDistrict!["DistrictName"],
                            addressId: widget.editAddress!["AddressID"],
                            function: listAddressUser);
                        //

                        if (addNewAddress.editSuccess == true) {
                          final listAddressUser =
                              ref.watch(getAddressFromApiProvider);
                          listAddressUser.getAddresss();
                        }
                      }
                    },
                  )),
      ),
    );
  }
}
