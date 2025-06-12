// ignore_for_file: prefer_const_constructors

import 'dart:io';
import 'dart:ui';


import 'package:auto_route/auto_route.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymart/src/core/constants/icon_broken.dart';
import 'package:sundaymart/src/core/routes/global_context_service.dart';
import 'package:sundaymart/src/presentation/pages/main/Notification/cubit/notification_cubit.dart';
import 'package:sundaymart/src/presentation/pages/main/changePassword/screen/change_passsword_screen.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/Tabby.dart';
import 'package:sundaymart/src/presentation/pages/main/home/politics_is_privacy.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/contact_us.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/notification_view.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/saved_addresses.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/support_page.dart';

import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';

import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/basct_shop.dart';
import 'package:sundaymart/src/presentation/pages/main/test_my.dart';
import 'package:sundaymart/src/presentation/pages/main/updateAccount/controller/update_account_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/updateAccount/screen/update_account_screen.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../main.dart';

import '../../../core/constants/constants.dart';

import '../../../riverpod/gh.dart';


import '../../theme/theme.dart';

import '../auth/login/one_system/CashHelper.dart';
import '../auth/login/one_system/login_screen.dart';
import '../auth/signup/one_system/register_screen.dart';
import '../pages.dart';

import '../search/search_screen.dart';

import 'common_questions.dart';

import 'home/on_system/controller/home_riverpod.dart';

import 'drawer/wallet/view/wallet_screen.dart';
import 'drawer/MyPreviousRequests/view/my_previous_requets_screen.dart';
import 'drawer/favorite/controler/favorite_riverpod.dart';
import 'drawer/favorite/screen/favorite_screen.dart';
import 'drawer/tamwnate_pro/view/tamwenat_pro_view.dart';
import 'drawer/wallet_poinets/manager/wallet_poinets_reiverpod.dart';
import 'drawer/wallet_poinets/view/wallet_points_view.dart';


