import 'dart:async';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marquee/marquee.dart';
import 'package:sundaymart/src/presentation/pages/main/Notification/cubit/notification_cubit.dart';
import 'package:sundaymart/src/presentation/pages/main/Notification/notification_service.dart/notification.service.dart';

import 'package:sundaymart/src/presentation/pages/main/home/widget/banaer_items_screen.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/delivery_category_scondry.dart';

import '../../../../../main.dart';
import '../../../../core/constants/constants.dart';

import '../../../../riverpod/gh.dart';
import '../../../theme/theme.dart';
import '../../pages.dart';
import '../drawer/favorite/controler/favorite_riverpod.dart';

import '../shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import '../shop/cart/checkout/oneSystem/widget/text_form_field_onsystem.dart';
import '../shop/details/banner_details/banner_details_page.dart';
import 'on_system/controller/home_riverpod.dart';

class DeliveryPage extends ConsumerStatefulWidget {
  const DeliveryPage({Key? key}) : super(key: key);

  @override
  ConsumerState<DeliveryPage> createState() => _DeliveryPageState();
}

class _DeliveryPageState extends ConsumerState<DeliveryPage> {
  List<List<bool>> isSecondContainerVisibleList1 =
  List.generate(100, (index) => List.filled(100, false));
  List<List<bool>> isSecondContainerVisibleList2 = List.generate(100, (index) => List.filled(100, false));
  List<bool> isSecondContainerVisibleListbestSeller =
  List.generate(100, (index) => false);
  List<bool> itemLoveStatesbestSeller = List.generate(100, (index) => false);
  List<bool> isSecondContainerVisibleListBiggestDiscount =
  List.generate(100, (index) => false);
  List<bool> itemLoveStatesBiggestDiscount =
  List.generate(100, (index) => false);

  List<bool> isSecondContainerProductVersion =
  List.generate(100, (index) => false);
  List<bool> itemLoveStatesProductVersion =
  List.generate(100, (index) => false);
  var customPhoneGuestController = TextEditingController();
  var keyFormCheckOutOnSystem = GlobalKey<FormState>();
  int _currentPage = 0;


  List<String> newsTextList = [];
  @override
  void initState() {
    super.initState();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {


      NotificationServices.awesomeNotifications.createNotification(
          content: NotificationContent(
              id: 256,
              channelKey: "basic_channel",
              title: message.notification!.title,
              body: message.notification!.body));
    }).onError((error) {
      print("Errorr1");
    });

