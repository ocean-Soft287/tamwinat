
import 'package:fluttertoast/fluttertoast.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import 'package:sundaymart/firebase_dynamic_link_service.dart';
import 'package:sundaymart/src/core/utils/dialog_helper.dart';
import 'package:sundaymart/src/presentation/pages/main/home/on_system/controller/home_riverpod.dart';

import '../../../../../../../main.dart';

import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../riverpod/gh.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/theme.dart';
import '../../../../pages.dart';

import '../../../drawer/favorite/controler/favorite_riverpod.dart';

import '../../../home/widget/delivery_category_scondry.dart';
import '../../cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import '../../cart/checkout/oneSystem/widget/basct_shop.dart';
import '../../cart/checkout/oneSystem/widget/text_form_field_onsystem.dart';
import '../market_info/riverpod/market_Info_oneSystem/market_info_notifier.dart';
import 'riverpod/provider/banner_products_provider.dart';
import 'riverpod/provider/search_product_in_banner_provider.dart';

class BannerDetailsPage extends ConsumerStatefulWidget {
  final int? productId;
  final dynamic? CategoryId;
  String? specification;
  String? image;
  String? name;
  String?categoryName;
  bool isRoute;
  num? scrollPosition;
  int selectedColorIndex = 0;
  int selectedSizeIndex = 0;
  int selectedImageUnitIndex = 0;
  late dynamic colorIndex = 1;
  late dynamic sizeIndex = 1;
  BannerDetailsPage(
      {Key? key,
        this.productId,
        this.CategoryId,
        this.specification,
        this.image,
        this.categoryName='',
        this.isRoute=false,
        this.scrollPosition,
        this.name = ""})
      : super(key: key);

  @override
  ConsumerState<BannerDetailsPage> createState() => _BannerDetailsPageState();
}