class MainPage extends ConsumerWidget {
  Future<void> removeValue() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.remove('PhoneUser');
  }

  // static const appcastURL =
  //     'https://play.google.com/store/apps/details?id=com.tmwenat';
  // final upgrader = Upgrader(
  //   storeController: UpgraderStoreController(
  //     onAndroid: () => UpgraderAppcastStore(appcastURL: appcastURL),
  //   ),
  // );

  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GlobalContextService.context = context;
    UserPhone = CacheHelper.getData(key: 'PhoneUser');
    DeliveryValue = CacheHelper.getData(key: 'DeliveryValue');
    final appModel = ref.watch(appModelProvider);
    final deleteAccount = ref.watch(deleteAccountProvider);
    final walletPoints = ref.watch( walletPointsProvider);
    final getUpdateAccountApiProviderController =
    ref.read(getUpdateAccountApiProvider);
    getUpdateAccountApiProviderController.getFromApiData(context);
    // int SelectIndexAddress=0;
    return  Scaffold(
      backgroundColor: AppColors.white,
      extendBody: true,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(40),
        child: ClipRRect(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 0.0),
            child: AppBar(
              scrolledUnderElevation: 0,
              elevation: 0.0,
              backgroundColor: Colors.white,
              title: Padding(
                padding: const EdgeInsets.only(top: 12),
                child: Text(
                  'تموينات',
                  style: TextStyle(
                    fontSize: 22.sp,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Monadi',
                  ),
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.search, color: Colors.black),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SearchScrean()),
                    );
                  },
                ),
                InkWell(onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BactShop()),
                  );

                },child: Consumer(
                    builder: (context, ref, child){
                      final listItemOrder = ref.watch(orderProviderList);


                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          // أيقونة السلة
                          SizedBox(
                            width: 50,
                            height: 50,

                            child: Icon(
                              Icons.add_shopping_cart_rounded,

                              color: Colors.black, // لون السلة
                            ),
                          ),

                          if (listItemOrder.calculateTotalQuantity() > 0)
                            Positioned(
                              top: 0,
                              right:2,
                              child: Container(
                                height: 20,
                                width: 20, // عرض الحاوية ليتناسب مع العدد
                                // مسافة داخلية لتوسيط النص
                                decoration: BoxDecoration(
color:Colors.white,
                                  border: Border.all(
                                    color: Colors.black, // لون حدود الرقم
                                    width: 1.0, // سمك الحدود
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    listItemOrder.calculateTotalQuantity().toString(),
                                    style: TextStyle(
                                      color: Colors.black, // لون النص داخل الدائرة
                                      fontSize: 10, // حجم النص
                                      fontWeight: FontWeight.bold, // سماكة النص
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      );



                    }),

                ),





              ],
              centerTitle: true,
              leading: Builder(
                builder: (context) => IconButton(
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                  icon: Icon(Icons.menu, color: Colors.black,),
                ),
              ),
            ),
          ),
        ),
      ),
      body: UpgradeAlert(

        upgrader: Upgrader(
          // appStoreId:,
          debugLogging: true,

          languageCode: appModel.activeLanguage.languageCode,
          messages:
          UpgraderMessages(code: appModel.activeLanguage.languageCode),
          storeController: UpgraderStoreController(
            onAndroid: () => UpgraderAppcastStore(appcastURL: 'https://play.google.com/store/apps/details?id=com.tmwenat',),
          ),
          minAppVersion: "1.0.1",
          // onUpdate: () {
          //   launch(
          //       'https://play.google.com/store/apps/details?id=com.tmwenat');
          //   return true;
          // },
          // onUpdate: () {
          //   launch(
          //       'https://apps.apple.com/kw/app/%D8%AA%D9%85%D9%88%D9%8A%D9%86%D8%A7%D8%AA/id6479165814');
          //   return true;
          // },
          // cupertinoButtonTextStyle: TextStyle(
          //   color: Colors.red,
          // ),
        ),
        child: BlocProvider(
          create: (context) {
            return NotificationCubit()..getAllNotification();
          },
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: const [
              DeliveryPage(),
              // Consumer(builder: (context, ref, child) {
              //   final listItemOrder = ref.watch(orderProviderList);
              //
              //   return (listItemOrder.orderList.length == 0)
              //       ? Text('')
              //       : InkWell(
              //     onTap: () {
              //       Navigator.push(
              //         context,
              //         MaterialPageRoute(builder: (context) => BactShop()),
              //       );
              //     },
              //     child: Container(
              //       color: Colors.green,
              //       child: Padding(
              //         padding: const EdgeInsets.all(4.0),
              //         child: Column(
              //           mainAxisSize: MainAxisSize.min,
              //           children: [
              //             Container(
              //               decoration: BoxDecoration(
              //                 color: Colors.green,
              //                 borderRadius: BorderRadius.circular(20),
              //               ),
              //               child: Row(
              //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
              //                 children: [
              //                   Text(
              //                     '${listItemOrder.calculateTotalQuantity().toString()}',
              //                     style: TextStyle(
              //                       fontSize: 20.sp,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.w500,
              //                       fontFamily: 'Monadi',
              //                     ),
              //                   ),
              //                   Text(
              //                     (appModel.activeLanguage.languageCode == 'ar')
              //                         ? 'شاهد السله'
              //                         : 'View Cart',
              //                     style: TextStyle(
              //                       fontSize: 20.sp,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.w500,
              //                       fontFamily: 'Monadi',
              //                     ),
              //                   ),
              //                   Text(
              //                     ' ${listItemOrder.calculateTotalPrice().toStringAsFixed(3)}${(appModel.activeLanguage.languageCode == 'ar') ? "   د.ك" : "K.D"}',
              //                     style: TextStyle(
              //                       fontSize: 20.sp,
              //                       color: Colors.white,
              //                       fontWeight: FontWeight.w500,
              //                       fontFamily: 'Monadi',
              //                     ),
              //                   ),
              //                 ],
              //               ),
              //             ),
              //             10.verticalSpace,
              //           ],
              //         ),
              //       ),
              //     ),
              //   );
              // })
            ],
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.white,
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child:Column(
                  children: [
                    Image.asset(
                      AppAssets.pngOneSystemTomnaLogo,
                      width:300,
                      height: MediaQuery.sizeOf(context).height*.12,

                    ),
                  
                  ],
                )),
           
              if (UserPhone != null)
                    SizedBox(
                      child:Consumer(
                        builder:  (context, ref, child)
                        {
                          final getUpdateAccountApiProviderController =
                          ref.watch(getUpdateAccountApiProvider);
                          return  Row(
                            children: [
                              Image.asset(
                                AppAssets.accountInfo,
                                width: 50,

                              
                              ),
                              Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                                children:  [

                                  Text(

                                      (appModel.activeLanguage.languageCode == 'ar')?
                                      '${getUpdateAccountApiProviderController.userInformation['ArabicName']}'
                                  :
                                      '${getUpdateAccountApiProviderController.userInformation['EnglishName']}',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                fontFamily: 'Monadi',
                                color: AppColors.black,
                              ),
                                  ),
                                  Text('${getUpdateAccountApiProviderController.userInformation['CustomerPhone']}', style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12.sp,
                                    fontFamily: 'Monadi',
                                    color: AppColors.black,
                                  ),),
                                ],
                              ),
                            ],
                          );
                        },

                      ),
                    ),

            ListTile(
              leading: Icon(IconBroken.Home, color: Colors.orange),
              title: Text(
                (appModel.activeLanguage.languageCode == 'ar')
                    ? ' الرئيسية'
                    : 'Main',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  fontFamily: 'Monadi',
                  color: AppColors.black,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),

   
            ListTile(
              leading: Icon(Icons.headset_mic, color: Colors.orange),
              title: Text(
                (appModel.activeLanguage.languageCode == 'ar')
                    ? 'خدمه العملاء(محادثه)'
                    : 'Customer Support (chat)',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  fontFamily: 'Monadi',
                  color: AppColors.black,
                ),
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return SupportPage(dataUser: getUpdateAccountApiProviderController.userInformation,);
                }));
              },
            ),
            if (UserPhone != null)
              ListTile(
                leading: Icon(IconBroken.Heart, color: Colors.orange),
                title: Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? 'منتجاتى المفضله'
                      : 'My Wish List',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  print('UserPhone');
                  print(UserPhone);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Favorite()),
                  );
                },
              ),
            if (UserPhone != null)
              ListTile(
                leading:
                const Icon(Icons.account_balance_wallet, color: Colors.orange),
                title: Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? 'المحفظة'
                      : 'Wallet',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  print('UserPhone');
                  print(UserPhone);
                  Navigator.push(
                    context,

                    MaterialPageRoute(builder: (context) => WalletScreen()),
                  );
                },
              ),
            if (UserPhone != null)
              ListTile(
                leading:
                const Icon(Icons.point_of_sale, color: Colors.orange),
                title: Row(
                  children: [
                    Text(
                      (appModel.activeLanguage.languageCode == 'ar')
    ? 'النقاط'
        : 'Points',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        fontFamily: 'Monadi',
                        color: AppColors.black,
                      ),
                    ),
                    // RichText(
                    //   text: TextSpan(
                    //     children: [
                    //       TextSpan(
                    //         text:(walletPoints.walletPointsList.isNotEmpty)? '${walletPoints.walletPointsList[0]['PointsBalance'].toStringAsFixed(3)}':'',
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 14.sp,
                    //           fontFamily: 'Monadi',
                    //             color: Colors.orange
                    //         ),
                    //       ),
                    //       TextSpan(
                    //         text: (appModel.activeLanguage.languageCode == 'ar')?'نقطة':'Point',
                    //         style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           fontSize: 14.sp,
                    //           fontFamily: 'Monadi',
                    //           color: AppColors.black,
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // )
                  ],
                ),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WalletMyPointsView()),
                  );
                },
              ),
            if (UserPhone != null)
              ListTile(
                leading:
                const Icon(Icons.tab, color: Colors.orange),
                title: Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? 'تموينات برو '
                      : 'Tamwenat Pro',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                 
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TamwenateProView(dataUser: getUpdateAccountApiProviderController.userInformation,)),
                  );
                },
              ),
            if (UserPhone != null)
              ListTile(
                leading: Icon(Icons.list, color: Colors.orange),
                title: Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? 'طلباتى السابقه'
                      : 'My previous requests',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.black,
                  ),
                ),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MyPreviousRequetsScreen()),
                  );
                },
              ),
            if (UserPhone == null)
              ListTile(
                leading: Icon(IconBroken.User, color: Colors.orange),
                title: Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? 'تسجيل الدخول'
                      : 'Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              ),
            if (UserPhone == null)
              ListTile(
                leading: Icon(IconBroken.Add_User, color: Colors.orange),
                title: Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? 'تسجيل حساب'
                      : 'Register',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
              ),
            ListTile(
              leading: Icon(Icons.person, color: Colors.orange),
              title: Text(
                (appModel.activeLanguage.languageCode == 'ar')
                    ? 'من نحن'
                    : 'Who Are We',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  fontFamily: 'Monadi',
                  color: AppColors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUs()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.policy, color: Colors.orange),
              title: Text(
                (appModel.activeLanguage.languageCode == 'ar')
                    ? 'السياسه والخصوصيه'
                    : 'Policy and Privacy',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  fontFamily: 'Monadi',
                  color: AppColors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => PoliticsIsPrivacy()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.help, color: Colors.orange),
              title: Text(
                (appModel.activeLanguage.languageCode == 'ar')
                    ? 'الاسئله الشائعه'
                    : 'Common Questions',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  fontFamily: 'Monadi',
                  color: AppColors.black,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CommonQuestion()),
                );
              },
            ), // COMMENT
            if (UserPhone != null)
              ListTile(
                leading: const Icon(IconBroken.Setting, color: Colors.orange),
                title: Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? "تعديل معلومات الحساب"
                      : "update account information",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  print('UserPhone');
                  print(UserPhone);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const UpdateAccountScreen()),
                  );
                },
              ),
            if (UserPhone != null)
              ListTile(
                leading: const Icon(IconBroken.Notification, color: Colors.orange),
                title: Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? "الاشعارات"
                      : "Notification",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.black,
                  ),
                ),
                onTap: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const  NotificationView()),
                  );
                },
              ),

            if (UserPhone != null)
              ListTile(
                leading: const Icon(IconBroken.Location, color: Colors.orange),
                title: Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? "العناوين المحفوظه"
                      : "Saved Addresses",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  print('UserPhone');
                  print(UserPhone);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SavedAddresses()),
                  );
                },
              ),

            if (UserPhone != null)
              ListTile(
                leading: const Icon(IconBroken.Password, color: Colors.orange),
                title: Text(
                  (appModel.activeLanguage.languageCode == 'ar')
                      ? 'تغيير كلمة السر'
                      : 'Forget Password',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    fontFamily: 'Monadi',
                    color: AppColors.black,
                  ),
                ),
                onTap: () {
                  print('UserPhone');
                  print(UserPhone);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ChangePasswordScreen()),
                  );
                },
              ),


            Consumer(
              builder: (context, ref, child) {
                final lang = ref.watch(appModelProvider);
                final listItemOrder = ref.watch(orderProviderList);
                return ListTile(
                  leading: Icon(Icons.language, color: Colors.orange),
                  title: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'Change Language'
                        : 'تغير اللغه',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      fontFamily: 'Monadi',
                      color: AppColors.black,
                    ),
                  ),
                  onTap: () {
                    lang.toggleLanguage();
                  },
                );
              },
            ),
            if (UserPhone != null)
              Consumer(builder: (context, ref, child) {
                final listItemOrderImage = ref.watch(orderProviderListImage);
                final listItemOrder = ref.watch(orderProviderList);
                return ListTile(
                  leading: Icon(Icons.exit_to_app, color: Colors.orange),
                  title: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'تسجيل خروج'
                        : 'Log Out',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      fontFamily: 'Monadi',
                      color: AppColors.black,
                    ),
                  ),
                  onTap: () {
                    print(UserPhoneAll);print(UserPhone);

                    listItemOrder.clearItems();
                    listItemOrderImage.clearItems();
                    listItemOrder.clearItems();
                    print(listItemOrder.orderList.length);
                    print(listItemOrderImage.orderListImage.length);
                    listItemOrder.clearItems();
                    removeValue();
                    print('PhoneUser');
                    print(UserPhone);

                    UserPhone=null;
                    UserPhoneAll=null;
                    // //  Navigator.of(context).pop(); // to close drawer

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SelectLangPage(
                          isRequired: true,
                        ),
                      ),
                    );



                    // Navigator.of(context).pop();
                    // Future.delayed(Duration(seconds: 2)).then((value) {
                    //   //routerPackage.popUntilRoot();

                    //   // Navigator.popUntil(
                    //   //     context, (route) => route.settings.name == "/login");

                    //   Navigator.pushReplacement(
                    //     context,
                    //     MaterialPageRoute(
                    //       builder: (context) => LoginScreen(),
                    //     ),
                    //   );
                    // }
                    // );
                  },
                );
              }),
            if (UserPhone != null)
              Consumer(builder: (context, ref, child) {
                final listItemOrderImage = ref.watch(orderProviderListImage);
                final listItemOrder = ref.watch(orderProviderList);
                return ListTile(
                  leading: Icon(IconBroken.Delete, color: Colors.orange),
                  title: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'حذف الحساب'
                        : 'Delete Account',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      fontFamily: 'Monadi',
                      color: AppColors.black,
                    ),
                  ),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Dialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'هل انت متاكد من حذف الحساب'
                                      : 'Are you sure you want to delete the account?',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: 16.0),
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        deleteAccount.deleteAccount();
                                        listItemOrder.clearItems();
                                        listItemOrderImage.clearItems();
                                        listItemOrder.clearItems();
                                        print(listItemOrder.orderList.length);
                                        print(listItemOrderImage
                                            .orderListImage.length);
                                        listItemOrder.clearItems();
                                        removeValue();
                                        print('PhoneUser');
                                        print(UserPhone);

                                        // context.replaceRoute(
                                        //     SelectLangRoute(isRequired: true));

                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SelectLangPage(
                                                  isRequired: true,
                                                ),
                                          ),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors
                                            .green, // Set the background color to orange
                                      ),
                                      child: Text(
                                        (appModel.activeLanguage.languageCode ==
                                            'ar')
                                            ? 'تاكيد'
                                            : 'Continue',
                                        style: TextStyle(
                                          color: Colors
                                              .white, // Set the text color to white
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.green,
                                      ),
                                      child: Text(
                                        (appModel.activeLanguage.languageCode ==
                                            'ar')
                                            ? 'الغاء'
                                            : 'Cancel',
                                        style: TextStyle(
                                          color: Colors
                                              .white, // Set the text color to white
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
            ListTile(
              leading: const Icon(Icons.info, color: Colors.orange),
              title: Text(
                (appModel.activeLanguage.languageCode == 'ar')
                    ? (Platform.isIOS ? "الإصدار 1.10.1" : "الإصدار 1.0.1")
                    : Platform.isIOS ? "Version 1.10.1" : "Version 1.0.1+3",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  fontFamily: 'Monadi',
                  color: AppColors.black,
                ),
              ),
              onTap: () {
                // إضافة أي إجراء عند الضغط على ListTile
              },
            )

          ],
        ),
      ),


    );
  }
}