    ref.read(getImageBanarOneApiProvider.notifier).getImageBanarOne();
    ref.read(getImageBanartwoApiProvider.notifier).getImageBanartwo();
    ref.read(getDataNewsFromApiProvider.notifier).getNews();
    ref.read(getImageBanarThreeApiProvider.notifier).getImageBanarthree();
    ref.read(getDataBestSellerFromApiProvider.notifier).getBestSeller();
    ref.read(getDataBiggestDiscountFromApiProvider.notifier).getGetDataBiggestDiscount();
    ref.read(getDataProductVersionFromApiProvider.notifier).getProductVersion();
    ref.read(getDataOverOneFromApiProvider.notifier).getOverOe();
    ref.read(getDataOverTwoFromApiProvider.notifier).getOverTwo();

  }

  @override
  Widget build(BuildContext context) {
    // double screenWidth = MediaQuery.of(context).size.width;
    // int crossAxisCount = (screenWidth / 100).floor();
    final appModel = ref.watch(appModelProvider);
    return BlocListener<NotificationCubit, NotificationState>(
      listener: (context, state) {
        if (state is NotificationInitial) {}
        if (state is NotificationSuccess) {
          // NotificationServices.showNotification(
          //     allNotifications: state.allNotification);
        }
      },
      child:
      SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer(builder: (context, ref, child) {
              final getDataCategoryByParentId =
              ref.watch(getImageBanarOneApiProvider);
              return getDataCategoryByParentId.imageBanarOneList.isEmpty?const SizedBox():
                (getDataCategoryByParentId.imageBanarOneList[0]["ShowGroup"]==0)?const SizedBox():
                Container(
                height: 150.0.h,
                width: MediaQuery.of(context).size.width,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: CarouselSlider.builder(
                  itemCount: getDataCategoryByParentId.imageBanarOneList.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          print(getDataCategoryByParentId.imageBanarOneList[index]);


                          if(getDataCategoryByParentId.imageBanarOneList[index]["ItemsCount"]>0)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BannerItemsScreen(
                                    imageName:
                                    '${getDataCategoryByParentId.imageBanarOneList[index]["ID"]}',
                                  )),
                            );
                          }

                        },
                        child:
                        Image.network(
                          width: MediaQuery.of(context).size.width,
                          '${getDataCategoryByParentId.imageBanarOneList[index]["ImagePath"] ?? ""}',
                          fit: BoxFit.fill,
                        ),



                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: MediaQuery.of(context).size.width /
                        MediaQuery.of(context).size.height,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                  ),
                ),
              );
            }),
            14.verticalSpace,

            Consumer(builder: (context, ref, child) {
              final getDataNews = ref.watch(getDataNewsFromApiProvider);
              List<String> newsTextList = [];
              for (var item in getDataNews.newsList) {
                newsTextList.add(item['NewsText']);
              }

              for (var item in getDataNews.newsList) {
                newsTextList.add(item['NewsText']);
              }
              return (newsTextList.isEmpty)?const Text(' '):
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                height: 30.h,
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(0),
                ),
                child: Center(
                  child: Marquee(
                    text: (newsTextList.isEmpty)
                        ? (appModel.activeLanguage.languageCode == 'ar')
                        ? '         '
                        : '           '
                        : (appModel.activeLanguage.languageCode == 'ar')
                        ? newsTextList.join('           ')
                        : newsTextList.join('           '),
                    style: GoogleFonts.tajawal(
                      fontSize: 13.sp, color: AppColors.white,
                      fontWeight: FontWeight.bold,
                    ),


                    scrollAxis: Axis.horizontal,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    blankSpace: 20.0,
                    velocity: 100.0,
                    pauseAfterRound: const Duration(milliseconds: 500),
                    startPadding: 10.0,
                    accelerationDuration: const Duration(milliseconds: 500),
                    accelerationCurve: Curves.linear,
                    decelerationDuration: const Duration(milliseconds: 500),
                    decelerationCurve: Curves.easeOut,
                  ),
                ),
              );
            }),
            14.verticalSpace,
            Consumer(
              builder: (context, ref, child) {
                final getMainCategory =
                ref.watch(getDataGetMainCategoryApiProvider);
                final appModel = ref.watch(appModelProvider);
                return  (getMainCategory.mainCategoryList.isEmpty)?const SizedBox():
                  GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: getMainCategory.mainCategoryList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 0.0,
                    mainAxisSpacing: 0.0,
                  ),
                  itemBuilder: (context, index) {
                    final item = getMainCategory.mainCategoryList[index];

                    return Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: InkWell(
                       onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DeliveryCategoryScondory(
                                    categoryId: item['CategoryId'],
                                    CategoryArName:
                                    (appModel.activeLanguage.languageCode ==
                                        'ar')
                                        ? item['CategoryArName']
                                        : item['CategoryEnName'])),
                          );
                          print( item['CategoryId']);


                        },
                        child: Column(
                          children: [
                            4.verticalSpace,
                            Expanded(
                              flex: 2,
                              child:
                              Image.network(
                                '${item['CategoryImage'] ?? ""}',
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return child;
                                  // return const Center(
                                  //   child: CircularProgressIndicator(color: Colors.orange,value: 1,),
                                  // );
                                },
                                errorBuilder: (context, error, stackTrace) {
                                  return const Icon(Icons.error);
                                },
                              ),






                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? '${item['CategoryArName']}'
                                      : '${item['CategoryEnName']}',
                                  style: GoogleFonts.tajawal(
                                    fontSize:
                                    12.sp,
                                    fontWeight:
                                    FontWeight.bold,
                                  ),


                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
            10.verticalSpace,
            Consumer(builder: (context, ref, child) {
              final getDataCategoryByParentId =
              ref.watch(getImageBanartwoApiProvider);
              return
                getDataCategoryByParentId.imageBanartwoList.isEmpty?const SizedBox():
                getDataCategoryByParentId.imageBanartwoList[0]["ShowGroup"]==0?const SizedBox():
                Container(
                height: 150.0.h,
                width: MediaQuery.of(context).size.width,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: CarouselSlider.builder(
                  itemCount: getDataCategoryByParentId.imageBanartwoList.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          print(getDataCategoryByParentId.imageBanartwoList[index]);
                          if(getDataCategoryByParentId.imageBanartwoList[index]["ItemsCount"]>0)
                            {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BannerItemsScreen(
                                      //  imageName: index + 11,
                                      imageName:
                                      '${getDataCategoryByParentId.imageBanartwoList[index]["ID"]}',
                                    )),
                              );
                            }

                        },
                        child:




                        Image.network(
                          width: MediaQuery.of(context).size.width,
                          '${getDataCategoryByParentId.imageBanartwoList[index]["ImagePath"]}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: MediaQuery.of(context).size.width /
                        MediaQuery.of(context).size.height,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                  ),
                ),
              );
            }),
            10.verticalSpace,

            Consumer(builder: (context, ref, child) {
              final getDataFavoriteFromApi = ref.watch(addItemFavoriteProvider);
              final getDataCategoryItemFromApi =
              ref.watch(getDataBestSellerFromApiProvider);
              final listItemOrder = ref.watch(orderProviderList);
              final listItemOrderImage = ref.watch(orderProviderListImage);
              final deletFavorite = ref.watch(deleteItemFavoriteProvider);




              return  (getDataCategoryItemFromApi.bestSellerList.isEmpty||getDataCategoryItemFromApi.bestSellerList[0]["ShowGroup"]==0)?const SizedBox():Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: InkWell(
                      onTap: (){
                        print( getDataCategoryItemFromApi.bestSellerList[0]);
                      },
                      child: Text(
                        (appModel.activeLanguage.languageCode == 'ar')
                            ? 'الاكثر مبيعا'
                            : 'Best Seller',
                        style: GoogleFonts.tajawal(
                          fontSize:
                          16.sp,
                          fontWeight:
                          FontWeight.bold,
                        ),

                      ),
                    ),
                  ),
                  5.verticalSpace,
                  SizedBox(
                    height: 230.h,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: getDataCategoryItemFromApi.bestSellerList.length,
                      itemBuilder: (context, index) {
                        final item =
                        getDataCategoryItemFromApi.bestSellerList[index];
                        num q1 = listItemOrder.getQuantity(itemID: item["BarCode"]);
                        num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]);
                        return Card(
                          color: Colors.white,
                          child: Container(
                            color: Colors.white,
                            width: 200.w,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  //getDataFromApi.dataCategoryAllList[index]["productId"]
                                  MaterialPageRoute(
                                      builder: (context) => BannerDetailsPage(
                                        productId: item["ProductID"],
                                        CategoryId: item['CategoryId'],
                                        name: (appModel.activeLanguage
                                            .languageCode ==
                                            'ar')
                                            ? item['ProductArName']
                                            : item['ProductEnName'],
                                        image: item['ProductcImage'],
                                        specification: item['Specification'],
                                      )),
                                );





                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: REdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 130,
                                                  child: Center(
                                                    child: Image.network(
                                                      '${item['ProductcImage']}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if((UserPhoneAll??UserPhone)==null)
                                                    {

                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (_) => AlertDialog(

                                                            content: Text(
                                                              "يرجى ادخال رقم الهاتف",
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: const Color(0xff000000),
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: 'Monadi',
                                                              ),
                                                            ),
                                                            actions: [

                                                              Form(
                                                                key:keyFormCheckOutOnSystem,
                                                                child: MyStyledTextField(
                                                                  maxLength: 8,
                                                                  keyboardType: TextInputType.phone,
                                                                  label:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',
                                                                  hintText:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',

                                                                  controller: customPhoneGuestController,
                                                                  validator: (value) {
                                                                    if (value!.isEmpty) {
                                                                      return (appModel.activeLanguage.languageCode == 'ar')
                                                                          ? 'هذا الحقل مطلوب'
                                                                          : 'This field is required';
                                                                    } else if (value.length != 8 ||
                                                                        !(value.startsWith('4') ||
                                                                            value.startsWith('5') ||
                                                                            value.startsWith('6') ||
                                                                            value.startsWith('9'))) {
                                                                      return (appModel.activeLanguage.languageCode == 'ar')
                                                                          ? '  رقم الهاتف غير صحيح او الارقام لا تحتوي علي ارقام انجليزية يرجي التأكد   ا'
                                                                          : 'The Mobile Number not correct please check the mobile number';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                              20.verticalSpace,

                                                              TextButton(
                                                                style: ButtonStyle(
                                                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                                    EdgeInsets.zero,
                                                                  ),
                                                                ),
                                                                onPressed: ()  {



                                                                  if(keyFormCheckOutOnSystem.currentState!.validate()) {

                                                                  }
                                                                  if(UserPhone==null)
                                                                  {
                                                                    UserPhoneAll=customPhoneGuestController.text;
                                                                  }
                                                                  else
                                                                  {
                                                                    UserPhoneAll=UserPhone;
                                                                  }




                                                                  Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => const MainPage(

                                                                      ),
                                                                    ),
                                                                  );

                                                                },
                                                                child: Container(
                                                                  width: 1.sw - 30,
                                                                  height: 40.r,
                                                                  alignment: Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.orange,
                                                                    borderRadius: BorderRadius.circular(30),

                                                                  ),
                                                                  child:false
                                                                      ? SizedBox(
                                                                    height: 20.r,
                                                                    width: 20.r,
                                                                    child: CircularProgressIndicator(
                                                                      strokeWidth: 3.r,
                                                                      color: AppColors.white,
                                                                    ),
                                                                  )
                                                                      : Text(
                                                                    (appModel.activeLanguage.languageCode == 'ar')?

                                                                    "استمرار":'Continue ',
                                                                    style: GoogleFonts.inter(
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 12.sp,
                                                                      color: AppColors.white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                      );

                                                    }
                                                    else
                                                    {
                                                      setState(() {
                                                        isSecondContainerVisibleListbestSeller[
                                                        index] =
                                                        !isSecondContainerVisibleListbestSeller[
                                                        index];
                                                        // isSecondContainerVisible =
                                                        // !isSecondContainerVisible;
                                                      });

                                                      setState(() {
                                                        if (q1 == 0) {
                                                          q1++;

                                                        }
                                                        listItemOrder.addItem({
                                                          "ItemID": item["ProductID"],
                                                          "Quantity": q1,
                                                          "Price": item[
                                                          "PriceAfterDiscount"],
                                                          "StockQuantity":
                                                          item["StockQuantity"],
                                                          "BarCode": item["BarCode"],
                                                          "Colors_ID": '',
                                                          "Size_ID": '',
                                                          "RequiredQTY":item['RequiredQTY'],
                                                          "GiftQTY":item['GiftQTY'],
                                                          "Y_Gift_Qty":y,
                                                        });
                                                        listItemOrderImage.addItem({
                                                          "image":
                                                          item["ProductcImage"],
                                                          "ItemID": item["ProductID"],
                                                          "Quantity": q1,
                                                          "Price": item[
                                                          "PriceAfterDiscount"],
                                                          "ProductArName":
                                                          item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                          "ProductEnName":
                                                          item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                          "StockQuantity":
                                                          item["StockQuantity"],
                                                          "CustomerQuantity":(item["CustomerQuantity"]> 0.0)?
                                                          item["CustomerQuantity"]:item["CustomerQtyFree"],
                                                          "BarCode": item["BarCode"],
                                                          "Colors_ID": '',
                                                          "Size_ID": '',
                                                          "RequiredQTY":item['RequiredQTY'],
                                                          "GiftQTY":item['GiftQTY'],
                                                          "Y_Gift_Qty":y,
                                                        });
                                                      });

                                                      if (isSecondContainerVisibleListbestSeller[
                                                      index]) {
                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds: 10000),
                                                                () {
                                                              setState(() {
                                                                isSecondContainerVisibleListbestSeller[
                                                                index] = false;
                                                              });
                                                            });
                                                      }
                                                    }


                                                  },
                                                  child:
                                                  !isSecondContainerVisibleListbestSeller[
                                                  index]
                                                      ? Card(
                                                    child: Container(
                                                      height: 40.h,
                                                      width: 35.w,
                                                      color: (q1 >= 1)
                                                          ? Colors.green
                                                          : Colors.white,
                                                      child: Center(
                                                        child: Text(
                                                            (q1 >= 1)
                                                                ? '$q1'
                                                                : '+',
                                                            style:
                                                            TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontFamily: 'Monadi',
                                                              fontSize:
                                                              20.sp,
                                                              color: (q1 >=
                                                                  1)
                                                                  ? Colors
                                                                  .white
                                                                  : Colors
                                                                  .orange,
                                                            )),
                                                      ),
                                                    ),
                                                  )
                                                      : Container(
                                                      height: 40,
                                                      decoration:
                                                      BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey
                                                                .withOpacity(
                                                                0.5),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset: const Offset(
                                                                0, 3),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              if (item["CustomerQuantity"] > 0.0)
                                                              {
                                                                if (item["CustomerQuantity"] >= item["StockQuantity"]) {
                                                                  if (q1 < item["StockQuantity"]) {
                                                                    setState(
                                                                            () {
                                                                              q1++;
                                                                              if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                {
                                                                                  if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                    q1 += item['GiftQTY'];
                                                                                    item["Y_Gift_Qty"]++;

                                                                                    y++;


                                                                                  }


                                                                                }









                                                                        });
                                                                    listItemOrder
                                                                        .addItem({
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "StockQuantity":
                                                                      item["StockQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                    listItemOrderImage
                                                                        .addItem({
                                                                      "image":
                                                                      item["ProductcImage"],
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "ProductArName":
                                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                      "ProductEnName":
                                                                      item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                      "StockQuantity":
                                                                      item["StockQuantity"],
                                                                      "CustomerQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                  }
                                                                } else {
                                                                  if (q1 < item["CustomerQuantity"]) {
                                                                    setState(
                                                                            () {
                                                                          q1++;

                                                                          if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                          {
                                                                            if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                              q1 += item['GiftQTY'];
                                                                              item["Y_Gift_Qty"]++;

                                                                              y++;


                                                                            }


                                                                          }
                                                                        });
                                                                    listItemOrder
                                                                        .addItem({
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "StockQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                    listItemOrderImage
                                                                        .addItem({
                                                                      "image":
                                                                      item["ProductcImage"],
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "ProductArName":
                                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                      "ProductEnName":
                                                                      item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                      "StockQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "CustomerQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                  }
                                                                }
                                                              }

                                                              else  if (item["CustomerQtyFree"] > 0.0)
                                                              {

                                                                print('*///*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/');
                                                                print('Q==============================$q1');
                                                                print('y==============================$y');
                                                                print('Q==============================$q1');

                                                                print('*///*/*/*/*/*/*/*/*/*/*/*//*/*/*/*/*/*/*/*/*/*/');



                                                                if (item["CustomerQtyFree"] >= item["StockQuantity"]) {
                                                                  if (q1 < item["StockQuantity"]) {
                                                                    setState(
                                                                            () {
                                                                          q1++;
                                                                          if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                          {
                                                                            if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                              q1 += item['GiftQTY'];
                                                                              item["Y_Gift_Qty"]++;

                                                                              y++;


                                                                            }


                                                                          }









                                                                        });
                                                                    listItemOrder
                                                                        .addItem({
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "StockQuantity":
                                                                      item["StockQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                    listItemOrderImage
                                                                        .addItem({
                                                                      "image":
                                                                      item["ProductcImage"],
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "ProductArName":
                                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                      "ProductEnName":
                                                                      item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                      "StockQuantity":
                                                                      item["StockQuantity"],
                                                                      "CustomerQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                  }
                                                                } else {
                                                                  if (q1 < item["CustomerQtyFree"]) {
                                                                    setState(
                                                                            () {
                                                                          q1++;

                                                                          if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                          {
                                                                            if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                              q1 += item['GiftQTY'];
                                                                              item["Y_Gift_Qty"]++;

                                                                              y++;


                                                                            }


                                                                          }
                                                                        });
                                                                    listItemOrder
                                                                        .addItem({
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "StockQuantity":
                                                                      item["CustomerQtyFree"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                    listItemOrderImage
                                                                        .addItem({
                                                                      "image":
                                                                      item["ProductcImage"],
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "ProductArName":
                                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                      "ProductEnName":
                                                                      item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                      "StockQuantity":
                                                                      item["CustomerQtyFree"],
                                                                      "CustomerQuantity":
                                                                      item["CustomerQtyFree"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                  }
                                                                }
                                                              }


                                                              else {


                                                                if (q1 < item["StockQuantity"]) {
                                                                  setState(
                                                                          () {

                                                                        q1++;
                                                                        // print('Q1 $q1');


                                                                        if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                        {
                                                                          if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                            q1 += item['GiftQTY'];
                                                                            item["Y_Gift_Qty"]++;

                                                                            y++;


                                                                          }


                                                                        }











                                                                      });
                                                                  listItemOrder
                                                                      .addItem({
                                                                    "ItemID":
                                                                    item["ProductID"],
                                                                    "Quantity":
                                                                    q1,
                                                                    "Price":
                                                                    item["PriceAfterDiscount"],
                                                                    "StockQuantity":
                                                                    item["StockQuantity"],
                                                                    "BarCode":
                                                                    item["BarCode"],
                                                                    "Colors_ID":
                                                                    '',
                                                                    "Size_ID":
                                                                    '',
                                                                    "RequiredQTY":item['RequiredQTY'],
                                                                    "GiftQTY":item['GiftQTY'],
                                                                    "Y_Gift_Qty":y,
                                                                  });
                                                                  listItemOrderImage
                                                                      .addItem({
                                                                    "image":
                                                                    item["ProductcImage"],
                                                                    "ItemID":
                                                                    item["ProductID"],
                                                                    "Quantity":
                                                                    q1,
                                                                    "Price":
                                                                    item["PriceAfterDiscount"],
                                                                    "ProductArName":
                                                                    item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                    "ProductEnName":
                                                                    item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                    "StockQuantity":
                                                                    item["StockQuantity"],
                                                                    "CustomerQuantity":
                                                                    item["CustomerQuantity"],
                                                                    "BarCode":
                                                                    item["BarCode"],
                                                                    "Colors_ID":
                                                                    '',
                                                                    "Size_ID":
                                                                    '',
                                                                    "RequiredQTY":item['RequiredQTY'],
                                                                    "GiftQTY":item['GiftQTY'],
                                                                    "Y_Gift_Qty":y,
                                                                  });
                                                                }
                                                              }
                                                            },
                                                            child: Text(
                                                              '+',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                20.sp,
                                                                color: Colors
                                                                    .orange,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontFamily:
                                                                'Monadi',
                                                              ),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              '$q1',
                                                              maxLines: 2,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                16.sp,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontFamily:
                                                                'Monadi',
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              if (q1 > 0) {
                                                                setState(
                                                                        () {
                                                                           q1--;


                                                                        });
                                                              }
                                                              if (q1 ==
                                                                  0) {}
                                                              listItemOrder
                                                                  .decreaseQuantity(
                                                                  item[
                                                                  "BarCode"]);
                                                              listItemOrderImage
                                                                  .decreaseQuantity(
                                                                  item[
                                                                  "BarCode"]);
                                                            },
                                                            child: Text(
                                                              '-',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                20.sp,
                                                                color: Colors
                                                                    .orange,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontFamily:
                                                                'Monadi',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                )
                                              ]),
                                        ),
                                        4.verticalSpace,
                                        (item["DiscountPercent"] == 0)
                                            ? Row(
                                          children: [
                                            Text(
                                              ' ${item["PriceAfterDiscount"]??0000.toStringAsFixed(3)} ',
                                              style: TextStyle(
                                                fontSize:16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            Text(
                                              (appModel.activeLanguage
                                                  .languageCode ==
                                                  'ar')
                                                  ? 'د.ك'
                                                  : 'K.D',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                          ],
                                        )
                                            : Row(
                                          children: [
                                            Text(
                                              '${(item["PriceAfterDiscount"]).toStringAsFixed(3)}',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            Text(
                                              (appModel.activeLanguage
                                                  .languageCode ==
                                                  'ar')
                                                  ? 'د.ك'
                                                  : 'K.D',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            10.horizontalSpace,
                                            Text(
                                              ' ${item["Price"].toStringAsFixed(3)}',
                                              style: TextStyle(
                                                decoration: TextDecoration
                                                    .lineThrough,
                                                color: Colors.red,
                                                decorationThickness: 12.0,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            Text(
                                              'د.ك',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                decoration: TextDecoration
                                                    .lineThrough,
                                                color: Colors.red,
                                                decorationThickness: 12.0,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                          ],
                                        ),
                                        2.verticalSpace,
                                        Expanded(
                                          child: Text(
                                            (appModel.activeLanguage.languageCode ==
                                                'ar')
                                                ?  '${item["ProductArName"]} * ${item['UnitValue'].toString()}'
                                                : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Monadi',

                                            ),

                                          ),
                                        ),
                                        // Row(
                                        //   children: [
                                        //     ProgressIndicatorWidget(
                                        //       minValue: 0,
                                        //       maxValue: 100,
                                        //       currentValue:q1.toInt(),
                                        //     ),
                                        //     Container(
                                        //       padding: EdgeInsets.all(4),
                                        //       child: Text('${item['GiftQTY'] * item["Y_Gift_Qty"]}'),
                                        //       color: Colors.grey,
                                        //    )
                                        //   ],
                                        // ),
                                      ],
                                    ),
                                  ),
                                  if (item["DiscountPercent"] != 0)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(

                                        color: Colors.red,
                                        child:
                                        Center(
                                          child: Text(
                                            '%${item["DiscountPercent"]}خصم',
                                            style: GoogleFonts.tajawal(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),

                                          ),
                                        ),
                                      ),
                                    ),
                                  if (item['GiftQTY']!=0.0)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(

                                        color: Colors.orange,
                                        child: Row(
                                          children: [
                                            Text(
                                              '${item['RequiredQTY']}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              ' + ${item['GiftQTY']} ',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Text(
                                              'مجانا',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                  if (item["StockQuantity"] == 0.0)
                                    Image.asset(AppAssets.OutOfStock),
                                  Positioned(
                                      top: 20,
                                      left: 0,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: item["IsFavorite"] == 1
                                              ? Colors.red
                                              : const Color.fromRGBO(200, 200, 200, 1.0),
                                        ),
                                        onPressed: () {
                                          if (item["IsFavorite"] == 0) {
                                            getDataFavoriteFromApi
                                                .AddItemFavoritePost(
                                                CustomerPhone: '$UserPhone',
                                                ProductID: item["ProductID"]
                                                    .toString());
                                          } else {
                                            deletFavorite.DeleteItemFavoritePost(
                                                ProductId:
                                                item["ProductID"].toString());
                                          }
                                          setState(() {
                                            item["IsFavorite"] =
                                            item["IsFavorite"] == 1 ? 0 : 1;
                                          });
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),
            5.verticalSpace,

            Consumer(builder: (context, ref, child) {
              final getDataFavoriteFromApi = ref.watch(addItemFavoriteProvider);
              final getDataBiggestDiscountFromApi =
              ref.watch(getDataBiggestDiscountFromApiProvider);
              final listItemOrder = ref.watch(orderProviderList);
              final deletFavorite = ref.watch(deleteItemFavoriteProvider);
              final listItemOrderImage = ref.watch(orderProviderListImage);




              return (getDataBiggestDiscountFromApi.BiggestDiscountList.isEmpty||getDataBiggestDiscountFromApi.BiggestDiscountList[0]["ShowGroup"]==0)?const SizedBox():
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? 'الاكثر خصما'
                          : 'Most Offered',
                      style: GoogleFonts.tajawal(
                        fontSize:
                        16.sp,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                  5.verticalSpace,
                  SizedBox(
                    height: 230.h,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                      getDataBiggestDiscountFromApi.BiggestDiscountList.length,
                      itemBuilder: (context, index) {
                        final item = getDataBiggestDiscountFromApi
                            .BiggestDiscountList[index];
                        num q1 = listItemOrder.getQuantity(itemID: item['BarCode']);
                        num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]);
                        return Card(
                          color: Colors.white,
                          child: Container(
                            color: Colors.white,
                            width: 200.w,
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  //getDataFromApi.dataCategoryAllList[index]["productId"]
                                  MaterialPageRoute(
                                      builder: (context) => BannerDetailsPage(
                                        productId: item["ProductID"],
                                        CategoryId: item['CategoryId'],
                                        name: (appModel.activeLanguage
                                            .languageCode ==
                                            'ar')
                                            ? item['ProductArName']
                                            : item['ProductEnName'],
                                        image: item['ProductcImage'],
                                        specification: item['Specification'],
                                      )),
                                );

                                print(item['RequiredQTY']);
                                print(item['GiftQTY']);
                                print(item["CustomerQuantity"]);
                                print(item["CustomerQtyFree"]);
                                print(item["StockQuantity"]);

                              },
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: REdgeInsets.symmetric(horizontal: 8.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Center(
                                          child: Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width,
                                                  height: 130,
                                                  child: Center(
                                                    child: Image.network(
                                                      '${item['ProductcImage']}',
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    if((UserPhoneAll??UserPhone)==null)
                                                    {

                                                      showDialog(
                                                        context: context,
                                                        barrierDismissible: false,
                                                        builder: (_) => AlertDialog(

                                                            content: Text(
                                                              "يرجى ادخال رقم الهاتف",
                                                              style: TextStyle(
                                                                fontSize: 14.sp,
                                                                color: const Color(0xff000000),
                                                                fontWeight: FontWeight.w500,
                                                                fontFamily: 'Monadi',
                                                              ),
                                                            ),
                                                            actions: [

                                                              Form(
                                                                key:keyFormCheckOutOnSystem,
                                                                child: MyStyledTextField(
                                                                  maxLength: 8,
                                                                  keyboardType: TextInputType.phone,
                                                                  label:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',
                                                                  hintText:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',

                                                                  controller: customPhoneGuestController,
                                                                  validator: (value) {
                                                                    if (value!.isEmpty) {
                                                                      return (appModel.activeLanguage.languageCode == 'ar')
                                                                          ? 'هذا الحقل مطلوب'
                                                                          : 'This field is required';
                                                                    } else if (value.length != 8 ||
                                                                        !(value.startsWith('4') ||
                                                                            value.startsWith('5') ||
                                                                            value.startsWith('6') ||
                                                                            value.startsWith('9'))) {
                                                                      return (appModel.activeLanguage.languageCode == 'ar')
                                                                          ? '  رقم الهاتف غير صحيح او الارقام لا تحتوي علي ارقام انجليزية يرجي التأكد   ا'
                                                                          : 'The Mobile Number not correct please check the mobile number';
                                                                    } else {
                                                                      return null;
                                                                    }
                                                                  },
                                                                ),
                                                              ),
                                                              20.verticalSpace,

                                                              TextButton(
                                                                style: ButtonStyle(
                                                                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                                    EdgeInsets.zero,
                                                                  ),
                                                                ),
                                                                onPressed: ()  {



                                                                  if(keyFormCheckOutOnSystem.currentState!.validate()) {

                                                                  }
                                                                  if(UserPhone==null)
                                                                  {
                                                                    UserPhoneAll=customPhoneGuestController.text;
                                                                  }
                                                                  else
                                                                  {
                                                                    UserPhoneAll=UserPhone;
                                                                  }




                                                                  Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => const MainPage(

                                                                      ),
                                                                    ),
                                                                  );

                                                                },
                                                                child: Container(
                                                                  width: 1.sw - 30,
                                                                  height: 40.r,
                                                                  alignment: Alignment.center,
                                                                  decoration: BoxDecoration(
                                                                    color: Colors.orange,
                                                                    borderRadius: BorderRadius.circular(30),

                                                                  ),
                                                                  child:false
                                                                      ? SizedBox(
                                                                    height: 20.r,
                                                                    width: 20.r,
                                                                    child: CircularProgressIndicator(
                                                                      strokeWidth: 3.r,
                                                                      color: AppColors.white,
                                                                    ),
                                                                  )
                                                                      : Text(
                                                                    (appModel.activeLanguage.languageCode == 'ar')?

                                                                    "استمرار":'Continue ',
                                                                    style: GoogleFonts.inter(
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 12.sp,
                                                                      color: AppColors.white,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            ]),
                                                      );

                                                    }
                                                    else
                                                    {
                                                      setState(() {
                                                        isSecondContainerVisibleListBiggestDiscount[
                                                        index] =
                                                        !isSecondContainerVisibleListBiggestDiscount[
                                                        index];
                                                        // isSecondContainerVisible =
                                                        // !isSecondContainerVisible;
                                                      });

                                                      setState(() {
                                                        if (q1 == 0) {
                                                          q1++;

                                                        }
                                                        listItemOrder.addItem({
                                                          "ItemID": item["ProductID"],
                                                          "Quantity": q1,
                                                          "Price": item[
                                                          "PriceAfterDiscount"],
                                                          "StockQuantity":
                                                          item["StockQuantity"],
                                                          "BarCode": item["BarCode"],
                                                          "Colors_ID": '',
                                                          "Size_ID": '',
                                                          "RequiredQTY":item['RequiredQTY'],
                                                          "GiftQTY":item['GiftQTY'],
                                                          "Y_Gift_Qty":y,
                                                        });
                                                        listItemOrderImage.addItem({
                                                          "image":
                                                          item["ProductcImage"],
                                                          "ItemID": item["ProductID"],
                                                          "Quantity": q1,
                                                          "Price": item[
                                                          "PriceAfterDiscount"],
                                                          "ProductArName":
                                                          item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                          "ProductEnName":
                                                          item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                          "StockQuantity":
                                                          item["StockQuantity"],
                                                          "CustomerQuantity":(item["CustomerQuantity"]> 0.0)?
                                                          item["CustomerQuantity"]:item["CustomerQtyFree"],
                                                          "BarCode": item["BarCode"],
                                                          "Colors_ID": '',
                                                          "Size_ID": '',
                                                          "RequiredQTY":item['RequiredQTY'],
                                                          "GiftQTY":item['GiftQTY'],
                                                          "Y_Gift_Qty":y,
                                                        });
                                                      });

                                                      if (isSecondContainerVisibleListBiggestDiscount[
                                                      index]) {
                                                        Future.delayed(
                                                            const Duration(
                                                                milliseconds: 10000),
                                                                () {
                                                              setState(() {
                                                                isSecondContainerVisibleListBiggestDiscount[
                                                                index] = false;
                                                              });
                                                            });
                                                      }
                                                    }


                                                  },
                                                  child:
                                                  !isSecondContainerVisibleListBiggestDiscount[
                                                  index]
                                                      ? Card(
                                                    child: Container(
                                                      height: 40.h,
                                                      width: 35.w,
                                                      color: (q1 >= 1)
                                                          ? Colors.green
                                                          : Colors.white,
                                                      child: Center(
                                                        child: Text(
                                                            (q1 >= 1)
                                                                ? '$q1'
                                                                : '+',
                                                            style:
                                                            TextStyle(
                                                              fontWeight:
                                                              FontWeight
                                                                  .w500,
                                                              fontFamily: 'Monadi',
                                                              fontSize:
                                                              20.sp,
                                                              color: (q1 >=
                                                                  1)
                                                                  ? Colors
                                                                  .white
                                                                  : Colors
                                                                  .orange,
                                                            )),
                                                      ),
                                                    ),
                                                  )
                                                      : Container(
                                                      height: 40,
                                                      decoration:
                                                      BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(
                                                            10),
                                                        boxShadow: [
                                                          BoxShadow(
                                                            color: Colors
                                                                .grey
                                                                .withOpacity(
                                                                0.5),
                                                            spreadRadius: 5,
                                                            blurRadius: 7,
                                                            offset: const Offset(
                                                                0, 3),
                                                          ),
                                                        ],
                                                      ),
                                                      child: Row(
                                                        children: [
                                                          TextButton(
                                                            onPressed: () {
                                                              if (item["CustomerQuantity"] > 0.0)
                                                              {
                                                                if (item["CustomerQuantity"] >= item["StockQuantity"]) {
                                                                  if (q1 < item["StockQuantity"]) {
                                                                    setState(
                                                                            () {
                                                                          q1++;
                                                                          if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                          {
                                                                            if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                              q1 += item['GiftQTY'];
                                                                              item["Y_Gift_Qty"]++;

                                                                              y++;


                                                                            }


                                                                          }









                                                                        });
                                                                    listItemOrder
                                                                        .addItem({
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "StockQuantity":
                                                                      item["StockQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                    listItemOrderImage
                                                                        .addItem({
                                                                      "image":
                                                                      item["ProductcImage"],
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "ProductArName":
                                                                      item["ProductArName"],
                                                                      "ProductEnName":
                                                                      item["ProductEnName"],
                                                                      "StockQuantity":
                                                                      item["StockQuantity"],
                                                                      "CustomerQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                  }
                                                                } else {
                                                                  if (q1 < item["CustomerQuantity"]) {
                                                                    setState(
                                                                            () {
                                                                          q1++;

                                                                          if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                          {
                                                                            if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                              q1 += item['GiftQTY'];
                                                                              item["Y_Gift_Qty"]++;

                                                                              y++;


                                                                            }


                                                                          }
                                                                        });
                                                                    listItemOrder
                                                                        .addItem({
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "StockQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                    listItemOrderImage
                                                                        .addItem({
                                                                      "image":
                                                                      item["ProductcImage"],
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "ProductArName":
                                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                      "ProductEnName":
                                                                      item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                      "StockQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "CustomerQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                  }
                                                                }
                                                              }

                                                              else  if (item["CustomerQtyFree"] > 0.0)
                                                              {
                                                                print('----------------------------------');
                                                                print(item["CustomerQtyFree"]);
                                                                print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');

                                                                if (item["CustomerQtyFree"] >= item["StockQuantity"]) {
                                                                  if (q1 < item["StockQuantity"]) {
                                                                    setState(
                                                                            () {
                                                                          q1++;
                                                                          if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                          {
                                                                            if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                              q1 += item['GiftQTY'];
                                                                              item["Y_Gift_Qty"]++;

                                                                              y++;


                                                                            }


                                                                          }









                                                                        });
                                                                    listItemOrder
                                                                        .addItem({
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "StockQuantity":
                                                                      item["StockQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                    listItemOrderImage
                                                                        .addItem({
                                                                      "image":
                                                                      item["ProductcImage"],
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "ProductArName":
                                                                      item["ProductArName"],
                                                                      "ProductEnName":
                                                                      item["ProductEnName"],
                                                                      "StockQuantity":
                                                                      item["StockQuantity"],
                                                                      "CustomerQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                  }
                                                                } else {
                                                                  if (q1 < item["CustomerQtyFree"]) {
                                                                    setState(
                                                                            () {
                                                                          q1++;

                                                                          if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                          {
                                                                            if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                              q1 += item['GiftQTY'];
                                                                              item["Y_Gift_Qty"]++;

                                                                              y++;


                                                                            }


                                                                          }
                                                                        });
                                                                    listItemOrder
                                                                        .addItem({
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "StockQuantity":
                                                                      item["CustomerQtyFree"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                    listItemOrderImage
                                                                        .addItem({
                                                                      "image":
                                                                      item["ProductcImage"],
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "ProductArName":
                                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                      "ProductEnName":
                                                                      item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                      "StockQuantity":
                                                                      item["CustomerQtyFree"],
                                                                      "CustomerQuantity":
                                                                      item["CustomerQtyFree"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                  }
                                                                }
                                                              }


                                                              else {


                                                                if (q1 < item["StockQuantity"]) {
                                                                  setState(
                                                                          () {

                                                                        q1++;
                                                                        // print('Q1 $q1');


                                                                        if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                        {
                                                                          if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                            q1 += item['GiftQTY'];
                                                                            item["Y_Gift_Qty"]++;

                                                                            y++;


                                                                          }


                                                                        }











                                                                      });
                                                                  listItemOrder
                                                                      .addItem({
                                                                    "ItemID":
                                                                    item["ProductID"],
                                                                    "Quantity":
                                                                    q1,
                                                                    "Price":
                                                                    item["PriceAfterDiscount"],
                                                                    "StockQuantity":
                                                                    item["StockQuantity"],
                                                                    "BarCode":
                                                                    item["BarCode"],
                                                                    "Colors_ID":
                                                                    '',
                                                                    "Size_ID":
                                                                    '',
                                                                    "RequiredQTY":item['RequiredQTY'],
                                                                    "GiftQTY":item['GiftQTY'],
                                                                    "Y_Gift_Qty":y,
                                                                  });
                                                                  listItemOrderImage
                                                                      .addItem({
                                                                    "image":
                                                                    item["ProductcImage"],
                                                                    "ItemID":
                                                                    item["ProductID"],
                                                                    "Quantity":
                                                                    q1,
                                                                    "Price":
                                                                    item["PriceAfterDiscount"],
                                                                    "ProductArName":
                                                                    item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                    "ProductEnName":
                                                                    item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                    "StockQuantity":
                                                                    item["StockQuantity"],
                                                                    "CustomerQuantity":
                                                                    item["CustomerQuantity"],
                                                                    "BarCode":
                                                                    item["BarCode"],
                                                                    "Colors_ID":
                                                                    '',
                                                                    "Size_ID":
                                                                    '',
                                                                    "RequiredQTY":item['RequiredQTY'],
                                                                    "GiftQTY":item['GiftQTY'],
                                                                    "Y_Gift_Qty":y,
                                                                  });
                                                                }
                                                              }
                                                            },
                                                            child: Text(
                                                              '+',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                20.sp,
                                                                color: Colors
                                                                    .orange,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontFamily:
                                                                'Monadi',
                                                              ),
                                                            ),
                                                          ),
                                                          Center(
                                                            child: Text(
                                                              '$q1',
                                                              maxLines: 2,
                                                              overflow:
                                                              TextOverflow
                                                                  .ellipsis,
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                16.sp,
                                                                color: Colors
                                                                    .black,
                                                                fontWeight:
                                                                FontWeight
                                                                    .bold,
                                                                fontFamily:
                                                                'Monadi',
                                                              ),
                                                            ),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              if (q1 > 0) {
                                                                setState(
                                                                        () {
                                                                      q1--;




                                                                    });
                                                              }
                                                              if (q1 ==
                                                                  0) {}
                                                              listItemOrder
                                                                  .decreaseQuantity(
                                                                  item[
                                                                  "BarCode"]);
                                                              listItemOrderImage
                                                                  .decreaseQuantity(
                                                                  item[
                                                                  "BarCode"]);
                                                            },
                                                            child: Text(
                                                              '-',
                                                              style:
                                                              TextStyle(
                                                                fontSize:
                                                                20.sp,
                                                                color: Colors
                                                                    .orange,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontFamily:
                                                                'Monadi',
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      )),
                                                )
                                              ]),
                                        ),
                                        4.verticalSpace,
                                        (item["DiscountPercent"] == 0)
                                            ? Row(
                                          children: [
                                            Text(
                                              ' ${item["PriceAfterDiscount"]??0000.toStringAsFixed(3)} ',
                                              style: TextStyle(
                                                fontSize:16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            Text(
                                              (appModel.activeLanguage
                                                  .languageCode ==
                                                  'ar')
                                                  ? 'د.ك'
                                                  : 'K.D',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                          ],
                                        )
                                            : Row(
                                          children: [
                                            Text(
                                              '${(item["PriceAfterDiscount"]).toStringAsFixed(3)}',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            Text(
                                              (appModel.activeLanguage
                                                  .languageCode ==
                                                  'ar')
                                                  ? 'د.ك'
                                                  : 'K.D',
                                              style: TextStyle(
                                                fontSize: 16.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            10.horizontalSpace,
                                            Text(
                                              ' ${item["Price"].toStringAsFixed(3)}',
                                              style: TextStyle(
                                                decoration: TextDecoration
                                                    .lineThrough,
                                                color: Colors.red,
                                                decorationThickness: 12.0,
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            Text(
                                              'د.ك',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w600,
                                                decoration: TextDecoration
                                                    .lineThrough,
                                                color: Colors.red,
                                                decorationThickness: 12.0,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                          ],
                                        ),
                                        2.verticalSpace,
                                        Expanded(
                                          child: Text(
                                            (appModel.activeLanguage.languageCode ==
                                                'ar')
                                                ? '${item["ProductArName"]} * ${item['UnitValue'].toString()}'
                                                : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Monadi',

                                            ),

                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (item["DiscountPercent"] != 0)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(

                                        color: Colors.red,
                                        child:
                                        Center(
                                          child: Text(
                                            '%${item["DiscountPercent"]}خصم',
                                            style: GoogleFonts.tajawal(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),

                                          ),
                                        ),
                                      ),
                                    ),
                                  if (item['GiftQTY']!=0.0)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(

                                        color: Colors.orange,
                                        child: Row(
                                          children: [
                                            Text(
                                              '${item['RequiredQTY']}',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              ' + ${item['GiftQTY']} ',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const Text(
                                              'مجانا',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  if (item["StockQuantity"] == 0.0)
                                    Image.asset(AppAssets.OutOfStock),
                                  Positioned(
                                      top: 0,
                                      left: 0,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: item["IsFavorite"] == 1
                                              ? Colors.red
                                              : const Color.fromRGBO(200, 200, 200, 1.0),
                                        ),
                                        onPressed: () {
                                          if (item["IsFavorite"] == 0) {
                                            getDataFavoriteFromApi
                                                .AddItemFavoritePost(
                                                CustomerPhone: '$UserPhone',
                                                ProductID: item["ProductID"]
                                                    .toString());
                                          } else {
                                            deletFavorite.DeleteItemFavoritePost(
                                                ProductId:
                                                item["ProductID"].toString());
                                          }
                                          setState(() {
                                            item["IsFavorite"] =
                                            item["IsFavorite"] == 1 ? 0 : 1;
                                          });
                                        },
                                      )),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            }),

            Consumer(builder: (context, ref, child) {
              final getDataFavoriteFromApi = ref.watch(addItemFavoriteProvider);
              final getDataProductVersiontFromApi =
              ref.watch(getDataProductVersionFromApiProvider);
              final deletFavorite = ref.watch(deleteItemFavoriteProvider);
              final listItemOrder = ref.watch(orderProviderList);
              final listItemOrderImage = ref.watch(orderProviderListImage);




              return
                (getDataProductVersiontFromApi.productVersionList.isEmpty||getDataProductVersiontFromApi.productVersionList[0]["ShowGroup"]==0)?const SizedBox():
                Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? 'وصل حديثا'
                          : 'Recently Arrived',
                      style: GoogleFonts.tajawal(
                        fontSize:
                        16.sp,
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),
                  ),
                  5.verticalSpace,
                  SizedBox(
                    height: 230.h,
                    child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount:
                      getDataProductVersiontFromApi.productVersionList.length,
                      itemBuilder: (context, index) {
                        final item =
                        getDataProductVersiontFromApi.productVersionList[index];
                       num q1 = listItemOrder.getQuantity(itemID: item['BarCode']);
                        num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]);
                        return
                          Card(
                            color: Colors.white,
                            child: Container(
                              color: Colors.white,
                              width: 200.w,
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    //getDataFromApi.dataCategoryAllList[index]["productId"]
                                    MaterialPageRoute(
                                        builder: (context) => BannerDetailsPage(
                                          productId: item["ProductID"],
                                          CategoryId: item['CategoryId'],
                                          name: (appModel.activeLanguage
                                              .languageCode ==
                                              'ar')
                                              ? item['ProductArName']
                                              : item['ProductEnName'],
                                          image: item['ProductcImage'],
                                          specification: item['Specification'],
                                        )),
                                  );
                                },
                                child: Stack(
                                  children: [
                                    Padding(
                                      padding: REdgeInsets.symmetric(horizontal: 8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: Stack(
                                                alignment: Alignment.bottomRight,
                                                children: [
                                                  SizedBox(
                                                    width: MediaQuery.of(context)
                                                        .size
                                                        .width,
                                                    height: 130,
                                                    child: Center(
                                                      child: Image.network(
                                                        '${item['ProductcImage']}',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if((UserPhoneAll??UserPhone)==null)
                                                      {

                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          builder: (_) => AlertDialog(

                                                              content: Text(
                                                                "يرجى ادخال رقم الهاتف",
                                                                style: TextStyle(
                                                                  fontSize: 14.sp,
                                                                  color: const Color(0xff000000),
                                                                  fontWeight: FontWeight.w500,
                                                                  fontFamily: 'Monadi',
                                                                ),
                                                              ),
                                                              actions: [

                                                                Form(
                                                                  key:keyFormCheckOutOnSystem,
                                                                  child: MyStyledTextField(
                                                                    maxLength: 8,
                                                                    keyboardType: TextInputType.phone,
                                                                    label:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',
                                                                    hintText:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',

                                                                    controller: customPhoneGuestController,
                                                                    validator: (value) {
                                                                      if (value!.isEmpty) {
                                                                        return (appModel.activeLanguage.languageCode == 'ar')
                                                                            ? 'هذا الحقل مطلوب'
                                                                            : 'This field is required';
                                                                      } else if (value.length != 8 ||
                                                                          !(value.startsWith('4') ||
                                                                              value.startsWith('5') ||
                                                                              value.startsWith('6') ||
                                                                              value.startsWith('9'))) {
                                                                        return (appModel.activeLanguage.languageCode == 'ar')
                                                                            ? '  رقم الهاتف غير صحيح او الارقام لا تحتوي علي ارقام انجليزية يرجي التأكد   ا'
                                                                            : 'The Mobile Number not correct please check the mobile number';
                                                                      } else {
                                                                        return null;
                                                                      }
                                                                    },
                                                                  ),
                                                                ),
                                                                20.verticalSpace,

                                                                TextButton(
                                                                  style: ButtonStyle(
                                                                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                                      EdgeInsets.zero,
                                                                    ),
                                                                  ),
                                                                  onPressed: ()  {



                                                                    if(keyFormCheckOutOnSystem.currentState!.validate()) {

                                                                    }
                                                                    if(UserPhone==null)
                                                                    {
                                                                      UserPhoneAll=customPhoneGuestController.text;
                                                                    }
                                                                    else
                                                                    {
                                                                      UserPhoneAll=UserPhone;
                                                                    }




                                                                    Navigator.pushReplacement(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder: (context) => const MainPage(

                                                                        ),
                                                                      ),
                                                                    );

                                                                  },
                                                                  child: Container(
                                                                    width: 1.sw - 30,
                                                                    height: 40.r,
                                                                    alignment: Alignment.center,
                                                                    decoration: BoxDecoration(
                                                                      color: Colors.orange,
                                                                      borderRadius: BorderRadius.circular(30),

                                                                    ),
                                                                    child:false
                                                                        ? SizedBox(
                                                                      height: 20.r,
                                                                      width: 20.r,
                                                                      child: CircularProgressIndicator(
                                                                        strokeWidth: 3.r,
                                                                        color: AppColors.white,
                                                                      ),
                                                                    )
                                                                        : Text(
                                                                      (appModel.activeLanguage.languageCode == 'ar')?

                                                                      "استمرار":'Continue ',
                                                                      style: GoogleFonts.inter(
                                                                        fontWeight: FontWeight.w600,
                                                                        fontSize: 12.sp,
                                                                        color: AppColors.white,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                        );

                                                      }
                                                      else
                                                      {
                                                        setState(() {
                                                          isSecondContainerProductVersion[
                                                          index] =
                                                          !isSecondContainerProductVersion[
                                                          index];
                                                          // isSecondContainerVisible =
                                                          // !isSecondContainerVisible;
                                                        });

                                                        setState(() {
                                                          if (q1 == 0) {
                                                            q1++;

                                                          }
                                                          listItemOrder.addItem({
                                                            "ItemID": item["ProductID"],
                                                            "Quantity": q1,
                                                            "Price": item[
                                                            "PriceAfterDiscount"],
                                                            "StockQuantity":
                                                            item["StockQuantity"],
                                                            "BarCode": item["BarCode"],
                                                            "Colors_ID": '',
                                                            "Size_ID": '',
                                                            "RequiredQTY":item['RequiredQTY'],
                                                            "GiftQTY":item['GiftQTY'],
                                                            "Y_Gift_Qty":y,
                                                          });
                                                          listItemOrderImage.addItem({
                                                            "image":
                                                            item["ProductcImage"],
                                                            "ItemID": item["ProductID"],
                                                            "Quantity": q1,
                                                            "Price": item[
                                                            "PriceAfterDiscount"],
                                                            "ProductArName":
                                                            item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                            "ProductEnName":
                                                            item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                            "StockQuantity":
                                                            item["StockQuantity"],
                                                            "CustomerQuantity":(item["CustomerQuantity"]> 0.0)?
                                                            item["CustomerQuantity"]:item["CustomerQtyFree"],
                                                            "BarCode": item["BarCode"],
                                                            "Colors_ID": '',
                                                            "Size_ID": '',
                                                            "RequiredQTY":item['RequiredQTY'],
                                                            "GiftQTY":item['GiftQTY'],
                                                            "Y_Gift_Qty":y,
                                                          });
                                                        });

                                                        if (isSecondContainerProductVersion[
                                                        index]) {
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds: 10000),
                                                                  () {
                                                                setState(() {
                                                                  isSecondContainerProductVersion[
                                                                  index] = false;
                                                                });
                                                              });
                                                        }
                                                      }


                                                    },
                                                    child:
                                                    !isSecondContainerProductVersion[
                                                    index]
                                                        ? Card(
                                                      child: Container(
                                                        height: 40.h,
                                                        width: 35.w,
                                                        color: (q1 >= 1)
                                                            ? Colors.green
                                                            : Colors.white,
                                                        child: Center(
                                                          child: Text(
                                                              (q1 >= 1)
                                                                  ? '$q1'
                                                                  : '+',
                                                              style:
                                                              TextStyle(
                                                                fontWeight:
                                                                FontWeight
                                                                    .w500,
                                                                fontFamily: 'Monadi',
                                                                fontSize:
                                                                20.sp,
                                                                color: (q1 >=
                                                                    1)
                                                                    ? Colors
                                                                    .white
                                                                    : Colors
                                                                    .orange,
                                                              )),
                                                        ),
                                                      ),
                                                    )
                                                        : Container(
                                                        height: 40,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              10),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color: Colors
                                                                  .grey
                                                                  .withOpacity(
                                                                  0.5),
                                                              spreadRadius: 5,
                                                              blurRadius: 7,
                                                              offset: const Offset(
                                                                  0, 3),
                                                            ),
                                                          ],
                                                        ),
                                                        child: Row(
                                                          children: [
                                                            TextButton(
                                                              onPressed: () {
                                                                if (item["CustomerQuantity"] > 0.0)
                                                                {
                                                                  if (item["CustomerQuantity"] >= item["StockQuantity"]) {
                                                                    if (q1 < item["StockQuantity"]) {
                                                                      setState(
                                                                              () {
                                                                            q1++;
                                                                            if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                            {
                                                                              if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                q1 += item['GiftQTY'];
                                                                                item["Y_Gift_Qty"]++;

                                                                                y++;


                                                                              }


                                                                            }









                                                                          });
                                                                      listItemOrder
                                                                          .addItem({
                                                                        "ItemID":
                                                                        item["ProductID"],
                                                                        "Quantity":
                                                                        q1,
                                                                        "Price":
                                                                        item["PriceAfterDiscount"],
                                                                        "StockQuantity":
                                                                        item["StockQuantity"],
                                                                        "BarCode":
                                                                        item["BarCode"],
                                                                        "Colors_ID":
                                                                        '',
                                                                        "Size_ID":
                                                                        '',
                                                                        "RequiredQTY":item['RequiredQTY'],
                                                                        "GiftQTY":item['GiftQTY'],
                                                                        "Y_Gift_Qty":y,
                                                                      });
                                                                      listItemOrderImage
                                                                          .addItem({
                                                                        "image":
                                                                        item["ProductcImage"],
                                                                        "ItemID":
                                                                        item["ProductID"],
                                                                        "Quantity":
                                                                        q1,
                                                                        "Price":
                                                                        item["PriceAfterDiscount"],
                                                                        "ProductArName":
                                                                        item["ProductArName"],
                                                                        "ProductEnName":
                                                                        item["ProductEnName"],
                                                                        "StockQuantity":
                                                                        item["StockQuantity"],
                                                                        "CustomerQuantity":
                                                                        item["CustomerQuantity"],
                                                                        "BarCode":
                                                                        item["BarCode"],
                                                                        "Colors_ID":
                                                                        '',
                                                                        "Size_ID":
                                                                        '',
                                                                        "RequiredQTY":item['RequiredQTY'],
                                                                        "GiftQTY":item['GiftQTY'],
                                                                        "Y_Gift_Qty":y,
                                                                      });
                                                                    }
                                                                  } else {
                                                                    if (q1 < item["CustomerQuantity"]) {
                                                                      setState(
                                                                              () {
                                                                            q1++;

                                                                            if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                            {
                                                                              if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                q1 += item['GiftQTY'];
                                                                                item["Y_Gift_Qty"]++;

                                                                                y++;


                                                                              }


                                                                            }
                                                                          });
                                                                      listItemOrder
                                                                          .addItem({
                                                                        "ItemID":
                                                                        item["ProductID"],
                                                                        "Quantity":
                                                                        q1,
                                                                        "Price":
                                                                        item["PriceAfterDiscount"],
                                                                        "StockQuantity":
                                                                        item["CustomerQuantity"],
                                                                        "BarCode":
                                                                        item["BarCode"],
                                                                        "Colors_ID":
                                                                        '',
                                                                        "Size_ID":
                                                                        '',
                                                                        "RequiredQTY":item['RequiredQTY'],
                                                                        "GiftQTY":item['GiftQTY'],
                                                                        "Y_Gift_Qty":y,
                                                                      });
                                                                      listItemOrderImage
                                                                          .addItem({
                                                                        "image":
                                                                        item["ProductcImage"],
                                                                        "ItemID":
                                                                        item["ProductID"],
                                                                        "Quantity":
                                                                        q1,
                                                                        "Price":
                                                                        item["PriceAfterDiscount"],
                                                                        "ProductArName":
                                                                        item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                        "ProductEnName":
                                                                        item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                        "StockQuantity":
                                                                        item["CustomerQuantity"],
                                                                        "CustomerQuantity":
                                                                        item["CustomerQuantity"],
                                                                        "BarCode":
                                                                        item["BarCode"],
                                                                        "Colors_ID":
                                                                        '',
                                                                        "Size_ID":
                                                                        '',
                                                                        "RequiredQTY":item['RequiredQTY'],
                                                                        "GiftQTY":item['GiftQTY'],
                                                                        "Y_Gift_Qty":y,
                                                                      });
                                                                    }
                                                                  }
                                                                }

                                                                else  if (item["CustomerQtyFree"] > 0.0)
                                                                {
                                                                  print('----------------------------------');
                                                                  print(item["CustomerQtyFree"]);
                                                                  print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');

                                                                  if (item["CustomerQtyFree"] >= item["StockQuantity"]) {
                                                                    if (q1 < item["StockQuantity"]) {
                                                                      setState(
                                                                              () {
                                                                            q1++;
                                                                            if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                            {
                                                                              if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                q1 += item['GiftQTY'];
                                                                                item["Y_Gift_Qty"]++;

                                                                                y++;


                                                                              }


                                                                            }









                                                                          });
                                                                      listItemOrder
                                                                          .addItem({
                                                                        "ItemID":
                                                                        item["ProductID"],
                                                                        "Quantity":
                                                                        q1,
                                                                        "Price":
                                                                        item["PriceAfterDiscount"],
                                                                        "StockQuantity":
                                                                        item["StockQuantity"],
                                                                        "BarCode":
                                                                        item["BarCode"],
                                                                        "Colors_ID":
                                                                        '',
                                                                        "Size_ID":
                                                                        '',
                                                                        "RequiredQTY":item['RequiredQTY'],
                                                                        "GiftQTY":item['GiftQTY'],
                                                                        "Y_Gift_Qty":y,
                                                                      });
                                                                      listItemOrderImage
                                                                          .addItem({
                                                                        "image":
                                                                        item["ProductcImage"],
                                                                        "ItemID":
                                                                        item["ProductID"],
                                                                        "Quantity":
                                                                        q1,
                                                                        "Price":
                                                                        item["PriceAfterDiscount"],
                                                                        "ProductArName":
                                                                        item["ProductArName"],
                                                                        "ProductEnName":
                                                                        item["ProductEnName"],
                                                                        "StockQuantity":
                                                                        item["StockQuantity"],
                                                                        "CustomerQuantity":
                                                                        item["CustomerQuantity"],
                                                                        "BarCode":
                                                                        item["BarCode"],
                                                                        "Colors_ID":
                                                                        '',
                                                                        "Size_ID":
                                                                        '',
                                                                        "RequiredQTY":item['RequiredQTY'],
                                                                        "GiftQTY":item['GiftQTY'],
                                                                        "Y_Gift_Qty":y,
                                                                      });
                                                                    }
                                                                  } else {
                                                                    if (q1 < item["CustomerQtyFree"]) {
                                                                      setState(
                                                                              () {
                                                                            q1++;

                                                                            if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                            {
                                                                              if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                q1 += item['GiftQTY'];
                                                                                item["Y_Gift_Qty"]++;

                                                                                y++;


                                                                              }


                                                                            }
                                                                          });
                                                                      listItemOrder
                                                                          .addItem({
                                                                        "ItemID":
                                                                        item["ProductID"],
                                                                        "Quantity":
                                                                        q1,
                                                                        "Price":
                                                                        item["PriceAfterDiscount"],
                                                                        "StockQuantity":
                                                                        item["CustomerQtyFree"],
                                                                        "BarCode":
                                                                        item["BarCode"],
                                                                        "Colors_ID":
                                                                        '',
                                                                        "Size_ID":
                                                                        '',
                                                                        "RequiredQTY":item['RequiredQTY'],
                                                                        "GiftQTY":item['GiftQTY'],
                                                                        "Y_Gift_Qty":y,
                                                                      });
                                                                      listItemOrderImage
                                                                          .addItem({
                                                                        "image":
                                                                        item["ProductcImage"],
                                                                        "ItemID":
                                                                        item["ProductID"],
                                                                        "Quantity":
                                                                        q1,
                                                                        "Price":
                                                                        item["PriceAfterDiscount"],
                                                                        "ProductArName":
                                                                        item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                        "ProductEnName":
                                                                        item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                        "StockQuantity":
                                                                        item["CustomerQtyFree"],
                                                                        "CustomerQuantity":
                                                                        item["CustomerQtyFree"],
                                                                        "BarCode":
                                                                        item["BarCode"],
                                                                        "Colors_ID":
                                                                        '',
                                                                        "Size_ID":
                                                                        '',
                                                                        "RequiredQTY":item['RequiredQTY'],
                                                                        "GiftQTY":item['GiftQTY'],
                                                                        "Y_Gift_Qty":y,
                                                                      });
                                                                    }
                                                                  }
                                                                }


                                                                else {


                                                                  if (q1 < item["StockQuantity"]) {
                                                                    setState(
                                                                            () {

                                                                          q1++;
                                                                          // print('Q1 $q1');


                                                                          if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                          {
                                                                            if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                              q1 += item['GiftQTY'];
                                                                              item["Y_Gift_Qty"]++;

                                                                              y++;


                                                                            }


                                                                          }











                                                                        });
                                                                    listItemOrder
                                                                        .addItem({
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "StockQuantity":
                                                                      item["StockQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                    listItemOrderImage
                                                                        .addItem({
                                                                      "image":
                                                                      item["ProductcImage"],
                                                                      "ItemID":
                                                                      item["ProductID"],
                                                                      "Quantity":
                                                                      q1,
                                                                      "Price":
                                                                      item["PriceAfterDiscount"],
                                                                      "ProductArName":
                                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                                      "ProductEnName":
                                                                      item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                      "StockQuantity":
                                                                      item["StockQuantity"],
                                                                      "CustomerQuantity":
                                                                      item["CustomerQuantity"],
                                                                      "BarCode":
                                                                      item["BarCode"],
                                                                      "Colors_ID":
                                                                      '',
                                                                      "Size_ID":
                                                                      '',
                                                                      "RequiredQTY":item['RequiredQTY'],
                                                                      "GiftQTY":item['GiftQTY'],
                                                                      "Y_Gift_Qty":y,
                                                                    });
                                                                  }
                                                                }
                                                              },
                                                              child: Text(
                                                                '+',
                                                                style:
                                                                TextStyle(
                                                                  fontSize:
                                                                  20.sp,
                                                                  color: Colors
                                                                      .orange,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontFamily:
                                                                  'Monadi',
                                                                ),
                                                              ),
                                                            ),
                                                            Center(
                                                              child: Text(
                                                                '$q1',
                                                                maxLines: 2,
                                                                overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                                style:
                                                                TextStyle(
                                                                  fontSize:
                                                                  16.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                                  fontFamily:
                                                                  'Monadi',
                                                                ),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                if (q1 > 0) {
                                                                  setState(
                                                                          () {
                                                                        q1--;




                                                                      });
                                                                }
                                                                if (q1 ==
                                                                    0) {}
                                                                listItemOrder
                                                                    .decreaseQuantity(
                                                                    item[
                                                                    "BarCode"]);
                                                                listItemOrderImage
                                                                    .decreaseQuantity(
                                                                    item[
                                                                    "BarCode"]);
                                                              },
                                                              child: Text(
                                                                '-',
                                                                style:
                                                                TextStyle(
                                                                  fontSize:
                                                                  20.sp,
                                                                  color: Colors
                                                                      .orange,
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontFamily:
                                                                  'Monadi',
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  )
                                                ]),
                                          ),
                                          4.verticalSpace,
                                          (item["DiscountPercent"] == 0)
                                              ? Row(
                                            children: [
                                              Text(
                                                ' ${item["PriceAfterDiscount"]??0000.toStringAsFixed(3)} ',
                                                style: TextStyle(
                                                  fontSize:16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                              Text(
                                                (appModel.activeLanguage
                                                    .languageCode ==
                                                    'ar')
                                                    ? 'د.ك'
                                                    : 'K.D',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                            ],
                                          )
                                              : Row(
                                            children: [
                                              Text(
                                                '${(item["PriceAfterDiscount"]).toStringAsFixed(3)}',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                              Text(
                                                (appModel.activeLanguage
                                                    .languageCode ==
                                                    'ar')
                                                    ? 'د.ك'
                                                    : 'K.D',
                                                style: TextStyle(
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                              10.horizontalSpace,
                                              Text(
                                                ' ${item["Price"].toStringAsFixed(3)}',
                                                style: TextStyle(
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.red,
                                                  decorationThickness: 12.0,
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                              Text(
                                                'د.ك',
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                  fontWeight: FontWeight.w600,
                                                  decoration: TextDecoration
                                                      .lineThrough,
                                                  color: Colors.red,
                                                  decorationThickness: 12.0,
                                                  fontFamily: 'Monadi',
                                                ),
                                              ),
                                            ],
                                          ),
                                          2.verticalSpace,
                                          Expanded(
                                            child: Text(
                                              (appModel.activeLanguage.languageCode ==
                                                  'ar')
                                                  ? '${item["ProductArName"]} * ${item['UnitValue'].toString()}'
                                                  : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Monadi',

                                              ),

                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    if (item["DiscountPercent"] != 0)
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(

                                          color: Colors.red,
                                          child:
                                          Center(
                                            child: Text(
                                              '%${item["DiscountPercent"]}خصم',
                                              style: GoogleFonts.tajawal(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                              ),

                                            ),
                                          ),
                                        ),
                                      ),
                                    if (item['GiftQTY']!=0.0)
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Container(

                                          color: Colors.orange,
                                          child: Row(
                                            children: [
                                              Text(
                                                '${item['RequiredQTY']}',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                ' + ${item['GiftQTY']} ',
                                                style: const TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const Text(
                                                'مجانا',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    if (item["StockQuantity"] == 0.0)
                                      Image.asset(AppAssets.OutOfStock),
                                    Positioned(
                                        top: 0,
                                        left: 0,
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.favorite,
                                            color: item["IsFavorite"] == 1
                                                ? Colors.red
                                                : const Color.fromRGBO(200, 200, 200, 1.0),
                                          ),
                                          onPressed: () {
                                            if (item["IsFavorite"] == 0) {
                                              getDataFavoriteFromApi
                                                  .AddItemFavoritePost(
                                                  CustomerPhone: '$UserPhone',
                                                  ProductID: item["ProductID"]
                                                      .toString());
                                            } else {
                                              deletFavorite.DeleteItemFavoritePost(
                                                  ProductId:
                                                  item["ProductID"].toString());
                                            }
                                            setState(() {
                                              item["IsFavorite"] =
                                              item["IsFavorite"] == 1 ? 0 : 1;
                                            });
                                          },
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                      },
                    ),
                  ),
                ],
              );
            }),
            5.verticalSpace,
            Consumer(builder: (context, ref, child) {
              final getDataOferTwoFromApi =
              ref.watch(getDataOverOneFromApiProvider);
              final listItemOrder = ref.watch(orderProviderList);
              final listItemOrderImage = ref.watch(orderProviderListImage);
              final getDataFavoriteFromApi = ref.watch(addItemFavoriteProvider);
              final deletFavorite = ref.watch(deleteItemFavoriteProvider);

              if (getDataOferTwoFromApi.overOneList.isEmpty) {
                return

                  const SizedBox();
              } else {
                return


                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context,index)
                    {
                      return const SizedBox(height: 5,);
                    },
                    itemCount: getDataOferTwoFromApi.overOneList.length,
                    itemBuilder: (context,indexOne)
                    {
                      return   (getDataOferTwoFromApi.overOneList.isEmpty||getDataOferTwoFromApi.overOneList[indexOne]["ShowOffer"]==1)?
                      const SizedBox():
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Text(
                              (appModel.activeLanguage.languageCode == 'ar')
                                  ? '${getDataOferTwoFromApi.overOneList[indexOne]["OfferName"]??''}'
                                  : '${getDataOferTwoFromApi.overOneList[indexOne]["OfferName"]??''}',
                              style: GoogleFonts.tajawal(
                                fontSize:
                                16.sp,
                                fontWeight:
                                FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 230.h,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: getDataOferTwoFromApi.overOneList[indexOne]["_OfferItems"].length,
                              itemBuilder: (context, index) {
                                final item =getDataOferTwoFromApi.overOneList[indexOne]["_OfferItems"][index];
                                num q1 = listItemOrder.getQuantity(
                                    itemID: item['BarCode']??1);
                                num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]??1);
                                return Card(
                                  color: Colors.white,
                                  child: Container(
                                    color: Colors.white,
                                    width: 200.w,
                                    child: InkWell(
                                      onTap: () {

                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => BannerDetailsPage(
                                                productId: item["ProductID"],
                                                CategoryId: item['CategoryId'],
                                                name: (appModel.activeLanguage
                                                    .languageCode ==
                                                    'ar')
                                                    ?item["ProductName"]
                                                    : item['ProductEnName'],
                                                image: item['ProductcImage'],
                                                specification:
                                                item['Specification'],
                                              )),
                                        );
                                      },
                                      child: Stack(
                                        children: [
                                          Padding(
                                            padding: REdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Center(
                                                  child: Stack(
                                                      alignment:
                                                      Alignment.bottomRight,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                          MediaQuery.of(context)
                                                              .size
                                                              .width,
                                                          height: 130,
                                                          child: Center(
                                                            child: Image.network(
                                                              '${item['ProductcImage']}',
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        GestureDetector(
                                                          onTap: () {
                                                            if((UserPhoneAll??UserPhone)==null)
                                                            {

                                                              showDialog(
                                                                context: context,
                                                                barrierDismissible: false,
                                                                builder: (_) => AlertDialog(

                                                                    content: Text(
                                                                      "يرجى ادخال رقم الهاتف",
                                                                      style: TextStyle(
                                                                        fontSize: 14.sp,
                                                                        color: const Color(0xff000000),
                                                                        fontWeight: FontWeight.w500,
                                                                        fontFamily: 'Monadi',
                                                                      ),
                                                                    ),
                                                                    actions: [

                                                                      Form(
                                                                        key:keyFormCheckOutOnSystem,
                                                                        child: MyStyledTextField(
                                                                          maxLength: 8,
                                                                          keyboardType: TextInputType.phone,
                                                                          label:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',
                                                                          hintText:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',

                                                                          controller: customPhoneGuestController,
                                                                          validator: (value) {
                                                                            if (value!.isEmpty) {
                                                                              return (appModel.activeLanguage.languageCode == 'ar')
                                                                                  ? 'هذا الحقل مطلوب'
                                                                                  : 'This field is required';
                                                                            } else if (value.length != 8 ||
                                                                                !(value.startsWith('4') ||
                                                                                    value.startsWith('5') ||
                                                                                    value.startsWith('6') ||
                                                                                    value.startsWith('9'))) {
                                                                              return (appModel.activeLanguage.languageCode == 'ar')
                                                                                  ? '  رقم الهاتف غير صحيح او الارقام لا تحتوي علي ارقام انجليزية يرجي التأكد   ا'
                                                                                  : 'The Mobile Number not correct please check the mobile number';
                                                                            } else {
                                                                              return null;
                                                                            }
                                                                          },
                                                                        ),
                                                                      ),
                                                                      20.verticalSpace,

                                                                      TextButton(
                                                                        style: ButtonStyle(
                                                                          padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                                            EdgeInsets.zero,
                                                                          ),
                                                                        ),
                                                                        onPressed: ()  {



                                                                          if(keyFormCheckOutOnSystem.currentState!.validate()) {

                                                                          }
                                                                          if(UserPhone==null)
                                                                          {
                                                                            UserPhoneAll=customPhoneGuestController.text;
                                                                          }
                                                                          else
                                                                          {
                                                                            UserPhoneAll=UserPhone;
                                                                          }




                                                                          Navigator.pushReplacement(
                                                                            context,
                                                                            MaterialPageRoute(
                                                                              builder: (context) => const MainPage(

                                                                              ),
                                                                            ),
                                                                          );

                                                                        },
                                                                        child: Container(
                                                                          width: 1.sw - 30,
                                                                          height: 40.r,
                                                                          alignment: Alignment.center,
                                                                          decoration: BoxDecoration(
                                                                            color: Colors.orange,
                                                                            borderRadius: BorderRadius.circular(30),

                                                                          ),
                                                                          child:false
                                                                              ? SizedBox(
                                                                            height: 20.r,
                                                                            width: 20.r,
                                                                            child: CircularProgressIndicator(
                                                                              strokeWidth: 3.r,
                                                                              color: AppColors.white,
                                                                            ),
                                                                          )
                                                                              : Text(
                                                                            (appModel.activeLanguage.languageCode == 'ar')?

                                                                            "استمرار":'Continue ',
                                                                            style: GoogleFonts.inter(
                                                                              fontWeight: FontWeight.w600,
                                                                              fontSize: 12.sp,
                                                                              color: AppColors.white,
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ]),
                                                              );

                                                            }
                                                            else
                                                            {
                                                              setState(() {
                                                                isSecondContainerVisibleList1[indexOne][
                                                                index] =
                                                                !isSecondContainerVisibleList1[indexOne][
                                                                index];
                                                                // isSecondContainerVisible =
                                                                // !isSecondContainerVisible;
                                                              });

                                                              setState(() {
                                                                if (q1 == 0) {
                                                                  q1++;

                                                                }
                                                                listItemOrder.addItem({
                                                                  "ItemID": item["ProductID"],
                                                                  "Quantity": q1,
                                                                  "Price": item[
                                                                  "PriceAfterDiscount"],
                                                                  "StockQuantity":
                                                                  item["StockQuantity"],
                                                                  "BarCode": item["BarCode"],
                                                                  "Colors_ID": '',
                                                                  "Size_ID": '',
                                                                  "RequiredQTY":item['RequiredQTY'],
                                                                  "GiftQTY":item['GiftQTY'],
                                                                  "Y_Gift_Qty":y,
                                                                });
                                                                listItemOrderImage.addItem({
                                                                  "image":
                                                                  item["ProductcImage"],
                                                                  "ItemID": item["ProductID"],
                                                                  "Quantity": q1,
                                                                  "Price": item[
                                                                  "PriceAfterDiscount"],
                                                                  "ProductArName":
                                                                  item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                  "ProductEnName":
                                                                  item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                  "StockQuantity":
                                                                  item["StockQuantity"],
                                                                  "CustomerQuantity":(item["CustomerQuantity"]> 0.0)?
                                                                  item["CustomerQuantity"]:item["CustomerQtyFree"],
                                                                  "BarCode": item["BarCode"],
                                                                  "Colors_ID": '',
                                                                  "Size_ID": '',
                                                                  "RequiredQTY":item['RequiredQTY'],
                                                                  "GiftQTY":item['GiftQTY'],
                                                                  "Y_Gift_Qty":y,
                                                                });
                                                              });

                                                              if (isSecondContainerVisibleList1[indexOne][
                                                              index]) {
                                                                Future.delayed(
                                                                    const Duration(
                                                                        milliseconds: 10000),
                                                                        () {
                                                                      setState(() {
                                                                        isSecondContainerVisibleList1[indexOne][
                                                                        index] = false;
                                                                      });
                                                                    });
                                                              }
                                                            }


                                                          },
                                                          child:
                                                          !isSecondContainerVisibleList1[indexOne][
                                                          index]
                                                              ? Card(
                                                            child: Container(
                                                              height: 40.h,
                                                              width: 35.w,
                                                              color: (q1 >= 1)
                                                                  ? Colors.green
                                                                  : Colors.white,
                                                              child: Center(
                                                                child: Text(
                                                                    (q1 >= 1)
                                                                        ? '$q1'
                                                                        : '+',
                                                                    style:
                                                                    TextStyle(
                                                                      fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                      fontFamily: 'Monadi',
                                                                      fontSize:
                                                                      20.sp,
                                                                      color: (q1 >=
                                                                          1)
                                                                          ? Colors
                                                                          .white
                                                                          : Colors
                                                                          .orange,
                                                                    )),
                                                              ),
                                                            ),
                                                          )
                                                              : Container(
                                                              height: 40,
                                                              decoration:
                                                              BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                    10),
                                                                boxShadow: [
                                                                  BoxShadow(
                                                                    color: Colors
                                                                        .grey
                                                                        .withOpacity(
                                                                        0.5),
                                                                    spreadRadius: 5,
                                                                    blurRadius: 7,
                                                                    offset: const Offset(
                                                                        0, 3),
                                                                  ),
                                                                ],
                                                              ),
                                                              child: Row(
                                                                children: [
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      if (item["CustomerQuantity"] > 0.0)
                                                                      {
                                                                        if (item["CustomerQuantity"] >= item["StockQuantity"]) {
                                                                          if (q1 < item["StockQuantity"]) {
                                                                            setState(
                                                                                    () {
                                                                                  q1++;
                                                                                  if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                  {
                                                                                    if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                      q1 += item['GiftQTY'];
                                                                                      item["Y_Gift_Qty"]++;

                                                                                      y++;


                                                                                    }


                                                                                  }









                                                                                });
                                                                            listItemOrder
                                                                                .addItem({
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "StockQuantity":
                                                                              item["StockQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                            listItemOrderImage
                                                                                .addItem({
                                                                              "image":
                                                                              item["ProductcImage"],
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "ProductArName":
                                                                              item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                              "ProductEnName":
                                                                              item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                              "StockQuantity":
                                                                              item["StockQuantity"],
                                                                              "CustomerQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                          }
                                                                        } else {
                                                                          if (q1 < item["CustomerQuantity"]) {
                                                                            setState(
                                                                                    () {
                                                                                  q1++;

                                                                                  if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                  {
                                                                                    if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                      q1 += item['GiftQTY'];
                                                                                      item["Y_Gift_Qty"]++;

                                                                                      y++;


                                                                                    }


                                                                                  }
                                                                                });
                                                                            listItemOrder
                                                                                .addItem({
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "StockQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                            listItemOrderImage
                                                                                .addItem({
                                                                              "image":
                                                                              item["ProductcImage"],
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "ProductArName":
                                                                              item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                              "ProductEnName":
                                                                              item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                              "StockQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "CustomerQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                          }
                                                                        }
                                                                      }

                                                                      else  if (item["CustomerQtyFree"] > 0.0)
                                                                      {
                                                                        print('----------------------------------');
                                                                        print(item["CustomerQtyFree"]);
                                                                        print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');

                                                                        if (item["CustomerQtyFree"] >= item["StockQuantity"]) {
                                                                          if (q1 < item["StockQuantity"]) {
                                                                            setState(
                                                                                    () {
                                                                                  q1++;
                                                                                  if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                  {
                                                                                    if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                      q1 += item['GiftQTY'];
                                                                                      item["Y_Gift_Qty"]++;

                                                                                      y++;


                                                                                    }


                                                                                  }









                                                                                });
                                                                            listItemOrder
                                                                                .addItem({
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "StockQuantity":
                                                                              item["StockQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                            listItemOrderImage
                                                                                .addItem({
                                                                              "image":
                                                                              item["ProductcImage"],
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "ProductArName":
                                                                              item["ProductName"]+' * '+item['UnitValue'].toString(),
                                                                              "ProductEnName":
                                                                              item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                              "StockQuantity":
                                                                              item["StockQuantity"],
                                                                              "CustomerQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                          }
                                                                        } else {
                                                                          if (q1 < item["CustomerQtyFree"]) {
                                                                            setState(
                                                                                    () {
                                                                                  q1++;

                                                                                  if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                  {
                                                                                    if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                      q1 += item['GiftQTY'];
                                                                                      item["Y_Gift_Qty"]++;

                                                                                      y++;


                                                                                    }


                                                                                  }
                                                                                });
                                                                            listItemOrder
                                                                                .addItem({
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "StockQuantity":
                                                                              item["CustomerQtyFree"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                            listItemOrderImage
                                                                                .addItem({
                                                                              "image":
                                                                              item["ProductcImage"],
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "ProductArName":
                                                                              item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                              "ProductEnName":
                                                                              item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                              "StockQuantity":
                                                                              item["CustomerQtyFree"],
                                                                              "CustomerQuantity":
                                                                              item["CustomerQtyFree"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                          }
                                                                        }
                                                                      }


                                                                      else {


                                                                        if (q1 < item["StockQuantity"]) {
                                                                          setState(
                                                                                  () {

                                                                                q1++;
                                                                                // print('Q1 $q1');


                                                                                if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                {
                                                                                  if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                    q1 += item['GiftQTY'];
                                                                                    item["Y_Gift_Qty"]++;

                                                                                    y++;


                                                                                  }


                                                                                }











                                                                              });
                                                                          listItemOrder
                                                                              .addItem({
                                                                            "ItemID":
                                                                            item["ProductID"],
                                                                            "Quantity":
                                                                            q1,
                                                                            "Price":
                                                                            item["PriceAfterDiscount"],
                                                                            "StockQuantity":
                                                                            item["StockQuantity"],
                                                                            "BarCode":
                                                                            item["BarCode"],
                                                                            "Colors_ID":
                                                                            '',
                                                                            "Size_ID":
                                                                            '',
                                                                            "RequiredQTY":item['RequiredQTY'],
                                                                            "GiftQTY":item['GiftQTY'],
                                                                            "Y_Gift_Qty":y,
                                                                          });
                                                                          listItemOrderImage
                                                                              .addItem({
                                                                            "image":
                                                                            item["ProductcImage"],
                                                                            "ItemID":
                                                                            item["ProductID"],
                                                                            "Quantity":
                                                                            q1,
                                                                            "Price":
                                                                            item["PriceAfterDiscount"],
                                                                            "ProductArName":
                                                                            item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                            "ProductEnName":
                                                                            item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                            "StockQuantity":
                                                                            item["StockQuantity"],
                                                                            "CustomerQuantity":
                                                                            item["CustomerQuantity"],
                                                                            "BarCode":
                                                                            item["BarCode"],
                                                                            "Colors_ID":
                                                                            '',
                                                                            "Size_ID":
                                                                            '',
                                                                            "RequiredQTY":item['RequiredQTY'],
                                                                            "GiftQTY":item['GiftQTY'],
                                                                            "Y_Gift_Qty":y,
                                                                          });
                                                                        }
                                                                      }
                                                                    },
                                                                    child: Text(
                                                                      '+',
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        20.sp,
                                                                        color: Colors
                                                                            .orange,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontFamily:
                                                                        'Monadi',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Center(
                                                                    child: Text(
                                                                      '$q1',
                                                                      maxLines: 2,
                                                                      overflow:
                                                                      TextOverflow
                                                                          .ellipsis,
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        16.sp,
                                                                        color: Colors
                                                                            .black,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                        fontFamily:
                                                                        'Monadi',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  TextButton(
                                                                    onPressed: () {
                                                                      if (q1 > 0) {
                                                                        setState(
                                                                                () {
                                                                              q1--;




                                                                            });
                                                                      }
                                                                      if (q1 ==
                                                                          0) {}
                                                                      listItemOrder
                                                                          .decreaseQuantity(
                                                                          item[
                                                                          "BarCode"]);
                                                                      listItemOrderImage
                                                                          .decreaseQuantity(
                                                                          item[
                                                                          "BarCode"]);
                                                                    },
                                                                    child: Text(
                                                                      '-',
                                                                      style:
                                                                      TextStyle(
                                                                        fontSize:
                                                                        20.sp,
                                                                        color: Colors
                                                                            .orange,
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontFamily:
                                                                        'Monadi',
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                        )
                                                      ]),
                                                ),
                                                (item["DiscountPercent"] == 0)
                                                    ? Row(
                                                  children: [
                                                    Text(
                                                      ' ${item["PriceAfterDiscount"]??0000.toStringAsFixed(3)} ',
                                                      style: TextStyle(
                                                        fontSize:16.sp,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                    Text(
                                                      (appModel.activeLanguage
                                                          .languageCode ==
                                                          'ar')
                                                          ? 'د.ك'
                                                          : 'K.D',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                  ],
                                                )
                                                    : Row(
                                                  children: [
                                                    Text(
                                                      '${(item["PriceAfterDiscount"]).toStringAsFixed(3)}',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                    Text(
                                                      (appModel.activeLanguage
                                                          .languageCode ==
                                                          'ar')
                                                          ? 'د.ك'
                                                          : 'K.D',
                                                      style: TextStyle(
                                                        fontSize: 16.sp,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                    10.horizontalSpace,
                                                    Text(
                                                      ' ${item["Price"].toStringAsFixed(3)}',
                                                      style: TextStyle(
                                                        decoration: TextDecoration
                                                            .lineThrough,
                                                        color: Colors.red,
                                                        decorationThickness: 12.0,
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                    Text(
                                                      'د.ك',
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.w600,
                                                        decoration: TextDecoration
                                                            .lineThrough,
                                                        color: Colors.red,
                                                        decorationThickness: 12.0,
                                                        fontFamily: 'Monadi',
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                2.verticalSpace,
                                                Expanded(
                                                  child: Text(
                                                    (appModel.activeLanguage.languageCode ==
                                                        'ar')
                                                        ? '${item["ProductName"]} * ${item['UnitValue'].toString()}'
                                                        : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight: FontWeight.bold,
                                                      fontFamily: 'Monadi',

                                                    ),

                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          if (item["DiscountPercent"] != 0)
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(

                                                color: Colors.red,
                                                child:
                                                Center(
                                                  child: Text(
                                                    '%${item["DiscountPercent"]}خصم',
                                                    style: GoogleFonts.tajawal(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),

                                                  ),
                                                ),
                                              ),
                                            ),
                                          if (item['GiftQTY']!=0.0)
                                            Positioned(
                                              top: 0,
                                              right: 0,
                                              child: Container(

                                                color: Colors.orange,
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      '${item['RequiredQTY']}',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text(
                                                      ' + ${item['GiftQTY']} ',
                                                      style: const TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    const Text(
                                                      'مجانا',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          if (item["StockQuantity"] == 0)
                                            Image.asset(AppAssets.OutOfStock),
                                          Positioned(
                                              top: 0,
                                              left: 0,
                                              child: IconButton(
                                                icon: Icon(
                                                  Icons.favorite,
                                                  color: item["IsFavorite"] == 1
                                                      ? Colors.red
                                                      : const Color.fromRGBO(
                                                      200, 200, 200, 1.0),
                                                ),
                                                onPressed: () {
                                                  if (item["IsFavorite"] == 0) {
                                                    getDataFavoriteFromApi
                                                        .AddItemFavoritePost(
                                                        CustomerPhone:
                                                        '$UserPhone',
                                                        ProductID:
                                                        item["ProductID"]
                                                            .toString());
                                                  } else {
                                                    deletFavorite
                                                        .DeleteItemFavoritePost(
                                                        ProductId:
                                                        item["ProductID"]
                                                            .toString());
                                                  }
                                                  setState(() {
                                                    item["IsFavorite"] =
                                                    item["IsFavorite"] == 1
                                                        ? 0
                                                        : 1;
                                                  });
                                                },
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      );
                    },

                  )
                ;
              }
            }),
            5.verticalSpace,
            Consumer(builder: (context, ref, child) {
              final getDataCategoryByParentId =
              ref.watch(getImageBanarThreeApiProvider);
              return getDataCategoryByParentId.imageBanarthreeList.isEmpty
                  ? const SizedBox()
                  :
              getDataCategoryByParentId.imageBanarthreeList[0]["ShowGroup"]==0?const SizedBox():
              Container(
                height: 150.0.h,
                width: MediaQuery.of(context).size.width,
                decoration:
                BoxDecoration(borderRadius: BorderRadius.circular(5)),
                child: CarouselSlider.builder(
                  itemCount: getDataCategoryByParentId
                      .imageBanarthreeList.length,
                  itemBuilder: (context, index, realIndex) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: InkWell(
                        onTap: () {
                          print(getDataCategoryByParentId.imageBanarthreeList[index]);
                          if(getDataCategoryByParentId.imageBanarthreeList[index]["ItemsCount"]>0)
                            {

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => BannerItemsScreen(
                                      //    imageName: index + 1,
                                      imageName:
                                      '${getDataCategoryByParentId.imageBanarthreeList[index]["ID"]}',
                                      // imageName: index,
                                    )),
                              );
                            }

                        },
                        child: Image.network(
                          width: MediaQuery.of(context).size.width,
                          '${getDataCategoryByParentId.imageBanarthreeList[index]["ImagePath"]}',
                          fit: BoxFit.fill,
                        ),
                      ),
                    );
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    aspectRatio: MediaQuery.of(context).size.width /
                        MediaQuery.of(context).size.height,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                  ),
                ),
              );
            }),
            10.verticalSpace,
            Consumer(builder: (context, ref, child) {
              final getDataOferTwoFromApi =
              ref.watch(getDataOverTwoFromApiProvider);
              final listItemOrder = ref.watch(orderProviderList);
              final listItemOrderImage = ref.watch(orderProviderListImage);
              final getDataFavoriteFromApi = ref.watch(addItemFavoriteProvider);
              final deletFavorite = ref.watch(deleteItemFavoriteProvider);


                return


               ListView.separated(
                 shrinkWrap: true,
                 physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context,index)
                      {
                        return const SizedBox(height: 5,);
                      },
                      itemCount: getDataOferTwoFromApi.overTwoList.length,
                      itemBuilder: (context,indexOne)
                      {
                        return   (getDataOferTwoFromApi.overTwoList.isEmpty||getDataOferTwoFromApi.overTwoList[indexOne]["ShowOffer"]==1)?
                            const SizedBox():
                          Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? '${getDataOferTwoFromApi.overTwoList[indexOne]["OfferName"]??''}'
                                    : '${getDataOferTwoFromApi.overTwoList[indexOne]["OfferName"]??''}',
                                style: GoogleFonts.tajawal(
                                  fontSize:
                                  16.sp,
                                  fontWeight:
                                  FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 230.h,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: getDataOferTwoFromApi.overTwoList[indexOne]["_OfferItems"].length,
                                itemBuilder: (context, index) {
                                  final item =getDataOferTwoFromApi.overTwoList[indexOne]["_OfferItems"][index];
                                  num q1 = listItemOrder.getQuantity(
                                      itemID: item['BarCode']??1);
                                  num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]??1);
                                  return Card(
                                    color: Colors.white,
                                    child: Container(
                                      color: Colors.white,
                                      width: 200.w,
                                      child: InkWell(
                                        onTap: () {

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => BannerDetailsPage(
                                                  productId: item["ProductID"],
                                                  CategoryId: item['CategoryId'],
                                                  name: (appModel.activeLanguage
                                                      .languageCode ==
                                                      'ar')
                                                      ? item["ProductArName"]
                                                      : item['ProductEnName'],
                                                  image: item['ProductcImage'],
                                                  specification:
                                                  item['Specification'],
                                                )),
                                          );
                                        },
                                        child: Stack(
                                          children: [
                                            Padding(
                                              padding: REdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Center(
                                                    child: Stack(
                                                        alignment:
                                                        Alignment.bottomRight,
                                                        children: [
                                                          SizedBox(
                                                            width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width,
                                                            height: 130,
                                                            child: Center(
                                                              child: Image.network(
                                                                '${item['ProductcImage']}',
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              if((UserPhoneAll??UserPhone)==null)
                                                              {

                                                                showDialog(
                                                                  context: context,
                                                                  barrierDismissible: false,
                                                                  builder: (_) => AlertDialog(

                                                                      content: Text(
                                                                        "يرجى ادخال رقم الهاتف",
                                                                        style: TextStyle(
                                                                          fontSize: 14.sp,
                                                                          color: const Color(0xff000000),
                                                                          fontWeight: FontWeight.w500,
                                                                          fontFamily: 'Monadi',
                                                                        ),
                                                                      ),
                                                                      actions: [

                                                                        Form(
                                                                          key:keyFormCheckOutOnSystem,
                                                                          child: MyStyledTextField(
                                                                            maxLength: 8,
                                                                            keyboardType: TextInputType.phone,
                                                                            label:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',
                                                                            hintText:  (appModel.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',

                                                                            controller: customPhoneGuestController,
                                                                            validator: (value) {
                                                                              if (value!.isEmpty) {
                                                                                return (appModel.activeLanguage.languageCode == 'ar')
                                                                                    ? 'هذا الحقل مطلوب'
                                                                                    : 'This field is required';
                                                                              } else if (value.length != 8 ||
                                                                                  !(value.startsWith('4') ||
                                                                                      value.startsWith('5') ||
                                                                                      value.startsWith('6') ||
                                                                                      value.startsWith('9'))) {
                                                                                return (appModel.activeLanguage.languageCode == 'ar')
                                                                                    ? '  رقم الهاتف غير صحيح او الارقام لا تحتوي علي ارقام انجليزية يرجي التأكد   ا'
                                                                                    : 'The Mobile Number not correct please check the mobile number';
                                                                              } else {
                                                                                return null;
                                                                              }
                                                                            },
                                                                          ),
                                                                        ),
                                                                        20.verticalSpace,

                                                                        TextButton(
                                                                          style: ButtonStyle(
                                                                            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                                                                              EdgeInsets.zero,
                                                                            ),
                                                                          ),
                                                                          onPressed: ()  {



                                                                            if(keyFormCheckOutOnSystem.currentState!.validate()) {

                                                                            }
                                                                            if(UserPhone==null)
                                                                            {
                                                                              UserPhoneAll=customPhoneGuestController.text;
                                                                            }
                                                                            else
                                                                            {
                                                                              UserPhoneAll=UserPhone;
                                                                            }




                                                                            Navigator.pushReplacement(
                                                                              context,
                                                                              MaterialPageRoute(
                                                                                builder: (context) => const MainPage(

                                                                                ),
                                                                              ),
                                                                            );

                                                                          },
                                                                          child: Container(
                                                                            width: 1.sw - 30,
                                                                            height: 40.r,
                                                                            alignment: Alignment.center,
                                                                            decoration: BoxDecoration(
                                                                              color: Colors.orange,
                                                                              borderRadius: BorderRadius.circular(30),

                                                                            ),
                                                                            child:false
                                                                                ? SizedBox(
                                                                              height: 20.r,
                                                                              width: 20.r,
                                                                              child: CircularProgressIndicator(
                                                                                strokeWidth: 3.r,
                                                                                color: AppColors.white,
                                                                              ),
                                                                            )
                                                                                : Text(
                                                                              (appModel.activeLanguage.languageCode == 'ar')?

                                                                              "استمرار":'Continue ',
                                                                              style: GoogleFonts.inter(
                                                                                fontWeight: FontWeight.w600,
                                                                                fontSize: 12.sp,
                                                                                color: AppColors.white,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ]),
                                                                );

                                                              }
                                                              else
                                                              {
                                                                setState(() {
                                                                  isSecondContainerVisibleList2[indexOne][
                                                                  index] =
                                                                  !isSecondContainerVisibleList2[indexOne][
                                                                  index];
                                                                  // isSecondContainerVisible =
                                                                  // !isSecondContainerVisible;
                                                                });

                                                                setState(() {
                                                                  if (q1 == 0) {
                                                                    q1++;

                                                                  }
                                                                  listItemOrder.addItem({
                                                                    "ItemID": item["ProductID"],
                                                                    "Quantity": q1,
                                                                    "Price": item[
                                                                    "PriceAfterDiscount"],
                                                                    "StockQuantity":
                                                                    item["StockQuantity"],
                                                                    "BarCode": item["BarCode"],
                                                                    "Colors_ID": '',
                                                                    "Size_ID": '',
                                                                    "RequiredQTY":item['RequiredQTY'],
                                                                    "GiftQTY":item['GiftQTY'],
                                                                    "Y_Gift_Qty":y,
                                                                  });
                                                                  listItemOrderImage.addItem({
                                                                    "image":
                                                                    item["ProductcImage"],
                                                                    "ItemID": item["ProductID"],
                                                                    "Quantity": q1,
                                                                    "Price": item[
                                                                    "PriceAfterDiscount"],
                                                                    "ProductArName":
                                                                    item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                    "ProductEnName":
                                                                    item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                    "StockQuantity":
                                                                    item["StockQuantity"],
                                                                    "CustomerQuantity":(item["CustomerQuantity"]> 0.0)?
                                                                    item["CustomerQuantity"]:item["CustomerQtyFree"],
                                                                    "BarCode": item["BarCode"],
                                                                    "Colors_ID": '',
                                                                    "Size_ID": '',
                                                                    "RequiredQTY":item['RequiredQTY'],
                                                                    "GiftQTY":item['GiftQTY'],
                                                                    "Y_Gift_Qty":y,
                                                                  });
                                                                });

                                                                if (isSecondContainerVisibleList2[indexOne][
                                                                index]) {
                                                                  Future.delayed(
                                                                      const Duration(
                                                                          milliseconds: 10000),
                                                                          () {
                                                                        setState(() {
                                                                          isSecondContainerVisibleList2[indexOne][
                                                                          index] = false;
                                                                        });
                                                                      });
                                                                }
                                                              }


                                                            },
                                                            child:
                                                            !isSecondContainerVisibleList2[indexOne][
                                                            index]
                                                                ? Card(
                                                              child: Container(
                                                                height: 40.h,
                                                                width: 35.w,
                                                                color: (q1 >= 1)
                                                                    ? Colors.green
                                                                    : Colors.white,
                                                                child: Center(
                                                                  child: Text(
                                                                      (q1 >= 1)
                                                                          ? '$q1'
                                                                          : '+',
                                                                      style:
                                                                      TextStyle(
                                                                        fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                        fontFamily: 'Monadi',
                                                                        fontSize:
                                                                        20.sp,
                                                                        color: (q1 >=
                                                                            1)
                                                                            ? Colors
                                                                            .white
                                                                            : Colors
                                                                            .orange,
                                                                      )),
                                                                ),
                                                              ),
                                                            )
                                                                : Container(
                                                                height: 40,
                                                                decoration:
                                                                BoxDecoration(
                                                                  color: Colors.white,
                                                                  borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                      10),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: Colors
                                                                          .grey
                                                                          .withOpacity(
                                                                          0.5),
                                                                      spreadRadius: 5,
                                                                      blurRadius: 7,
                                                                      offset: const Offset(
                                                                          0, 3),
                                                                    ),
                                                                  ],
                                                                ),
                                                                child: Row(
                                                                  children: [
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        if (item["CustomerQuantity"] > 0.0)
                                                                        {
                                                                          if (item["CustomerQuantity"] >= item["StockQuantity"]) {
                                                                            if (q1 < item["StockQuantity"]) {
                                                                              setState(
                                                                                      () {
                                                                                    q1++;
                                                                                    if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                    {
                                                                                      if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                        q1 += item['GiftQTY'];
                                                                                        item["Y_Gift_Qty"]++;

                                                                                        y++;


                                                                                      }


                                                                                    }









                                                                                  });
                                                                              listItemOrder
                                                                                  .addItem({
                                                                                "ItemID":
                                                                                item["ProductID"],
                                                                                "Quantity":
                                                                                q1,
                                                                                "Price":
                                                                                item["PriceAfterDiscount"],
                                                                                "StockQuantity":
                                                                                item["StockQuantity"],
                                                                                "BarCode":
                                                                                item["BarCode"],
                                                                                "Colors_ID":
                                                                                '',
                                                                                "Size_ID":
                                                                                '',
                                                                                "RequiredQTY":item['RequiredQTY'],
                                                                                "GiftQTY":item['GiftQTY'],
                                                                                "Y_Gift_Qty":y,
                                                                              });
                                                                              listItemOrderImage
                                                                                  .addItem({
                                                                                "image":
                                                                                item["ProductcImage"],
                                                                                "ItemID":
                                                                                item["ProductID"],
                                                                                "Quantity":
                                                                                q1,
                                                                                "Price":
                                                                                item["PriceAfterDiscount"],
                                                                                "ProductArName":
                                                                                item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                                "ProductEnName":
                                                                                item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                                "StockQuantity":
                                                                                item["StockQuantity"],
                                                                                "CustomerQuantity":
                                                                                item["CustomerQuantity"],
                                                                                "BarCode":
                                                                                item["BarCode"],
                                                                                "Colors_ID":
                                                                                '',
                                                                                "Size_ID":
                                                                                '',
                                                                                "RequiredQTY":item['RequiredQTY'],
                                                                                "GiftQTY":item['GiftQTY'],
                                                                                "Y_Gift_Qty":y,
                                                                              });
                                                                            }
                                                                          } else {
                                                                            if (q1 < item["CustomerQuantity"]) {
                                                                              setState(
                                                                                      () {
                                                                                    q1++;

                                                                                    if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                    {
                                                                                      if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                        q1 += item['GiftQTY'];
                                                                                        item["Y_Gift_Qty"]++;

                                                                                        y++;


                                                                                      }


                                                                                    }
                                                                                  });
                                                                              listItemOrder
                                                                                  .addItem({
                                                                                "ItemID":
                                                                                item["ProductID"],
                                                                                "Quantity":
                                                                                q1,
                                                                                "Price":
                                                                                item["PriceAfterDiscount"],
                                                                                "StockQuantity":
                                                                                item["CustomerQuantity"],
                                                                                "BarCode":
                                                                                item["BarCode"],
                                                                                "Colors_ID":
                                                                                '',
                                                                                "Size_ID":
                                                                                '',
                                                                                "RequiredQTY":item['RequiredQTY'],
                                                                                "GiftQTY":item['GiftQTY'],
                                                                                "Y_Gift_Qty":y,
                                                                              });
                                                                              listItemOrderImage
                                                                                  .addItem({
                                                                                "image":
                                                                                item["ProductcImage"],
                                                                                "ItemID":
                                                                                item["ProductID"],
                                                                                "Quantity":
                                                                                q1,
                                                                                "Price":
                                                                                item["PriceAfterDiscount"],
                                                                                "ProductArName":
                                                                                item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                                "ProductEnName":
                                                                                item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                                "StockQuantity":
                                                                                item["CustomerQuantity"],
                                                                                "CustomerQuantity":
                                                                                item["CustomerQuantity"],
                                                                                "BarCode":
                                                                                item["BarCode"],
                                                                                "Colors_ID":
                                                                                '',
                                                                                "Size_ID":
                                                                                '',
                                                                                "RequiredQTY":item['RequiredQTY'],
                                                                                "GiftQTY":item['GiftQTY'],
                                                                                "Y_Gift_Qty":y,
                                                                              });
                                                                            }
                                                                          }
                                                                        }

                                                                        else  if (item["CustomerQtyFree"] > 0.0)
                                                                        {
                                                                          print('----------------------------------');
                                                                          print(item["CustomerQtyFree"]);
                                                                          print('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^');

                                                                          if (item["CustomerQtyFree"] >= item["StockQuantity"]) {
                                                                            if (q1 < item["StockQuantity"]) {
                                                                              setState(
                                                                                      () {
                                                                                    q1++;
                                                                                    if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                    {
                                                                                      if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                        q1 += item['GiftQTY'];
                                                                                        item["Y_Gift_Qty"]++;

                                                                                        y++;


                                                                                      }


                                                                                    }









                                                                                  });
                                                                              listItemOrder
                                                                                  .addItem({
                                                                                "ItemID":
                                                                                item["ProductID"],
                                                                                "Quantity":
                                                                                q1,
                                                                                "Price":
                                                                                item["PriceAfterDiscount"],
                                                                                "StockQuantity":
                                                                                item["StockQuantity"],
                                                                                "BarCode":
                                                                                item["BarCode"],
                                                                                "Colors_ID":
                                                                                '',
                                                                                "Size_ID":
                                                                                '',
                                                                                "RequiredQTY":item['RequiredQTY'],
                                                                                "GiftQTY":item['GiftQTY'],
                                                                                "Y_Gift_Qty":y,
                                                                              });
                                                                              listItemOrderImage
                                                                                  .addItem({
                                                                                "image":
                                                                                item["ProductcImage"],
                                                                                "ItemID":
                                                                                item["ProductID"],
                                                                                "Quantity":
                                                                                q1,
                                                                                "Price":
                                                                                item["PriceAfterDiscount"],
                                                                                "ProductArName":
                                                                                item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                                "ProductEnName":
                                                                                item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                                "StockQuantity":
                                                                                item["StockQuantity"],
                                                                                "CustomerQuantity":
                                                                                item["CustomerQuantity"],
                                                                                "BarCode":
                                                                                item["BarCode"],
                                                                                "Colors_ID":
                                                                                '',
                                                                                "Size_ID":
                                                                                '',
                                                                                "RequiredQTY":item['RequiredQTY'],
                                                                                "GiftQTY":item['GiftQTY'],
                                                                                "Y_Gift_Qty":y,
                                                                              });
                                                                            }
                                                                          } else {
                                                                            if (q1 < item["CustomerQtyFree"]) {
                                                                              setState(
                                                                                      () {
                                                                                    q1++;

                                                                                    if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                    {
                                                                                      if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                        q1 += item['GiftQTY'];
                                                                                        item["Y_Gift_Qty"]++;

                                                                                        y++;


                                                                                      }


                                                                                    }
                                                                                  });
                                                                              listItemOrder
                                                                                  .addItem({
                                                                                "ItemID":
                                                                                item["ProductID"],
                                                                                "Quantity":
                                                                                q1,
                                                                                "Price":
                                                                                item["PriceAfterDiscount"],
                                                                                "StockQuantity":
                                                                                item["CustomerQtyFree"],
                                                                                "BarCode":
                                                                                item["BarCode"],
                                                                                "Colors_ID":
                                                                                '',
                                                                                "Size_ID":
                                                                                '',
                                                                                "RequiredQTY":item['RequiredQTY'],
                                                                                "GiftQTY":item['GiftQTY'],
                                                                                "Y_Gift_Qty":y,
                                                                              });
                                                                              listItemOrderImage
                                                                                  .addItem({
                                                                                "image":
                                                                                item["ProductcImage"],
                                                                                "ItemID":
                                                                                item["ProductID"],
                                                                                "Quantity":
                                                                                q1,
                                                                                "Price":
                                                                                item["PriceAfterDiscount"],
                                                                                "ProductArName":
                                                                                item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                                "ProductEnName":
                                                                                item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                                "StockQuantity":
                                                                                item["CustomerQtyFree"],
                                                                                "CustomerQuantity":
                                                                                item["CustomerQtyFree"],
                                                                                "BarCode":
                                                                                item["BarCode"],
                                                                                "Colors_ID":
                                                                                '',
                                                                                "Size_ID":
                                                                                '',
                                                                                "RequiredQTY":item['RequiredQTY'],
                                                                                "GiftQTY":item['GiftQTY'],
                                                                                "Y_Gift_Qty":y,
                                                                              });
                                                                            }
                                                                          }
                                                                        }


                                                                        else {


                                                                          if (q1 < item["StockQuantity"]) {
                                                                            setState(
                                                                                    () {

                                                                                  q1++;
                                                                                  // print('Q1 $q1');


                                                                                  if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                                                  {
                                                                                    if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                                      q1 += item['GiftQTY'];
                                                                                      item["Y_Gift_Qty"]++;

                                                                                      y++;


                                                                                    }


                                                                                  }











                                                                                });
                                                                            listItemOrder
                                                                                .addItem({
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "StockQuantity":
                                                                              item["StockQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                            listItemOrderImage
                                                                                .addItem({
                                                                              "image":
                                                                              item["ProductcImage"],
                                                                              "ItemID":
                                                                              item["ProductID"],
                                                                              "Quantity":
                                                                              q1,
                                                                              "Price":
                                                                              item["PriceAfterDiscount"],
                                                                              "ProductArName":
                                                                              item["ProductName"] +' * '+item['UnitValue'].toString(),
                                                                              "ProductEnName":
                                                                              item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                                              "StockQuantity":
                                                                              item["StockQuantity"],
                                                                              "CustomerQuantity":
                                                                              item["CustomerQuantity"],
                                                                              "BarCode":
                                                                              item["BarCode"],
                                                                              "Colors_ID":
                                                                              '',
                                                                              "Size_ID":
                                                                              '',
                                                                              "RequiredQTY":item['RequiredQTY'],
                                                                              "GiftQTY":item['GiftQTY'],
                                                                              "Y_Gift_Qty":y,
                                                                            });
                                                                          }
                                                                        }
                                                                      },
                                                                      child: Text(
                                                                        '+',
                                                                        style:
                                                                        TextStyle(
                                                                          fontSize:
                                                                          20.sp,
                                                                          color: Colors
                                                                              .orange,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          fontFamily:
                                                                          'Monadi',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Center(
                                                                      child: Text(
                                                                        '$q1',
                                                                        maxLines: 2,
                                                                        overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                        style:
                                                                        TextStyle(
                                                                          fontSize:
                                                                          16.sp,
                                                                          color: Colors
                                                                              .black,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                          fontFamily:
                                                                          'Monadi',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    TextButton(
                                                                      onPressed: () {
                                                                        if (q1 > 0) {
                                                                          setState(
                                                                                  () {
                                                                                q1--;




                                                                              });
                                                                        }
                                                                        if (q1 ==
                                                                            0) {}
                                                                        listItemOrder
                                                                            .decreaseQuantity(
                                                                            item[
                                                                            "BarCode"]);
                                                                        listItemOrderImage
                                                                            .decreaseQuantity(
                                                                            item[
                                                                            "BarCode"]);
                                                                      },
                                                                      child: Text(
                                                                        '-',
                                                                        style:
                                                                        TextStyle(
                                                                          fontSize:
                                                                          20.sp,
                                                                          color: Colors
                                                                              .orange,
                                                                          fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                          fontFamily:
                                                                          'Monadi',
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )),
                                                          )
                                                        ]),
                                                  ),
                                                  4.verticalSpace,
                                                  (item["DiscountPercent"] == 0)
                                                      ? Row(
                                                    children: [
                                                      Text(
                                                        ' ${item["PriceAfterDiscount"]??0000.toStringAsFixed(3)} ',
                                                        style: TextStyle(
                                                          fontSize:16.sp,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Monadi',
                                                        ),
                                                      ),
                                                      Text(
                                                        (appModel.activeLanguage
                                                            .languageCode ==
                                                            'ar')
                                                            ? 'د.ك'
                                                            : 'K.D',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Monadi',
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                      : Row(
                                                    children: [
                                                      Text(
                                                        '${(item["PriceAfterDiscount"]).toStringAsFixed(3)}',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Monadi',
                                                        ),
                                                      ),
                                                      Text(
                                                        (appModel.activeLanguage
                                                            .languageCode ==
                                                            'ar')
                                                            ? 'د.ك'
                                                            : 'K.D',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Monadi',
                                                        ),
                                                      ),
                                                      10.horizontalSpace,
                                                      Text(
                                                        ' ${item["Price"].toStringAsFixed(3)}',
                                                        style: TextStyle(
                                                          decoration: TextDecoration
                                                              .lineThrough,
                                                          color: Colors.red,
                                                          decorationThickness: 12.0,
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w600,
                                                          fontFamily: 'Monadi',
                                                        ),
                                                      ),
                                                      Text(
                                                        'د.ك',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          fontWeight: FontWeight.w600,
                                                          decoration: TextDecoration
                                                              .lineThrough,
                                                          color: Colors.red,
                                                          decorationThickness: 12.0,
                                                          fontFamily: 'Monadi',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  2.verticalSpace,
                                                  Expanded(
                                                    child: Text(
                                                      (appModel.activeLanguage.languageCode ==
                                                          'ar')
                                                          ? '${item["ProductName"]} * ${item['UnitValue'].toString()}'
                                                          : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                        fontSize: 12.sp,
                                                        fontWeight: FontWeight.bold,
                                                        fontFamily: 'Monadi',

                                                      ),

                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            if (item["DiscountPercent"] != 0)
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(

                                                  color: Colors.red,
                                                  child:
                                                  Center(
                                                    child: Text(
                                                      '%${item["DiscountPercent"]}خصم',
                                                      style: GoogleFonts.tajawal(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.bold,
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                              ),
                                            if (item['GiftQTY']!=0.0)
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Container(

                                                  color: Colors.orange,
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        '${item['RequiredQTY']}',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      Text(
                                                        ' + ${item['GiftQTY']} ',
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                      const Text(
                                                        'مجانا',
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            if (item["StockQuantity"] == 0)
                                              Image.asset(AppAssets.OutOfStock),
                                            Positioned(
                                                top: 0,
                                                left: 0,
                                                child: IconButton(
                                                  icon: Icon(
                                                    Icons.favorite,
                                                    color: item["IsFavorite"] == 1
                                                        ? Colors.red
                                                        : const Color.fromRGBO(
                                                        200, 200, 200, 1.0),
                                                  ),
                                                  onPressed: () {
                                                    if (item["IsFavorite"] == 0) {
                                                      getDataFavoriteFromApi
                                                          .AddItemFavoritePost(
                                                          CustomerPhone:
                                                          '$UserPhone',
                                                          ProductID:
                                                          item["ProductID"]
                                                              .toString());
                                                    } else {
                                                      deletFavorite
                                                          .DeleteItemFavoritePost(
                                                          ProductId:
                                                          item["ProductID"]
                                                              .toString());
                                                    }
                                                    setState(() {
                                                      item["IsFavorite"] =
                                                      item["IsFavorite"] == 1
                                                          ? 0
                                                          : 1;
                                                    });
                                                  },
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        );
                      },

                    )
                 ;

            }),







          ],
        ),
      ),
    );
  }
}