class _BannerDetailsPageState extends ConsumerState<BannerDetailsPage> {
  List<bool> isSecondContainerVisibleList2 =
  List.generate(100, (index) => false);
  int counterQuntati = 0;
  var customPhoneGuestController = TextEditingController();
  var keyFormCheckOutOnSystem = GlobalKey<FormState>();
  bool checkButtonSalla = true;
  bool isSecondContainerVisible = false;
  bool isLoading = true;
  bool isLoadingTwo=true;
  bool isLoveActive = false;
  List<bool> itemLoveStates = [];
  List<bool> isSecondContainerVisibleList = [];
  @override
  void initState() {
    super.initState();
    ref
        .read(getDataCategoryByIdFromApiProvider.notifier)
        .getCategoryById(productId: widget.productId);
    ref
        .read(getProductsFromApi.notifier)
        .getProducsts(categoryId: widget.CategoryId, brandId: null);
    Future.delayed(const Duration(milliseconds: 4000), () {
      setState(() {
        isLoading = false;
      });
    });

    Future.delayed(const Duration(milliseconds: 10000), () {
      setState(() {
        isLoadingTwo = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(appModelProvider);

    return Scaffold(
      backgroundColor: AppColors.white,
      // bottomSheet: Consumer(builder: (context, ref, child) {
      //   final listItemOrder = ref.watch(orderProviderList);
      //   final getDataFavoriteFromApi = ref.watch(getDataFavoriteApiProvider);
      //   return (listItemOrder.orderList.isEmpty)
      //       ? const Text('')
      //       : InkWell(
      //     onTap: () {
      //       Navigator.push(
      //         context,
      //         MaterialPageRoute(builder: (context) => BactShop()),
      //       );
      //     },
      //     child: Container(
      //       color: Colors.green,
      //       child: Column(
      //         mainAxisSize: MainAxisSize.min,
      //         children: [
      //           Container(
      //             decoration: BoxDecoration(
      //               color: Colors.green,
      //               borderRadius: BorderRadius.circular(20),
      //             ),
      //             child: Row(
      //               mainAxisAlignment: MainAxisAlignment.spaceAround,
      //               children: [
      //                 Text(
      //                   listItemOrder.calculateTotalQuantity().toString(),
      //                   style: TextStyle(
      //                     fontSize: 20.sp,
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.w500,
      //                     fontFamily: 'Monadi',
      //                   ),
      //                 ),
      //                 Text(
      //                   (lang.activeLanguage.languageCode == 'ar')
      //                       ? 'شاهد السله'
      //                       : 'View Cart',
      //                   style: TextStyle(
      //                     fontSize: 20.sp,
      //                     color: Colors.white,
      //                     fontWeight: FontWeight.w500,
      //                     fontFamily: 'Monadi',
      //                   ),
      //                 ),
      //                 RichText(
      //                   text: TextSpan(
      //                     children: [
      //                       TextSpan(
      //                           text:
      //                           '${listItemOrder.calculateTotalPrice().toStringAsFixed(3)} ',
      //                           style: TextStyle(
      //                             fontSize: 20.sp,
      //                             color: Colors.white,
      //                             fontWeight: FontWeight.w500,
      //                             fontFamily: 'Monadi',
      //                           )),
      //                       TextSpan(
      //                           text: (lang.activeLanguage.languageCode ==
      //                               'ar')
      //                               ? 'د.ك '
      //                               : 'K.D',
      //                           style: TextStyle(
      //                             fontSize: 20.sp,
      //                             color: Colors.white,
      //                             fontWeight: FontWeight.w500,
      //                             fontFamily: 'Monadi',
      //                           )),
      //                     ],
      //                   ),
      //                 ),
      //               ],
      //             ),
      //           ),
      //           10.verticalSpace,
      //         ],
      //       ),
      //     ),
      //   );
      // }),
      appBar:


      CommonAppBar(
        title: (lang.activeLanguage.languageCode == 'ar')
            ? 'تفاصيل المنتج'
            : 'Product details',
        onLeadingPressed: () {
          print(widget.scrollPosition);

          if (widget.isRoute) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => DeliveryCategoryScondory(
                  categoryId: widget.CategoryId,
                  CategoryArName: widget.categoryName,
                  scrollOffset: widget.scrollPosition,
                ),
              ),
            );
          } else {
             Navigator.pop(context);
          }
        },

        actions: [


          IconButton(
              onPressed: () {
                print("Welcome");

                // print(widget.productId);
                // print(widget.productId.runtimeType);
                // DialogHelper.showDialogHelper(context);
                // DynamicLinkHandlerService.createDynamicLink(
                //     categoryId:(widget.CategoryId is String)? widget.CategoryId:widget.CategoryId.toString(),
                //     productId: widget.productId,
                //     name: widget.name,
                //     description: widget.specification ?? widget.name,
                //     imageUrl: widget.image)
                //     .then((value) async {
                //   await Share.share(value.toString())
                //       .then((value) => DialogHelper.closeDialogHelper(context));
                //   print(value);
                // });

                print(widget.productId);
                print(widget.productId.runtimeType);
                DialogHelper.showDialogHelper(context);
                DynamicLinkHandlerService.createDynamicLink(
                    categoryId: (widget.CategoryId is String) ? widget.CategoryId : widget.CategoryId.toString(),
                    productId: widget.productId,
                    name: widget.name,
                    description: widget.specification ?? widget.name,
                    imageUrl: widget.image)
                    .then((value) async {
                  await Share.share(value.toString())
                      .then((value) => DialogHelper.closeDialogHelper(context));
                  print(value);
                });
              },
              icon: const Icon(Icons.ios_share_outlined)),
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
                    const SizedBox(
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
                              style: const TextStyle(
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
      ),
      body: isLoading
          ? const GridListShimmer(
        itemCount: 10,
        isScrollable: true,
        onlyBottomPadding: 10,
        verticalPadding: 10,
      )
          : SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Consumer(
              builder: (context, ref, child) {
                final lang = ref.watch(appModelProvider);
                final getDataFavoriteFromApi =
                ref.watch(addItemFavoriteProvider);
                final getDataFavoriteItemFromApi =
                ref.watch(getDataFavoriteApiProvider);
                final deletFavorite =
                ref.watch(deleteItemFavoriteProvider);
                final categoryDataList =
                ref.watch(getDataCategoryByIdFromApiProvider);
                final listItemOrder = ref.watch(orderProviderList);
                final listItemOrderImage =
                ref.watch(orderProviderListImage);
                widget.name=    (lang.activeLanguage.languageCode == 'ar')
                    ? '${categoryDataList.categoryDateByIdList[0]["ProductArName"]}'
                    : '${categoryDataList.categoryDateByIdList[0]["ProductEnName"]}';
                dynamic q1 = (categoryDataList
                    .categoryDateByIdList[0]
                ["Product_ColorsSizes"]
                    .length ==
                    0)
                    ? listItemOrder.getQuantity(
                    itemID: categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]
                    ["Barcode"]!)
                    : listItemOrder.getQuantity(
                    itemID: categoryDataList.categoryDateByIdList[0]
                    ["Product_ColorsSizes"]
                    [widget.selectedSizeIndex]["Barcode"]);
               
                 var item=categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex];
                num y = listItemOrder.getYGiftQty(itemID: item["Barcode"]);
                return (categoryDataList.categoryDateByIdList.isEmpty)
                    ? const Text('')
                    : Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(children: [
                        Container(
                          height: 200.w,
                          color: Colors.white,
                          padding:
                          const EdgeInsets.symmetric(horizontal: 50),
                          width: MediaQuery.of(context).size.width,
                          child: InkWell(
                            onTap: () {
                              print(categoryDataList
                                  .categoryDateByIdList[0]
                              ["DiscountPercent"]);
                            },
                            child: InkWell(
                              onTap: (){
print(categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]["ImagePath"]);
                              },
                              child: Image.network(
                                '${

                                    categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]["ImagePath"]
                                   //categoryDataList.categoryDateByIdList[0]["ProductcImage"]

                                }',
                              ),
                            ),
                          ),
                        ),
                        if (categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]['GiftQTY']!=0.0)
                          Positioned(
                            top: 60,
                            left: 0,
                            child: Container(
                               decoration: BoxDecoration(  color: Colors.orange,borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 2),

                              child: InkWell(
                                onTap: (){
                                print(item['RequiredQTY']);
 print(item['GiftQTY']);
 print(item['RequiredQTY']);

                                },
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
                          ),


                        if  (categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]
                        ["DiscountRate"] !=
                            0)
                          Positioned(
                            bottom: 50,
                            left: 10,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                  BorderRadius.circular(5)),
                              child: Text(
                                ' ${categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]["DiscountRate"]}% ',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),


                      ]),

                      20.verticalSpace,
                      (categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]
                      ["DiscountRate"] ==
                          0)
                          ? Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                ' ${categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]["PriceAfterDiscount"].toStringAsFixed(3)}',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                              Text(
                                (lang.activeLanguage
                                    .languageCode ==
                                    'ar')
                                    ? 'د.ك'
                                    : 'K.D',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: categoryDataList
                                  .categoryDateByIdList[
                              0]["IsFavorite"] ==
                                  1
                                  ? Colors.red
                                  : const Color.fromRGBO(
                                  200, 200, 200, 1.0),
                            ),
                            onPressed: () {
                              if (categoryDataList
                                  .categoryDateByIdList[
                              0]["IsFavorite"] ==
                                  0) {
                                getDataFavoriteFromApi
                                    .AddItemFavoritePost(
                                    CustomerPhone:
                                    '$UserPhone',
                                    ProductID: categoryDataList
                                        .categoryDateByIdList[
                                    0]
                                    ["ProductID"]
                                        .toString());
                              } else {
                                deletFavorite.DeleteItemFavoritePost(
                                    ProductId: categoryDataList
                                        .categoryDateByIdList[
                                    0]["ProductID"]
                                        .toString());
                              }
                              setState(() {
                                categoryDataList
                                    .categoryDateByIdList[0]
                                [
                                "IsFavorite"] = categoryDataList
                                    .categoryDateByIdList[
                                0]["IsFavorite"] ==
                                    1
                                    ? 0
                                    : 1;
                              });
                            },
                          )
                        ],
                      )
                          : Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${(categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]["PriceAfterDiscount"]).toStringAsFixed(3)}',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                              Text(
                                (lang.activeLanguage
                                    .languageCode ==
                                    'ar')
                                    ? 'د.ك'
                                    : 'K.D',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                              10.horizontalSpace,
                              Text(
                                ' ${categoryDataList.categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]["Price"].toStringAsFixed(3)}',
                                style: TextStyle(
                                  decoration: TextDecoration
                                      .lineThrough,
                                  color: Colors.red,
                                  decorationThickness: 2,
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                              Text(
                                (lang.activeLanguage
                                    .languageCode ==
                                    'ar')
                                    ? 'د.ك'
                                    : 'K.D',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w300,
                                  decoration: TextDecoration
                                      .lineThrough,
                                  color: Colors.red,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: categoryDataList
                                  .categoryDateByIdList[
                              0]["IsFavorite"] ==
                                  1
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              if (categoryDataList
                                  .categoryDateByIdList[
                              0]["IsFavorite"] ==
                                  0) {
                                getDataFavoriteFromApi
                                    .AddItemFavoritePost(
                                    CustomerPhone:
                                    '$UserPhone',
                                    ProductID: categoryDataList
                                        .categoryDateByIdList[
                                    0]
                                    ["ProductID"]
                                        .toString());
                              } else {
                                deletFavorite.DeleteItemFavoritePost(
                                    ProductId: categoryDataList
                                        .categoryDateByIdList[
                                    0]["ProductID"]
                                        .toString());
                              }
                              setState(() {
                                categoryDataList
                                    .categoryDateByIdList[0]
                                [
                                "IsFavorite"] = categoryDataList
                                    .categoryDateByIdList[
                                0]["IsFavorite"] ==
                                    1
                                    ? 0
                                    : 1;
                              });
                            },
                          )
                        ],
                      ),
                      Text(
                        (lang.activeLanguage.languageCode == 'ar')
                            ? '${categoryDataList.categoryDateByIdList[0]["ProductArName"]+' * '+item['UnitValue'].toString()}'
                            : '${categoryDataList.categoryDateByIdList[0]["ProductEnName"]+' * '+item['UnitValue'].toString()}',
                        style:GoogleFonts.tajawal(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),


                      ),
                      10.verticalSpace,
                      if(categoryDataList.categoryDateByIdList[0]["ToDate"]!=null)
                      Text(
                        (lang.activeLanguage.languageCode == 'ar')
                            ? 'تاريخ نهاية العرض: ${DateFormat('dd/MM/yyyy').format(DateFormat('MM/dd/yyyy hh:mm:ss a').parse(categoryDataList.categoryDateByIdList[0]["ToDate"]))}'

                            : 'Offer End Date: ${DateFormat('dd/MM/yyyy').format(DateFormat('MM/dd/yyyy hh:mm:ss a').parse(categoryDataList.categoryDateByIdList[0]["ToDate"]))}',
                        style:GoogleFonts.tajawal(
                          fontSize: 12.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),


                      ),
                      10.verticalSpace,
                      Row(
                          mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                          children: [
                            (item['StockQty'] >=
                                1.0)
                                ? Container(
                              decoration: BoxDecoration(
                                  color:
                                  Colors.green.shade300,
                                  borderRadius:
                                  BorderRadius.circular(
                                      15)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5),
                              child: Text(
                                (lang.activeLanguage
                                    .languageCode ==
                                    'ar')
                                    ? 'متوفر'
                                    : 'available',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight:
                                  FontWeight.normal,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                            )
                                : Container(
                              decoration: BoxDecoration(
                                  color: Colors.red.shade300,
                                  borderRadius:
                                  BorderRadius.circular(
                                      15)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 5),
                              child: Text(
                                (lang.activeLanguage
                                    .languageCode ==
                                    'ar')
                                    ? 'غير متوفر'
                                    : 'unavailable',
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: Colors.white,
                                  fontWeight:
                                  FontWeight.normal,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                            ),
                            Text(
                              'SN : ${categoryDataList.categoryDateByIdList[0]["ProductCode"]}',

                              style:GoogleFonts.rubik(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w300,
                              ),



                            ),
                          ]),
                      5.verticalSpace,
                      if (categoryDataList
                          .categoryDateByIdList[0]
                      ["Product_ColorsSizes"]
                          .length !=
                          0)
                        10.verticalSpace,
                      if (categoryDataList
                          .categoryDateByIdList[0]
                      ["Product_ColorsSizes"]
                          .length !=
                          0)
                        SizedBox(
                          height: 40.h,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics:
                            const AlwaysScrollableScrollPhysics(),
                            itemCount: categoryDataList
                                .categoryDateByIdList[0] // ErroHere
                            ["Product_ColorsSizes"]
                                .length,
                            itemBuilder: (context, index) =>
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      widget.selectedSizeIndex = index;
                                      widget
                                          .sizeIndex = categoryDataList
                                          .categoryDateByIdList[
                                      0]["Product_ColorsSizes"]
                                      [index]["SizeID"];
                                      // q1=listItemOrder.getQuantity2(Size_ID:categoryDataList
                                      //     .categoryDateByIdList[0] ["Product_ColorsSizes"][widget.selectedSizeIndex]
                                      // ["SizeID"]);
                                    });

                                    // print(item["Item_Colors"][index]["Product_ColorsSizes"]);
                                    print('Gamal');
                                    print(
                                        'widget.sizeIndex  ${widget.sizeIndex}');
                                    print(
                                        'widget.sizeIndex  ${widget.sizeIndex.runtimeType}');
                                    print(
                                        'widget.selectedSizeIndex  ${widget.selectedSizeIndex}');
                                    print(listItemOrder.getQuantity(
                                        itemID: categoryDataList
                                            .categoryDateByIdList[0]
                                        [
                                        "Product_ColorsSizes"]
                                        [
                                        widget
                                            .selectedSizeIndex]
                                        ["Barcode"]));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                        (widget.selectedSizeIndex ==
                                            index)
                                            ? Colors.green
                                            : Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      width: 45.w,
                                      child: Center(
                                          child: Text(
                                              '${categoryDataList.categoryDateByIdList[0]["Product_ColorsSizes"][index]["SizeName"]}',

                                              style: GoogleFonts.rubik(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color:
                                                  (widget.selectedSizeIndex ==
                                                      index)
                                                      ? Colors.white
                                                      : Colors
                                                      .black))




                                      ),
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      if (categoryDataList
                          .categoryDateByIdList[0]
                      ["Product_ColorsSizes"]
                          .length !=
                          0)
                        10.verticalSpace,
                      if (categoryDataList
                          .categoryDateByIdList[0]
                      ["Product_ColorsSizes"]
                          .length !=
                          0)
                        SizedBox(
                          height: 40.h,
                          width: MediaQuery.of(context).size.width,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics:
                            const AlwaysScrollableScrollPhysics(),
                            itemCount: 1,
                            itemBuilder: (context, index) =>
                                InkWell(
                                  onTap: () {
                                    print(index);
                                    setState(() {
                                      widget.selectedColorIndex = index;
                                      widget
                                          .colorIndex = categoryDataList
                                          .categoryDateByIdList[
                                      0]["Product_ColorsSizes"]
                                      [index]["ColorID"];
                                    });
                                    // print(item["Item_Colors"][index]["Product_ColorsSizes"]);
                                    print('Gamal');
                                    print(
                                        '${categoryDataList.categoryDateByIdList[0]["Product_ColorsSizes"][widget.selectedSizeIndex]["StockQuantity"]}');
                                    print(
                                        'widget.colorIndex ${widget.colorIndex}');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color:
                                        (widget.selectedColorIndex ==
                                            index)
                                            ? Colors.green
                                            : Colors.white,
                                        borderRadius:
                                        BorderRadius.circular(15),
                                        border: Border.all(
                                          color: Colors.grey,
                                          width: 1,
                                        ),
                                      ),
                                      width: 60.w,
                                      child: Center(
                                          child: Text(
                                              (lang.activeLanguage
                                                  .languageCode ==
                                                  'ar')
                                                  ? '${categoryDataList.categoryDateByIdList[0]["Product_ColorsSizes"][index]["ColorArName"]}'
                                                  : '${categoryDataList.categoryDateByIdList[0]["Product_ColorsSizes"][index]["ColorEnName"]}',
                                              style: TextStyle(
                                                  fontWeight:
                                                  FontWeight.bold,
                                                  color:
                                                  (widget.selectedColorIndex ==
                                                      index)
                                                      ? Colors.white
                                                      : Colors
                                                      .black))),
                                    ),
                                  ),
                                ),
                          ),
                        ),
                      // 5.verticalSpace,
                      // Text(
                      //   (lang.activeLanguage.languageCode == 'ar')?
                      //   'برجاء اختياره وحده واحده فقط لكل صنف':
                      //   'Please select one and one only for each category',
                      //   style: GoogleFonts.tajawal(
                      //       fontSize: 14.sp,
                      //       fontWeight: FontWeight.bold,color: Colors.grey,

                      //   ),




                      // ),
                    
                    
                      5.verticalSpace,
                      Text(
                        (lang.activeLanguage.languageCode == 'ar')?
                        'التفاصيل':
                        'Details',







                        style: GoogleFonts.tajawal(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,color: Colors.black,

                        ),




                      ),
                    
                      const SizedBox(height: 5),
                      Text(
                        '${categoryDataList.categoryDateByIdList[0]["Specification"]}',







                        style: GoogleFonts.tajawal(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,color: Colors.grey
                        ),




                      ),

                      const SizedBox(height: 10),
                      Text(
                        (lang.activeLanguage.languageCode == 'ar')?
                        'الحجم':
                        'Size',







                        style: GoogleFonts.tajawal(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.normal,color: Colors.black
                        ),




                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        height: 80.h,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          physics:
                          const AlwaysScrollableScrollPhysics(),
                          itemCount: categoryDataList
                              .categoryDateByIdList[0]["Product_Images"].length,
                          itemBuilder: (context, index) =>
                              InkWell(
                                onTap: () {
                                  print(index);
                                  setState(() {
                                    widget.selectedImageUnitIndex = index;
                                      Fluttertoast.showToast(msg: 'برجاء اختياره وحده واحده فقط لكل صنف',
                                      toastLength: Toast.LENGTH_LONG
                                      );

                                    // widget
                                    //     .colorIndex = categoryDataList
                                    //     .categoryDateByIdList[
                                    // 0]["Product_ColorsSizes"]
                                    // [index]["ColorID"];
                                  });
                                  print(categoryDataList.categoryDateByIdList[0]["Product_Images"]);
                                  print(categoryDataList.categoryDateByIdList[0]["Product_Images"][index]);
                                  print(categoryDataList.categoryDateByIdList[0]["Product_Images"][index]["UnitArName"]);
                                  // print(item["Item_Colors"][index]["Product_ColorsSizes"]);
                                  // print('Gamal');
                                  // print(
                                  //     '${categoryDataList.categoryDateByIdList[0]["Product_ColorsSizes"][widget.selectedSizeIndex]["StockQuantity"]}');
                                  // print(
                                  //     'widget.colorIndex ${widget.colorIndex}');
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5.0),
                                  child: Container(

                                    decoration: BoxDecoration(
                                      color:
                                    Colors.white,
                                      borderRadius:
                                      BorderRadius.circular(5),
                                      border: Border.all(
                                        color:

                                        (widget.selectedImageUnitIndex ==
                                            index)
                                            ? Colors.black
                                            : Colors.grey,
                                        width: 1,
                                      ),
                                    ),
                                    width: 100,

                                    child: Center(
                                        child: Text(
                                            (lang.activeLanguage
                                                .languageCode ==
                                                'ar')
                                                ? '${categoryDataList.categoryDateByIdList[0]["Product_Images"][index]["UnitArName"]??''}'
                                                : '${categoryDataList.categoryDateByIdList[0]["Product_Images"][index]["UnitEnName"]??''}',
                                            style: const TextStyle(
                                                fontWeight:
                                                FontWeight.bold,
                                                color:
                                                Colors
                                                    .black))),
                                  ),
                                ),
                              ),
                        ),
                      ),


                      const SizedBox(height: 10),



                      if (categoryDataList
                          .categoryDateByIdList[0]
                      ["Product_ColorsSizes"]
                          .length !=
                          0)
                        // SizedBox(
                        //   height: 40.h,
                        //   width: MediaQuery.of(context).size.width,
                        //   child: ListView.builder(
                        //     scrollDirection: Axis.horizontal,
                        //     shrinkWrap: true,
                        //     physics:
                        //     const AlwaysScrollableScrollPhysics(),
                        //     itemCount: 1,
                        //     itemBuilder: (context, index) =>
                        //         InkWell(
                        //           onTap: () {
                        //             print(index);
                        //             setState(() {
                        //               widget.selectedColorIndex = index;
                        //               widget
                        //                   .colorIndex = categoryDataList
                        //                   .categoryDateByIdList[
                        //               0]["Product_ColorsSizes"]
                        //               [index]["ColorID"];
                        //             });
                        //             // print(item["Item_Colors"][index]["Product_ColorsSizes"]);
                        //             print('Gamal');
                        //             print(
                        //                 '${categoryDataList.categoryDateByIdList[0]["Product_ColorsSizes"][widget.selectedSizeIndex]["StockQuantity"]}');
                        //             print(
                        //                 'widget.colorIndex ${widget.colorIndex}');
                        //           },
                        //           child: Padding(
                        //             padding: const EdgeInsets.symmetric(
                        //                 horizontal: 5.0),
                        //             child: Container(
                        //               decoration: BoxDecoration(
                        //                 color:
                        //                 (widget.selectedColorIndex ==
                        //                     index)
                        //                     ? Colors.green
                        //                     : Colors.white,
                        //                 borderRadius:
                        //                 BorderRadius.circular(15),
                        //                 border: Border.all(
                        //                   color: Colors.grey,
                        //                   width: 1,
                        //                 ),
                        //               ),
                        //               width: 60.w,
                        //               child: Center(
                        //                   child: Text(
                        //                       (lang.activeLanguage
                        //                           .languageCode ==
                        //                           'ar')
                        //                           ? '${categoryDataList.categoryDateByIdList[0]["Product_ColorsSizes"][index]["ColorArName"]}'
                        //                           : '${categoryDataList.categoryDateByIdList[0]["Product_ColorsSizes"][index]["ColorEnName"]}',
                        //                       style: TextStyle(
                        //                           fontWeight:
                        //                           FontWeight.bold,
                        //                           color:
                        //                           (widget.selectedColorIndex ==
                        //                               index)
                        //                               ? Colors.white
                        //                               : Colors
                        //                               .black))),
                        //             ),
                        //           ),
                        //         ),
                        //   ),
                        // ),
                 
                      const SizedBox(height: 10),
                      (q1 == 0)
                          ? InkWell(
                        onTap: () {
                          print(item['GiftQTY']);

                          print('UserPhoneAll${UserPhoneAll}');
                          print('User Phone${UserPhone}');
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
                                      color: Color(0xff000000),
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
                                        label:  (lang.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',
                                        hintText:  (lang.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',

                                        controller: customPhoneGuestController,
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

                                        print('UserPhone All  ${UserPhoneAll}');

                                        print('UserPhone   ${UserPhone}');

                                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                        //   return MainPage();
                                        // }));
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
                                          (true)?

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
                            if (categoryDataList
                                .categoryDateByIdList[0]
                            ["Product_ColorsSizes"]
                                .length !=
                                0) {
                              if (q1 <
                                  categoryDataList.categoryDateByIdList[
                                  0][
                                  "Product_ColorsSizes"]
                                  [widget
                                      .selectedSizeIndex]
                                  ["StockQuantity"]) {
                                setState(() {
                                  q1++;
                                  if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                  {
                                    if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                      q1 += item['GiftQTY'];
                                      item["Y_Gift_Qty"]++;

                                      y++;
                                      print('ysssssss${y}');

                                    }


                                  }
                                });
                                listItemOrder.addItem({
                                  "ItemID": categoryDataList
                                      .categoryDateByIdList[
                                  0]["ProductID"],
                                  "Quantity": q1,
                                  "Price": categoryDataList
                                      .categoryDateByIdList[
                                  0]["PriceAfterDiscount"],
                                  "StockQuantity": categoryDataList
                                      .categoryDateByIdList[0]
                                  [
                                  "Product_ColorsSizes"]
                                  [widget
                                      .selectedSizeIndex]
                                  ["StockQuantity"],
                                  "BarCode": categoryDataList
                                      .categoryDateByIdList[0]
                                  [
                                  "Product_ColorsSizes"]
                                  [widget
                                      .selectedSizeIndex]["Barcode"],
                                  "Colors_ID": (categoryDataList
                                      .categoryDateByIdList[
                                  0][
                                  "Product_ColorsSizes"]
                                      .length !=
                                      0)
                                      ? widget.colorIndex
                                      : '',
                                  "Size_ID": (categoryDataList
                                      .categoryDateByIdList[
                                  0][
                                  "Product_ColorsSizes"]
                                      .length !=
                                      0)
                                      ? widget.sizeIndex
                                      : '',
                                  "RequiredQTY":item['RequiredQTY'],
                                  "GiftQTY":item['GiftQTY'],
                                  "Y_Gift_Qty":y,
                                });
                                listItemOrderImage.addItem({
                                  "image": categoryDataList
                                      .categoryDateByIdList[
                                  0]["ProductcImage"],
                                  "ItemID": categoryDataList
                                      .categoryDateByIdList[
                                  0]["ProductID"],
                                  "Quantity": q1,
                                  "Price": categoryDataList
                                      .categoryDateByIdList[
                                  0]["PriceAfterDiscount"],
                                  "ProductArName": categoryDataList
                                      .categoryDateByIdList[
                                  0]["ProductArName"]
                                      +' * '+item['UnitValue'].toString(),
                                  "ProductEnName": categoryDataList
                                      .categoryDateByIdList[
                                  0]["ProductEnName"]
                                +' * '+item['UnitValue'].toString(),
                                  "StockQuantity": categoryDataList
                                      .categoryDateByIdList[0]
                                  [
                                  "Product_ColorsSizes"]
                                  [widget
                                      .selectedSizeIndex]
                                  ["StockQuantity"],
                                  "BarCode": categoryDataList
                                      .categoryDateByIdList[0]
                                  [
                                  "Product_ColorsSizes"]
                                  [widget
                                      .selectedSizeIndex]["Barcode"],
                                  "Colors_ID": (categoryDataList
                                      .categoryDateByIdList[
                                  0][
                                  "Product_ColorsSizes"]
                                      .length !=
                                      0)
                                      ? widget.colorIndex
                                      : '',
                                  "Size_ID": (categoryDataList
                                      .categoryDateByIdList[
                                  0][
                                  "Product_ColorsSizes"]
                                      .length !=
                                      0)
                                      ? widget.sizeIndex
                                      : '',
                                  "RequiredQTY":item['RequiredQTY'],
                                  "GiftQTY":item['GiftQTY'],
                                  "Y_Gift_Qty":y,
                                });
                              }
                            } else {
                                                if (categoryDataList
                                                            .categoryDateByIdList
                                                [0]["Product_Images"][widget.selectedImageUnitIndex]["CustomerQuantity"] >
                                                    0.0) {
                                                  if (q1 <
                                                      categoryDataList
                                                              .categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]["CustomerQuantity"]
                                                     ) {
                                                    setState(() {
                                                      q1++;
                                                      if (item['GiftQTY'] > 0 &&
                                                          item['RequiredQTY'] >
                                                              0) {
                                                        if ((q1 -
                                                                    item['GiftQTY'] *
                                                                        item[
                                                                            "Y_Gift_Qty"]) %
                                                                item[
                                                                    'RequiredQTY'] ==
                                                            0) {
                                                          q1 += item['GiftQTY'];
                                                          item["Y_Gift_Qty"]++;

                                                          y++;
                                                        }
                                                      }
                                                    });
                                                    listItemOrder.addItem({
                                                      "ItemID": item["ProductID"],
                                                      "Quantity": q1,
                                                      "Price": item
                                                          [
                                                          "PriceAfterDiscount"],
                                                      "StockQuantity":
                                                      item
                                                              ["StockQty"],
                                                      "BarCode": item["Barcode"],
                                                      "Colors_ID": (categoryDataList
                                                                  .categoryDateByIdList[
                                                                      0][
                                                                      "Product_ColorsSizes"]
                                                                  .length !=
                                                              0)
                                                          ? widget.colorIndex
                                                          : '',
                                                      "Size_ID": (categoryDataList
                                                                  .categoryDateByIdList[
                                                                      0][
                                                                      "Product_ColorsSizes"]
                                                                  .length !=
                                                              0)
                                                          ? widget.sizeIndex
                                                          : '',
                                                      "RequiredQTY":
                                                          item['RequiredQTY'],
                                                      "GiftQTY":
                                                          item['GiftQTY'],
                                                      "Y_Gift_Qty": y,
                                                    });
                                                    listItemOrderImage.addItem({
                                                      "image": item["ImagePath"],
                                                      "ItemID":item["ProductID"],
                                                      "Quantity": q1,
                                                      "Price": item
                                                          [
                                                          "PriceAfterDiscount"],
                                                      "ProductArName":
                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                      "ProductEnName":
                                                      item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                      "StockQuantity":
                                                      item
                                                              ["StockQty"],
                                                      "CustomerQuantity":
                                                      item
                                                              [
                                                              "CustomerQuantity"],
                                                      "BarCode": item["Barcode"],
                                                      "Colors_ID": (categoryDataList
                                                                  .categoryDateByIdList[
                                                                      0][
                                                                      "Product_ColorsSizes"]
                                                                  .length !=
                                                              0)
                                                          ? widget.colorIndex
                                                          : '',
                                                      "Size_ID": (categoryDataList
                                                                  .categoryDateByIdList[
                                                                      0][
                                                                      "Product_ColorsSizes"]
                                                                  .length !=
                                                              0)
                                                          ? widget.sizeIndex
                                                          : '',
                                                      "RequiredQTY":
                                                          item['RequiredQTY'],
                                                      "GiftQTY":
                                                          item['GiftQTY'],
                                                      "Y_Gift_Qty": y,
                                                    });
                                                  }


                                                  print('-----------------------------------');
                                                  print('q1 ============== $q1');
                                                  print('y ==============$y');
                                                  print('GiftQty ==============${item['GiftQTY']}');
                                                  print( ' Required Qut================${item['RequiredQTY']}');
                                                  print('------------------------------------');
                                                }


                                                else  if (categoryDataList
                                                    .categoryDateByIdList
                                                [0]["Product_Images"][widget.selectedImageUnitIndex]["CustomerQtyFree"] >
                                                    0.0) {
                                                  if (q1 <
                                                      categoryDataList
                                                          .categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]["CustomerQtyFree"]
                                                  ) {
                                                    setState(() {
                                                      q1++;
                                                      if (item['GiftQTY'] > 0 &&
                                                          item['RequiredQTY'] >
                                                              0) {
                                                        if ((q1 -
                                                            item['GiftQTY'] *
                                                                item[
                                                                "Y_Gift_Qty"]) %
                                                            item[
                                                            'RequiredQTY'] ==
                                                            0) {
                                                          q1 += item['GiftQTY'];
                                                          item["Y_Gift_Qty"]++;

                                                          y++;
                                                        }
                                                      }
                                                    });
                                                    listItemOrder.addItem({
                                                      "ItemID": item["ProductID"],
                                                      "Quantity": q1,
                                                      "Price": item
                                                      [
                                                      "PriceAfterDiscount"],
                                                      "StockQuantity":
                                                      item
                                                      ["StockQty"],
                                                      "BarCode": item["Barcode"],
                                                      "Colors_ID": (categoryDataList
                                                          .categoryDateByIdList[
                                                      0][
                                                      "Product_ColorsSizes"]
                                                          .length !=
                                                          0)
                                                          ? widget.colorIndex
                                                          : '',
                                                      "Size_ID": (categoryDataList
                                                          .categoryDateByIdList[
                                                      0][
                                                      "Product_ColorsSizes"]
                                                          .length !=
                                                          0)
                                                          ? widget.sizeIndex
                                                          : '',
                                                      "RequiredQTY":
                                                      item['RequiredQTY'],
                                                      "GiftQTY":
                                                      item['GiftQTY'],
                                                      "Y_Gift_Qty": y,
                                                    });
                                                    listItemOrderImage.addItem({
                                                      "image": item["ImagePath"],
                                                      "ItemID":item["ProductID"],
                                                      "Quantity": q1,
                                                      "Price": item
                                                      [
                                                      "PriceAfterDiscount"],
                                                      "ProductArName":
                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                      "ProductEnName":
                                                      item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                      "StockQuantity":
                                                      item
                                                      ["StockQty"],
                                                      "CustomerQuantity":
                                                      item
                                                      [
                                                      "CustomerQtyFree"],
                                                      "BarCode": item["Barcode"],
                                                      "Colors_ID": (categoryDataList
                                                          .categoryDateByIdList[
                                                      0][
                                                      "Product_ColorsSizes"]
                                                          .length !=
                                                          0)
                                                          ? widget.colorIndex
                                                          : '',
                                                      "Size_ID": (categoryDataList
                                                          .categoryDateByIdList[
                                                      0][
                                                      "Product_ColorsSizes"]
                                                          .length !=
                                                          0)
                                                          ? widget.sizeIndex
                                                          : '',
                                                      "RequiredQTY":
                                                      item['RequiredQTY'],
                                                      "GiftQTY":
                                                      item['GiftQTY'],
                                                      "Y_Gift_Qty": y,
                                                    });
                                                  }


                                                  print('-----------------------------------');
                                                  print('q1 ============== $q1');
                                                  print('y ==============$y');
                                                  print('GiftQty ==============${item['GiftQTY']}');
                                                  print( ' Required Qut================${item['RequiredQTY']}');
                                                  print('------------------------------------');
                                                }




                                                else {
                                                  if (q1 <
                                                      item["StockQty"]) {
                                                    setState(() {
                                                      q1++;
                                                      if (item['GiftQTY'] > 0 &&
                                                          item['RequiredQTY'] >
                                                              0) {
                                                        if ((q1 -
                                                                    item['GiftQTY'] *
                                                                        item[
                                                                            "Y_Gift_Qty"]) %
                                                                item[
                                                                    'RequiredQTY'] ==
                                                            0) {
                                                          q1 += item['GiftQTY'];
                                                          item["Y_Gift_Qty"]++;

                                                          y++;
                                                          print('ysssssss${y}');
                                                        }
                                                      }
                                                    });
                                                    listItemOrder.addItem({
                                                      "ItemID": item["ProductID"],
                                                      "Quantity": q1,
                                                      "Price": item
                                                          [
                                                          "PriceAfterDiscount"],
                                                      "StockQuantity":
                                                      item
                                                              ["StockQty"],
                                                      "BarCode": item["Barcode"],
                                                      "Colors_ID": (categoryDataList
                                                                  .categoryDateByIdList[
                                                                      0][
                                                                      "Product_ColorsSizes"]
                                                                  .length !=
                                                              0)
                                                          ? widget.colorIndex
                                                          : '',
                                                      "Size_ID": (categoryDataList
                                                                  .categoryDateByIdList[
                                                                      0][
                                                                      "Product_ColorsSizes"]
                                                                  .length !=
                                                              0)
                                                          ? widget.sizeIndex
                                                          : '',
                                                      "RequiredQTY":
                                                          item['RequiredQTY'],
                                                      "GiftQTY":
                                                          item['GiftQTY'],
                                                      "Y_Gift_Qty": y,
                                                    });
                                                    listItemOrderImage.addItem({
                                                      "image": item["ImagePath"],
                                                      "ItemID":item["ProductID"],
                                                      "Quantity": q1,
                                                      "Price": item
                                                          [
                                                          "PriceAfterDiscount"],
                                                      "ProductArName":
                                                      item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                      "ProductEnName":
                                                      item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                                      "StockQuantity":
                                                      item
                                                              ["StockQty"],
                                                      "CustomerQuantity":
                                                      item
                                                              [
                                                              "CustomerQuantity"],
                                                      "BarCode": item["Barcode"],
                                                      "Colors_ID": (categoryDataList
                                                                  .categoryDateByIdList[
                                                                      0][
                                                                      "Product_ColorsSizes"]
                                                                  .length !=
                                                              0)
                                                          ? widget.colorIndex
                                                          : '',
                                                      "Size_ID": (categoryDataList
                                                                  .categoryDateByIdList[
                                                                      0][
                                                                      "Product_ColorsSizes"]
                                                                  .length !=
                                                              0)
                                                          ? widget.sizeIndex
                                                          : '',
                                                      "RequiredQTY":
                                                          item['RequiredQTY'],
                                                      "GiftQTY":
                                                          item['GiftQTY'],
                                                      "Y_Gift_Qty": y,
                                                    });
                                                  }
                                                }

                                                print('**************************************');
                                                print('q1 ============== $q1');
                                                print('y ==============$y');
                                                print('GiftQty ==============${item['GiftQTY']}');
                                                print( ' Required Qut================${item['RequiredQTY']}');
                                                print('**************************************');
                                              }
                          }


                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius:
                                BorderRadius.circular(5),
                                color:
                                Colors.orange.shade700),
                            height: 45,
                            width: MediaQuery.of(context)
                                .size
                                .width,
                            child: Center(
                                child: Text(
                                  (lang.activeLanguage
                                      .languageCode ==
                                      'ar')
                                      ? 'اضف للسله'
                                      : 'Add To Cart',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                )),
                          ),
                        ),
                      )
                          : Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(5),
                              color: Colors.orange.shade700),
                          height: 45,
                          child: Row(
                            children: [
                              Expanded(
                                child: TextButton(
                                  onPressed: () {

                                    if (categoryDataList
                                        .categoryDateByIdList[
                                    0][
                                    "Product_ColorsSizes"]
                                        .length !=
                                        0) {
                                      if (q1 <
                                          categoryDataList.categoryDateByIdList[
                                          0][
                                          "Product_ColorsSizes"]
                                          [widget
                                              .selectedSizeIndex]
                                          [
                                          "StockQuantity"]) {
                                        setState(() {
                                          q1++;
                                          if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                          {
                                            if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                              q1 += item['GiftQTY'];
                                              item["Y_Gift_Qty"]++;

                                              y++;
                                              print('ysssssss${y}');

                                            }


                                          }
                                        });
                                        listItemOrder
                                            .addItem({
                                          "ItemID": categoryDataList
                                              .categoryDateByIdList[
                                          0]["ProductID"],
                                          "Quantity": q1,
                                          "Price": categoryDataList
                                              .categoryDateByIdList[0]
                                          [
                                          "PriceAfterDiscount"],
                                          "StockQuantity": categoryDataList
                                              .categoryDateByIdList[0]
                                          [
                                          "Product_ColorsSizes"]
                                          [widget
                                              .selectedSizeIndex]
                                          [
                                          "StockQuantity"],
                                          "BarCode": categoryDataList
                                              .categoryDateByIdList[0]
                                          [
                                          "Product_ColorsSizes"]
                                          [widget
                                              .selectedSizeIndex]["Barcode"],
                                          "Colors_ID": (categoryDataList
                                              .categoryDateByIdList[
                                          0][
                                          "Product_ColorsSizes"]
                                              .length !=
                                              0)
                                              ? widget
                                              .colorIndex
                                              : '',
                                          "Size_ID": (categoryDataList
                                              .categoryDateByIdList[
                                          0][
                                          "Product_ColorsSizes"]
                                              .length !=
                                              0)
                                              ? widget
                                              .sizeIndex
                                              : '',
                                          "RequiredQTY":item['RequiredQTY'],
                                          "GiftQTY":item['GiftQTY'],
                                          "Y_Gift_Qty":y,
                                        });
                                        listItemOrderImage
                                            .addItem({
                                          "image": categoryDataList
                                              .categoryDateByIdList[0]
                                          [
                                          "ProductcImage"],
                                          "ItemID": categoryDataList
                                              .categoryDateByIdList[
                                          0]["ProductID"],
                                          "Quantity": q1,
                                          "Price": categoryDataList
                                              .categoryDateByIdList[0]
                                          [
                                          "PriceAfterDiscount"],
                                          "ProductArName": categoryDataList
                                              .categoryDateByIdList[0]
                                          [
                                          "ProductArName"] +
                                              categoryDataList
                                                  .categoryDateByIdList[0]
                                              [
                                              "Product_ColorsSizes"]
                                              [widget
                                                  .selectedSizeIndex]
                                              [
                                              "SizeName"],
                                          "ProductEnName": categoryDataList
                                              .categoryDateByIdList[0]
                                          [
                                          "ProductEnName"] +
                                              categoryDataList
                                                  .categoryDateByIdList[0]
                                              [
                                              "Product_ColorsSizes"]
                                              [widget
                                                  .selectedSizeIndex]
                                              [
                                              "SizeName"],
                                          "StockQuantity": categoryDataList
                                              .categoryDateByIdList[0]
                                          [
                                          "Product_ColorsSizes"]
                                          [widget
                                              .selectedSizeIndex]
                                          [
                                          "StockQuantity"],
                                          "BarCode": categoryDataList
                                              .categoryDateByIdList[0]
                                          [
                                          "Product_ColorsSizes"]
                                          [widget
                                              .selectedSizeIndex]["Barcode"],
                                          "Colors_ID": (categoryDataList
                                              .categoryDateByIdList[
                                          0][
                                          "Product_ColorsSizes"]
                                              .length !=
                                              0)
                                              ? widget
                                              .colorIndex
                                              : '',
                                          "Size_ID": (categoryDataList
                                              .categoryDateByIdList[
                                          0][
                                          "Product_ColorsSizes"]
                                              .length !=
                                              0)
                                              ? widget
                                              .sizeIndex
                                              : '',
                                          "RequiredQTY":item['RequiredQTY'],
                                          "GiftQTY":item['GiftQTY'],
                                          "Y_Gift_Qty":y,
                                        });
                                    
                                      }
                                    } else {
                                      if ( item[
                                      "CustomerQuantity"] >
                                          0.0) {
                                        if (q1 <
                                            item
                                            [
                                            "StockQty"] &&
                                            q1 <
                                                item
                                                [
                                                "CustomerQuantity"]) {
                                          setState(() {
                                            q1++;
                                            if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                            {
                                              if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                q1 += item['GiftQTY'];
                                                item["Y_Gift_Qty"]++;

                                                y++;
                                                print('ysssssss${y}');

                                              }


                                            }
                                          });
                                          listItemOrder
                                              .addItem({
                                            "ItemID":  item
                                            ["ProductID"],
                                            "Quantity": q1,
                                            "Price":  item
                                            [
                                            "PriceAfterDiscount"],
                                            "StockQty":
                                            item
                                            [
                                            "StockQuantity"],
                                            "BarCode":  item["Barcode"],
                                            "Colors_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0]
                                            [
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget
                                                .colorIndex
                                                : '',
                                            "Size_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0]
                                            [
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget
                                                .sizeIndex
                                                : '',
                                            "RequiredQTY":item['RequiredQTY'],
                                            "GiftQTY":item['GiftQTY'],
                                            "Y_Gift_Qty":y,
                                          });
                                          listItemOrderImage
                                              .addItem({
                                            "image":  item
                                            [
                                            "ImagePath"],
                                            "ItemID":  item
                                            ["ProductID"],
                                            "Quantity": q1,
                                            "Price":  item
                                            [
                                            "PriceAfterDiscount"],
                                            "ProductArName":
                                            item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                            "ProductEnName":
                                            item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                            "StockQuantity":
                                           item
                                            [
                                            "StockQty"],
                                            "BarCode":  item["Barcode"],
                                            "Colors_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0]
                                            [
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget
                                                .colorIndex
                                                : '',
                                            "Size_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0]
                                            [
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget
                                                .sizeIndex
                                                : '',
                                            "RequiredQTY":item['RequiredQTY'],
                                            "GiftQTY":item['GiftQTY'],
                                            "Y_Gift_Qty":y,
                                          });
                                        }
                                      }

                                      else  if (item["CustomerQtyFree"] > 0.0&&q1 <
                                          item
                                          [
                                          "StockQty"]) {
                                        if (q1 <
                                            categoryDataList
                                                .categoryDateByIdList[0]["Product_Images"][widget.selectedImageUnitIndex]["CustomerQtyFree"]
                                            &&q1 <
                                                item
                                                [
                                                "StockQty"] ) {
                                          setState(() {
                                            q1++;
                                            if (item['GiftQTY'] > 0 &&
                                                item['RequiredQTY'] >
                                                    0) {
                                              if ((q1 -
                                                  item['GiftQTY'] *
                                                      item[
                                                      "Y_Gift_Qty"]) %
                                                  item[
                                                  'RequiredQTY'] ==
                                                  0) {
                                                q1 += item['GiftQTY'];
                                                item["Y_Gift_Qty"]++;

                                                y++;
                                              }
                                            }
                                          });
                                          listItemOrder.addItem({
                                            "ItemID": item["ProductID"],
                                            "Quantity": q1,
                                            "Price": item
                                            [
                                            "PriceAfterDiscount"],
                                            "StockQuantity":
                                            item
                                            ["StockQty"],
                                            "BarCode": item["Barcode"],
                                            "Colors_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0][
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget.colorIndex
                                                : '',
                                            "Size_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0][
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget.sizeIndex
                                                : '',
                                            "RequiredQTY":
                                            item['RequiredQTY'],
                                            "GiftQTY":
                                            item['GiftQTY'],
                                            "Y_Gift_Qty": y,
                                          });
                                          listItemOrderImage.addItem({
                                            "image": item["ImagePath"],
                                            "ItemID":item["ProductID"],
                                            "Quantity": q1,
                                            "Price": item
                                            [
                                            "PriceAfterDiscount"],
                                            "ProductArName":
                                            item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                            "ProductEnName":
                                            item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                            "StockQuantity":
                                            item
                                            ["StockQty"],
                                            "CustomerQuantity":
                                            item
                                            [
                                            "CustomerQtyFree"],
                                            "BarCode": item["Barcode"],
                                            "Colors_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0][
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget.colorIndex
                                                : '',
                                            "Size_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0][
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget.sizeIndex
                                                : '',
                                            "RequiredQTY":
                                            item['RequiredQTY'],
                                            "GiftQTY":
                                            item['GiftQTY'],
                                            "Y_Gift_Qty": y,
                                          });
                                        }


                                        print('-----------------------------------');
                                        print('q1 ============== $q1');
                                        print('y ==============$y');
                                        print('GiftQty ==============${item['GiftQTY']}');
                                        print( ' Required Qut================${item['RequiredQTY']}');
                                        print('------------------------------------');
                                      }

                                      else {
                                        if (q1 <
                                            item
                                        [
                                        "StockQty"]) {
                                          setState(() {
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
                                            "ItemID":  item
                                            ["ProductID"],
                                            "Quantity": q1,
                                            "Price":  item
                                            [
                                            "PriceAfterDiscount"],
                                            "StockQuantity":
                                            item
                                            [
                                            "StockQty"],
                                            "BarCode":  item["Barcode"],
                                            "Colors_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0]
                                            [
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget
                                                .colorIndex
                                                : '',
                                            "Size_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0]
                                            [
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget
                                                .sizeIndex
                                                : '',
                                            "RequiredQTY":item['RequiredQTY'],
                                            "GiftQTY":item['GiftQTY'],
                                            "Y_Gift_Qty":y,
                                          });
                                          listItemOrderImage
                                              .addItem({
                                            "image":  item
                                            [
                                            "ImagePath"],
                                            "ItemID":  item
                                            ["ProductID"],
                                            "Quantity": q1,
                                            "Price":  item
                                            [
                                            "PriceAfterDiscount"],
                                            "ProductArName":
                                            item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                            "ProductEnName":
                                            item["ProductEnName"] +' * '+item['UnitValue'].toString(),
                                            "StockQuantity":
                                            item
                                            [
                                            "StockQty"],
                                            "BarCode":  item["Barcode"],
                                            "Colors_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0]
                                            [
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget
                                                .colorIndex
                                                : '',
                                            "Size_ID": (categoryDataList
                                                .categoryDateByIdList[
                                            0]
                                            [
                                            "Product_ColorsSizes"]
                                                .length !=
                                                0)
                                                ? widget
                                                .sizeIndex
                                                : '',
                                            "RequiredQTY":item['RequiredQTY'],
                                            "GiftQTY":item['GiftQTY'],
                                            "Y_Gift_Qty":y,
                                          });
                                        }
                                      }
                                    }
                                  },
                                  child: Text(
                                    '+',
                                    style: TextStyle(
                                      fontSize: 22.sp,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.normal,
                                      fontFamily: 'Monadi',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Center(
                                  child: Text(
                                    '$q1',
                                    maxLines: 2,
                                    overflow:
                                    TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.bold,
                                      fontFamily: 'Monadi',
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: TextButton(
                                  onPressed: () {
                                    if (q1 > 0) {
                                      setState(() {
                                        q1--; // قلل الكمية الأساسية

                                      });
                                      print('//////////////////////////////////////');
                                      print('q1 ============== $q1');
                                      print('y ==============$y');
                                      print('GiftQty ==============${item['GiftQTY']}');
                                      print( ' Required Qut================${item['RequiredQTY']}');
                                      print('//////////////////////////////////////');
                                    }
                                    if (q1 == 0) {
                                      setState(() {
                                        checkButtonSalla =
                                        false;
                                      });
                                    }
                                    listItemOrder.decreaseQuantity(
                                      item["Barcode"],);
                                    listItemOrderImage
                                        .decreaseQuantity(
                                      item["Barcode"],);
                                  },
                                  child: Text(
                                    '-',
                                    style: TextStyle(
                                      fontSize: 20.sp,
                                      color: Colors.white,
                                      fontWeight:
                                      FontWeight.normal,
                                      fontFamily: 'Monadi',
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),


































                      40.verticalSpace,










                      Text(
                        (lang.activeLanguage.languageCode == 'ar')
                            ? 'منتجات متشابهة'
                            : 'Similar products',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Monadi',
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),




























            isLoadingTwo
                ?  const CircularProgressIndicator(color: Colors.orange,):

            Consumer(builder: (context, ref, child) {
              final getDataCategoryItemFromApi =

              ref.watch(getProductsFromApi);
              final getDataFavoriteFromApi =
              ref.watch(addItemFavoriteProvider);
              final deletFavorite = ref.watch(deleteItemFavoriteProvider);
              final listItemOrder = ref.watch(orderProviderList);
              final listItemOrderImage =
              ref.watch(orderProviderListImage);




              isSecondContainerVisibleList = List.generate(
                  getDataCategoryItemFromApi.productsList.length,
                      (index) => false);
              itemLoveStates = List.generate(
                  getDataCategoryItemFromApi.productsList.length,
                      (index) => false);

              return

                getDataCategoryItemFromApi.iSLoading?
                const CircularProgressIndicator(color: Colors.orange,)       :

                SizedBox(
                  height: 210.h,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount:
                    (getDataCategoryItemFromApi.productsList[0]["Products"].length??getDataCategoryItemFromApi.productsList.length)??0,
                    itemBuilder: (context, index) {
                      final item =
                          (getDataCategoryItemFromApi.productsList[0]["Products"][index]);
                     num q1 = listItemOrder.getQuantity(
                          itemID: item['BarCode']);
                      num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]);
                      return


                        (item==null)?
                        const CircularProgressIndicator(color: Colors.orange,)
                            :Card(
                          color: Colors.white,
                          child: Container(
                            color: Colors.white,
                            width: 180.w,
                            child: InkWell(
                              onTap: () {


                                Navigator.push(
                                  context,
                                  //   //getDataFromApi.dataCategoryAllList[index]["productId"]
                                  MaterialPageRoute(
                                      builder: (context) => BannerDetailsPage(
                                        productId: item["ProductID"],
                                        CategoryId: item["CategoryId"],
                                        name: (lang.activeLanguage
                                            .languageCode ==
                                            'ar')
                                            ? item['ProductArName']
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
                                                if (widget.CategoryId != 2151)
                                                  GestureDetector(
                                                    onTap: () {
                                                      if((UserPhoneAll??UserPhone)==null)
                                                      {

                                                        showDialog(
                                                          context: context,
                                                          barrierDismissible: false,
                                                          builder: (_) => AlertDialog(

                                                              content: Text(
                                                                (lang.activeLanguage.languageCode == 'ar')?
                                                                "يرجى ادخال رقم الهاتف":"Please Enter Number Phone",
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
                                                                    label:  (lang.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',
                                                                    hintText:  (lang.activeLanguage.languageCode == 'ar')?'رقم الموبيل':'Mobial Number',

                                                                    controller: customPhoneGuestController,
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



                                                                    // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                    //   return MainPage();
                                                                    // }));
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
                                                                      (lang.activeLanguage.languageCode == 'ar')?

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
                                                          isSecondContainerVisibleList2[
                                                          index] =
                                                          !isSecondContainerVisibleList2[
                                                          index];
                                                          // isSecondContainerVisible =
                                                          // !isSecondContainerVisible;
                                                        });

                                                        setState(() {
                                                          if (q1 == 0) {
                                                            q1++;
                                                            if(item['GiftQTY']>0&&item['RequiredQTY']>0)
                                                            {
                                                              if ((q1 - item['GiftQTY'] * item["Y_Gift_Qty"]) % item['RequiredQTY'] == 0) {
                                                                q1 += item['GiftQTY'];
                                                                item["Y_Gift_Qty"]++;

                                                                y++;
                                                                print('ysssssss${y}');

                                                              }


                                                            }

                                                          }
                                                          listItemOrder
                                                              .addItem({
                                                            "ItemID": item[
                                                            "ProductID"],
                                                            "Quantity": q1,
                                                            "Price": item[
                                                            "PriceAfterDiscount"],
                                                            "StockQuantity": item[
                                                            "StockQuantity"],
                                                            "BarCode":
                                                            item["BarCode"],
                                                            "Colors_ID": '',
                                                            "Size_ID": '',
                                                            "RequiredQTY":item['RequiredQTY'],
                                                            "GiftQTY":item['GiftQTY'],
                                                            "Y_Gift_Qty":y,
                                                          });
                                                          listItemOrderImage
                                                              .addItem({
                                                            "image": item[
                                                            'ProductcImage'],
                                                            "ItemID": item[
                                                            "ProductID"],
                                                            "Quantity": q1,
                                                            "Price": item[
                                                            "PriceAfterDiscount"],
                                                            "ProductArName":  item["ProductArName"] +' * '+item['UnitValue'].toString(),
                                                            "ProductEnName": item["ProductEnName"]+' * '+item['UnitValue'].toString(),
                                                            "StockQuantity": item[
                                                            "StockQuantity"],
                                                            "CustomerQuantity":
                                                            item[
                                                            "CustomerQuantity"],
                                                            "BarCode":
                                                            item["BarCode"],
                                                            "Colors_ID": '',
                                                            "Size_ID": '',
                                                            "RequiredQTY":item['RequiredQTY'],
                                                            "GiftQTY":item['GiftQTY'],
                                                            "Y_Gift_Qty":y,
                                                          });
                                                        });

                                                        if (isSecondContainerVisibleList2[
                                                        index]) {
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                  10000),
                                                                  () {
                                                                setState(() {
                                                                  isSecondContainerVisibleList2[
                                                                  index] =
                                                                  false;
                                                                });
                                                              });
                                                        }
                                                      }


                                                    },
                                                    child: !isSecondContainerVisibleList2[
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
                                                FontWeight.w300,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            Text(
                                              (lang.activeLanguage
                                                  .languageCode ==
                                                  'ar')
                                                  ? 'د.ك'
                                                  : 'K.D',
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                fontWeight:
                                                FontWeight.w300,
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
                                                fontSize: 14.sp,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            Text(
                                              (lang.activeLanguage
                                                  .languageCode ==
                                                  'ar')
                                                  ? 'د.ك'
                                                  : 'K.D',
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight:
                                                FontWeight.bold,
                                                fontFamily: 'Monadi',
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
                                                fontSize: 12.sp,
                                                fontWeight:
                                                FontWeight.w300,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                            Text(
                                              'د.ك',
                                              style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight:
                                                FontWeight.w300,
                                                decoration:
                                                TextDecoration
                                                    .lineThrough,
                                                color: Colors.red,
                                                fontFamily: 'Monadi',
                                              ),
                                            ),
                                          ],
                                        ),
                                        2.verticalSpace,
                                        Expanded(
                                          child: Text(
                                            (lang.activeLanguage
                                                .languageCode ==
                                                'ar')
                                                ? '${item["ProductArName"]} * ${item['UnitValue'].toString()}'
                                                : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w300,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 1),
                                        color: Colors.red,
                                        child: Text(
                                          '%${item["DiscountPercent"]}خصم',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ), if (item['GiftQTY']!=0.0)
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
                                  if (item["DiscountPercent"] != 0)
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 2, vertical: 1),
                                        color: Colors.red,
                                        child: Text(
                                          '%${item["DiscountPercent"]}خصم',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ),
                                    ),
                                  if (item["StockQuantity"] == 0.0)
                                    Image.asset(AppAssets.OutOfStock),
                                  // Positioned(
                                  //     top: 0,
                                  //     left: 0,
                                  //     child: IconButton(
                                  //       icon: Icon(
                                  //         Icons.favorite,
                                  //         color: item["IsFavorite"] == 1
                                  //             ? Colors.red
                                  //             : const Color.fromRGBO(
                                  //                 200, 200, 200, 1.0),
                                  //       ),
                                  //       onPressed: () {
                                  //         if (item["IsFavorite"] == 0) {
                                  //           getDataFavoriteFromApi
                                  //               .AddItemFavoritePost(
                                  //                   CustomerPhone:
                                  //                       '${UserPhone}',
                                  //                   ProductID:
                                  //                       item["ProductID"]
                                  //                           .toString());
                                  //         } else {
                                  //           deletFavorite
                                  //               .DeleteItemFavoritePost(
                                  //                   ProductId:
                                  //                       item["ProductID"]
                                  //                           .toString());
                                  //         }
                                  //         setState(() {
                                  //           item["IsFavorite"] =
                                  //               item["IsFavorite"] == 1
                                  //                   ? 0
                                  //                   : 1;
                                  //         });
                                  //       },
                                  //     ))
                                ],
                              ),
                            ),
                          ),
                        );
                    },
                  ),
                );
            }),
            150.verticalSpace,
          ],
        ),
      ),
    );
  }
}
