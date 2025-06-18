import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../main.dart';
import '../../../../../core/constants/app_assets.dart';
import '../../../../../riverpod/gh.dart';
import '../../../../components/components.dart';
import '../../../../theme/app_colors.dart';
import '../../../pages.dart';
import '../../drawer/favorite/controler/favorite_riverpod.dart';
import '../../shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import '../../shop/cart/checkout/oneSystem/widget/text_form_field_onsystem.dart';
import '../../shop/details/banner_details/banner_details_page.dart';
import '../on_system/controller/banaer_riverpod.dart';

class BannerItemsScreen extends ConsumerStatefulWidget {
  dynamic imageName;
  BannerItemsScreen({super.key, required this.imageName});

  @override
  ConsumerState<BannerItemsScreen> createState() => _BannerItemsScreenState();
}

class _BannerItemsScreenState extends ConsumerState<BannerItemsScreen> {
  bool isLoading = true;
  List<bool> isSecondContainerVisibleList =
      List.generate(20000000, (index) => false);
  List<bool> itemLoveStates = List.generate(20000000, (index) => false);
  final ScrollController _scrollController = ScrollController();
  var customPhoneGuestController = TextEditingController();
  var keyFormCheckOutOnSystem = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();

    ref
        .read(getBannerItemsApiProvider)
        .getBannerItems(ImageName: widget.imageName);
    Future.delayed(Duration(milliseconds: 2000), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Consumer(
              builder: (context, ref, child) {
                final getDataFavoriteFromApi =
                    ref.watch(addItemFavoriteProvider);
                final deletFavorite = ref.watch(deleteItemFavoriteProvider);
                final getDataBanner = ref.watch(getBannerItemsApiProvider);
                final appModel = ref.watch(appModelProvider);
                final listItemOrder = ref.watch(orderProviderList);

                final listItemOrderImage = ref.watch(orderProviderListImage);
                int _getCrossAxisCount(BuildContext context) {
                  final screenWidth = MediaQuery.of(context).size.width;

                  if (screenWidth >= 1200) {
                    return 4;
                  } else if (screenWidth >= 800) {
                    return 3;
                  } else {
                    return 2;
                  }
                }

                double _getAspectRatio(BuildContext context) {
                  final crossAxisCount = _getCrossAxisCount(context);

                  if (crossAxisCount == 4) {
                    return 0.75;
                  } else {
                    return 0.8;
                  }
                }

                return Expanded(
                    child: Padding(
                  padding: REdgeInsets.only(bottom: 50.0, right: 4, left: 4),
                  child: isLoading
                      ? const GridListShimmer(
                          itemCount: 10,
                          isScrollable: true,
                          onlyBottomPadding: 10,
                          verticalPadding: 10,
                        )
                      : getDataBanner.bannerItemsList.isEmpty
                          ? Center(
                              child: Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "لم يتم إضافة أي منتجات في هذا البانر بعد."
                                      : "No products have been added to this banner yet.",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: 'Monadi',
                                  )),
                            )
                          : GridView.builder(
                              controller: _scrollController,
                              itemCount: getDataBanner.bannerItemsList.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: _getCrossAxisCount(context),
                                childAspectRatio: _getAspectRatio(context),
                                crossAxisSpacing: 2,
                                mainAxisSpacing: 5,
                              ),
                              itemBuilder: (context, index) {
                                final item =
                                    getDataBanner.bannerItemsList[index];
                                num q1 = listItemOrder.getQuantity(
                                    itemID: item['BarCode']);
                                num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]??1);
                                return Card(
                                  color: Colors.white,
                                  child: Container(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BannerDetailsPage(
                                                    productId:
                                                        item["ProductID"],
                                                    CategoryId:
                                                        item["CategoryId"],
                                                    name: (appModel
                                                                .activeLanguage
                                                                .languageCode ==
                                                            'ar')
                                                        ? item['ProductArName']
                                                        : item['ProductEnName'],
                                                    image:
                                                        item['ProductcImage'],
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
                                                        Container(
                                                          width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .width,
                                                          height: 130,
                                                          child:CachedNetworkImage(
  imageUrl: '${item['ProductcImage']}',
  placeholder: (context, url) => CircularProgressIndicator(),
  errorWidget: (context, url, error) => Icon(Icons.error),
  fit: BoxFit.cover,
)
                                                  
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
                                                                isSecondContainerVisibleList[index] =
                                                                !isSecondContainerVisibleList[index];
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

                                                              if (isSecondContainerVisibleList[index]) {
                                                                Future.delayed(
                                                                    const Duration(
                                                                        milliseconds: 10000),
                                                                        () {
                                                                      setState(() {
                                                                        isSecondContainerVisibleList[index] = false;
                                                                      });
                                                                    });
                                                              }
                                                            }


                                                          },
                                                          child:
                                                          !isSecondContainerVisibleList[index]
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
                                                            ' ${item["PriceAfterDiscount"].toStringAsFixed(3)} ',
                                                            style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontFamily:
                                                                  'Monadi',
                                                            ),
                                                          ),
                                                          Text(
                                                            (appModel.activeLanguage
                                                                        .languageCode ==
                                                                    'ar')
                                                                ? 'د.ك'
                                                                : 'K.D',
                                                            style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontFamily:
                                                                  'Monadi',
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    : Row(
                                                        children: [
                                                          Text(
                                                            '${(item["PriceAfterDiscount"]).toStringAsFixed(3)}',
                                                            style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontFamily:
                                                                  'Monadi',
                                                            ),
                                                          ),
                                                          Text(
                                                            (appModel.activeLanguage
                                                                        .languageCode ==
                                                                    'ar')
                                                                ? 'د.ك'
                                                                : 'K.D',
                                                            style: TextStyle(
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontFamily:
                                                                  'Monadi',
                                                            ),
                                                          ),
                                                          10.horizontalSpace,
                                                          Text(
                                                            ' ${item["Price"].toStringAsFixed(3)}',
                                                            style: TextStyle(
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: Colors.red,
                                                              fontSize: 13.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              fontFamily:
                                                                  'Monadi',
                                                            ),
                                                          ),
                                                          Text(
                                                            'د.ك',
                                                            style: TextStyle(
                                                              fontSize: 16.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w300,
                                                              decoration:
                                                                  TextDecoration
                                                                      .lineThrough,
                                                              color: Colors.red,
                                                              fontFamily:
                                                                  'Monadi',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                2.verticalSpace,
                                                Expanded(
                                                  flex: 2,
                                                  child: Text(

                                                      (appModel.activeLanguage.languageCode == 'ar')
                                                        ? '${item["ProductName"]} * ${item['UnitValue'].toString()}'
                                                        : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontSize: 12.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Cairo',
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 2),
                                                color: Colors.red,
                                                child: Text(
                                                  '%${item["DiscountPercent"]}خصم',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
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
                                                      : Color.fromRGBO(
                                                          200, 200, 200, 1.0),
                                                ),
                                                onPressed: () {
                                                  if (item["IsFavorite"] == 0) {
                                                    getDataFavoriteFromApi
                                                        .AddItemFavoritePost(
                                                            CustomerPhone:
                                                                '${UserPhone}',
                                                            ProductID: item[
                                                                    "ProductID"]
                                                                .toString());
                                                  } else {
                                                    deletFavorite
                                                        .DeleteItemFavoritePost(
                                                            ProductId: item[
                                                                    "ProductID"]
                                                                .toString());
                                                  }
                                                  setState(() {
                                                    item["IsFavorite"] =
                                                        item["IsFavorite"] == 1
                                                            ? 0
                                                            : 1;
                                                  });
                                                },
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
