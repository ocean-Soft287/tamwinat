import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/components/list_items/shop_brand_item.dart';
import '../../../search/search_screen.dart';
import '../../drawer/favorite/controler/favorite_riverpod.dart';

import '../../../../../core/constants/app_assets.dart';
import '../../../../../riverpod/gh.dart';
import '../../../../components/components.dart';
import '../../../../theme/app_colors.dart';
import '../../../pages.dart';
import '../../shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import '../../shop/cart/checkout/oneSystem/widget/basct_shop.dart';
import '../../shop/cart/checkout/oneSystem/widget/text_form_field_onsystem.dart';
import '../../shop/details/banner_details/banner_details_page.dart';
import '../on_system/controller/home_riverpod.dart';

class DeliveryCategoryScondory extends ConsumerStatefulWidget {
  final dynamic? categoryId;
  final dynamic? CategoryArName;
  num? scrollOffset ;
  DeliveryCategoryScondory(
      {required this.CategoryArName, required this.categoryId,this.scrollOffset});

  @override
  _DeliveryCategoryScondoryState createState() =>
      _DeliveryCategoryScondoryState();
}

class _DeliveryCategoryScondoryState
    extends ConsumerState<DeliveryCategoryScondory> {
  dynamic? categoryId;
  dynamic? brandId;
  bool isLoading = true;
  bool isLoading2 = true;
  bool isLoading3 = true;
  late List gamal;
  List<Map<String, dynamic>> ahmed = [];
  int selectedIndexCategory = 0;
  int? selectedIndexBrand;
  var customPhoneGuestController = TextEditingController();
  var keyFormCheckOutOnSystem = GlobalKey<FormState>();
  List<bool> isSecondContainerVisibleList =
      List.generate(20000000, (index) => false);
  List<bool> itemLoveStates = List.generate(20000000, (index) => false);
  final ScrollController _scrollController = ScrollController();
 ScrollController _scrollController2 = ScrollController();

  @override
  void initState() {
    super.initState();


    categoryId = widget.categoryId;
    ref
        .read(getDataCategoryByParentIdApiProvider)
        .getCategoryByParentId(categoryId: categoryId);

    ref.read(getProductsFromApi).resetController();

    ref
        .read(getBrandCategoryApiProvider)
        .getBrandCategoryByCategoryId(categoryId: categoryId)
        .then((value) {
      setState(() {
        isLoading2 = false;
        // ref.read(getProductsFromApi).setProducts(productListValue: value);
        print("-" * 50);
        print("Init State ");
        print(ref.read(getBrandCategoryApiProvider).tempProductList);
        print("-" * 50);
        ref.read(getProductsFromApi).setProducts(
            productListValue:
                ref.read(getBrandCategoryApiProvider).tempProductList);
        isLoading3 = false;
        // ref
        //     .read(getProductsFromApi)
        //     .getProducsts(categoryId: categoryId, brandId: brandId ?? "")
        //     .then((value) {
        //   // setState(() {
        //   //   isLoading3 = false;
        //   // });
        // });
      });
    });

    if (categoryId == 2133) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => AlertDialog(
                title: Text(
                  'منتجات ذات قيود عمرية',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: const Color(0xff000000),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Monadi',
                  ),
                ),
                content: Text(
                  "يرجى تأكيد عمرك سيطلب منك إظهار إثبات العمر عند التوصيل",
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Color(0xff000000),
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Monadi',
                  ),
                ),
                actions: [
                  Row(children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(7.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: Colors.orange,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'أنا أكبر من 21',
                              style: TextStyle(
                                color: Colors.orange,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 5),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          padding: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Center(
                              child: Text(
                            'أنا أصغر من 21',
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ),
                      ),
                    )
                  ])
                ]),
          );
        });
      });
    }

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() {
        isLoading = false;
      });
    });

    _scrollController2 = ScrollController();




    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   print('11111111111111111111111111111111111111111111111');
    //   print(widget.scrollOffset);
    //   print('-------------------------------------------------------------');
    //   _scrollController2.jumpTo(double.parse(widget.scrollOffset.toString())??0.0);
    // });
  }
  @override
  void dispose() {
    _scrollController2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    return
        Scaffold(
      backgroundColor: AppColors.white,
      // bottomSheet: Consumer(builder: (context, ref, child) {
      //   final listItemOrder = ref.watch(orderProviderList);
      //
      //   return (listItemOrder.orderList.isEmpty)
      //       ? Text('')
      //       : InkWell(
      //           onTap: () {
      //             Navigator.push(
      //               context,
      //               MaterialPageRoute(builder: (context) => BactShop()),
      //             );
      //           },
      //           child: Container(
      //             color: Colors.green,
      //             child: Column(
      //               mainAxisSize: MainAxisSize.min,
      //               children: [
      //                 Padding(
      //                   padding: const EdgeInsets.all(6.0),
      //                   child: Container(
      //                     decoration: BoxDecoration(
      //                       color: Colors.green,
      //                       borderRadius: BorderRadius.circular(20),
      //                     ),
      //                     child: Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceAround,
      //                       children: [
      //                         Text(
      //                           '${listItemOrder.calculateTotalQuantity().toString()}',
      //                           style: TextStyle(
      //                             fontSize: 20.sp,
      //                             color: Colors.white,
      //                             fontWeight: FontWeight.w500,
      //                             fontFamily: 'Monadi',
      //                           ),
      //                         ),
      //                         Text(
      //                           (appModel.activeLanguage.languageCode == 'ar')
      //                               ? 'شاهد السله'
      //                               : 'View Cart',
      //                           style: TextStyle(
      //                             fontSize: 20.sp,
      //                             color: Colors.white,
      //                             fontWeight: FontWeight.w500,
      //                             fontFamily: 'Monadi',
      //                           ),
      //                         ),
      //                         Text(
      //                           ' ${listItemOrder.calculateTotalPrice().toStringAsFixed(3)}${(appModel.activeLanguage.languageCode == 'ar') ? "   د.ك" : "K.D"}',
      //                           style: TextStyle(
      //                             fontSize: 20.sp,
      //                             color: Colors.white,
      //                             fontWeight: FontWeight.w500,
      //                             fontFamily: 'Monadi',
      //                           ),
      //                         ),
      //                       ],
      //                     ),
      //                   ),
      //                 ),
      //                 10.verticalSpace,
      //               ],
      //             ),
      //           ),
      //         );
      // }),
      appBar: CommonAppBar(
        title: '${widget.CategoryArName}',
        onLeadingPressed: context.popRoute,
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
                    Container(
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
      ),
      body:
    Column(
       children: [
         10.verticalSpace,

         // categoryGroup
         Consumer(
           builder: (context, ref, child) {
             final appModel = ref.watch(appModelProvider);
             final getDataCategoryByParentId =
                 ref.watch(getDataCategoryByParentIdApiProvider);

             // final groupsState = ref.watch(shopGroupsInPickupProvider);
             // final groupsNotifier =
             // ref.read(shopGroupsInPickupProvider.notifier);
             return SizedBox(
               height: 34.r,
               child: isLoading
                   ? const HorizontalListShimmer(
                       horizontalPadding: 16,
                       itemBorderRadius: 100,
                       itemWidth: 100,
                       spacing: 8,
                     )
                   : ListView.builder(
                       shrinkWrap: true,
                       scrollDirection: Axis.horizontal,
                       padding: REdgeInsets.symmetric(horizontal: 16),
                       itemCount: getDataCategoryByParentId
                           .categoryByParentIdList.length,
                       itemBuilder: (context, index) {
                         final item =
                             getDataCategoryByParentId.categoryByParentIdList;
                         return ShopGroupItem(
                           onTap: () {
                             setState(() {
                               selectedIndexCategory = index;
                               selectedIndexBrand = null;
                               isLoading2 = true;
                               // reset brand , product
                               isLoading3 = true;

                               ref.read(getProductsFromApi).resetController();
                               ref
                                   .read(getBrandCategoryApiProvider)
                                   .resetController();
                               print(item[index]['CategoryId']);
                               categoryId = item[index]['CategoryId'];
                               // reset brand , product

                               // brandId = item[index][
                               //     'CategoryId']; // Added with mohamed salah elkholy
                             });

                             ref
                                 .read(getBrandCategoryApiProvider)
                                 .getBrandCategoryByCategoryId(
                                   categoryId: categoryId,
                                 )
                                 .then((value) {
                               setState(() {
                                 isLoading2 = false;

                                 _scrollController2.animateTo(
                                   0.0,
                                   duration: const Duration(milliseconds: 500),
                                   curve: Curves.easeInOut,
                                 );
                               });
                               List<Map<String, dynamic>> brandCategoryList =
                                   ref
                                       .read(getBrandCategoryApiProvider)
                                       .brandCategoryList;
     /*

       ref.read(getProductsFromApi).setProducts(
           productListValue:
               ref.read(getBrandCategoryApiProvider).brandCategoryList);
     */
                               print("//" * 50);
                               print(ref
                                   .read(getBrandCategoryApiProvider)
                                   .tempProductList);
                               print("//" * 50);
                               ref.read(getProductsFromApi).setProducts(
                                   productListValue: ref
                                       .read(getBrandCategoryApiProvider)
                                       .tempProductList);
                               // ref
                               //     .read(getProductsFromApi)
                               //     .getProducsts(
                               //         categoryId: categoryId,
                               //         brandId: brandCategoryList.isNotEmpty
                               //             ? brandCategoryList[0]['BrandID'] ??
                               //                 ""
                               //             : "")
                               //     .then((value) {})
                               //     .whenComplete(() => setState(() {
                               //           isLoading3 = false;
                               //         }));
                             });
                             // Future.delayed(Duration(milliseconds: 2000), () {
                             //   setState(() {
                             //     isLoading2 = false;
                             //   });
                             // });

                             setState(() {
                               isLoading3 = false;
                             });
                           },
                           isSelected:
                               (selectedIndexCategory == index) ? true : false,
                           title:
                               (appModel.activeLanguage.languageCode == 'ar')
                                   ? '${item[index]['CategoryArName']}'
                                   : '${item[index]['CategoryEnName']}',
                         );
                       },
                     ),
             );
           },
         ),
    Expanded(
      child:

         SingleChildScrollView(
           controller: _scrollController2,
             child: Column(
                 children:[
                   Consumer(
                     builder: (context, ref, child) {
                       final appModel = ref.watch(appModelProvider);
                       final getBrandDataCategoryApiProvider =
                       ref.watch(getBrandCategoryApiProvider);
                       bool isSelectedAll = ref
                           .read(getDataCategoryByParentIdApiProvider)
                           .isSelectedAll(index: selectedIndexCategory);
                       // final groupsState = ref.watch(shopGroupsInPickupProvider);
                       // final groupsNotifier =
                       // ref.read(shopGroupsInPickupProvider.notifier);
                       return isSelectedAll
                           ? const SizedBox()
                           : Column(
                         children: [

                           getBrandDataCategoryApiProvider
                               .brandCategoryList.isEmpty
                           ?
                           const SizedBox():
                           Column(
                             children: [
                               5.verticalSpace,
                               const Divider(height: 1,color: Colors.grey),
                               5.verticalSpace,
                               SizedBox(
                                 height: 80.h,
                                 child: isLoading2
                                     ? const HorizontalListShimmer(
                                   horizontalPadding: 16,
                                   itemBorderRadius: 100,
                                   itemWidth: 100,
                                   spacing: 8,
                                 )

                                     : Align(
                                   alignment: AlignmentDirectional.topStart,
                                   child: ListView.separated(
                                     shrinkWrap: true,
                                     scrollDirection: Axis.horizontal,
                                     padding: REdgeInsets.symmetric(
                                         horizontal: 16),
                                     itemCount:
                                     getBrandDataCategoryApiProvider
                                         .brandCategoryList.length,
                                     separatorBuilder: (context, index) {
                                       return 10.horizontalSpace;
                                     },
                                     itemBuilder: (context, index) {
                                       final item =
                                           getBrandDataCategoryApiProvider
                                               .brandCategoryList;
                                       return ShopBrandItem(
                                           onTap: () {
                                             setState(() {
                                               selectedIndexBrand = index;
                                               isLoading3 = true;
                                               print(
                                                   item[index]['FabricID']);
                                               // isLoading3 = true;
                                               brandId =
                                               item[index]['FabricID'];

                                               ref
                                                   .read(getProductsFromApi)
                                                   .resetController();
                                             });

                                             ref
                                                 .read(getProductsFromApi)
                                                 .getProducsts(
                                                 categoryId: categoryId,
                                                 brandId: brandId)
                                                 .then((value) {
                                               setState(() {
                                                 isLoading3 = false;
                                               });
                                             });

                                             // Future.delayed(Duration(milliseconds: 2000),
                                             //     () {
                                             //   // setState(() {
                                             //   //   isLoading3 = false;
                                             //   // });
                                             //   // _scrollController.animateTo(
                                             //   //   0.0,
                                             //   //   duration: Duration(milliseconds: 500),
                                             //   //   curve: Curves.easeInOut,
                                             //   // );
                                             // });
                                             _scrollController2.animateTo(
                                               0.0,
                                               duration: Duration(milliseconds: 500),
                                               curve: Curves.easeInOut,
                                             );
                                           },
                                           isSelected:
                                           (selectedIndexBrand == index)
                                               ? true
                                               : false,
                                           title: (appModel.activeLanguage
                                               .languageCode ==
                                               'ar')
                                               ? '${item[index]['FabricName']}'
                                               : '${item[index]['FabricEName']}',
                                           imageUrl:
                                           '${item[index]['FabricImage']}');
                                     },
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ],
                       );
                     },
                   ),

                   5.verticalSpace,
                   const Divider(height: 1,color: Colors.grey),
                   5.verticalSpace,
                   ((categoryId == null)) //(categoryId == null)
                       ?
                   Container(
                     color: AppColors.white,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         12.verticalSpace,
                         Consumer(
                           builder: (context, ref, child) {
                             final getDataFavoriteFromApi =
                             ref.watch(addItemFavoriteProvider);
                             final deletFavorite =
                             ref.watch(deleteItemFavoriteProvider);
                             final getProductsDataFromApi =
                             ref.watch(getProductsFromApi);
                             final getDataBrandCategoryApiProvider =
                             ref.watch(getBrandCategoryApiProvider);
                             final appModel = ref.watch(appModelProvider);

                             final listItemOrder = ref.watch(orderProviderList);
                             final listItemOrderImage =
                             ref.watch(orderProviderListImage);
                             int _getCrossAxisCount(BuildContext context) {
                               final screenWidth =
                                   MediaQuery.of(context).size.width;

                               if (screenWidth >= 1200) {
                                 return 4;
                               } else if (screenWidth >= 800) {
                                 return 3;
                               } else {
                                 return 2;
                               }
                             }

                             double _getAspectRatio(BuildContext context) {
                               final crossAxisCount =
                               _getCrossAxisCount(context);

                               if (crossAxisCount == 4) {
                                 return 0.75; // Wider aspect ratio for large screens
                               } else {
                                 return 0.8; // Regular aspect ratio for medium and small screens
                               }
                             }

                             return  Padding(
                               padding: REdgeInsets.only(
                                   bottom: 50.0, right: 4, left: 4),
                               child: isLoading3
                                   ? const GridListShimmer(
                                 itemCount: 10,
                                 isScrollable: true,
                                 onlyBottomPadding: 10,
                                 verticalPadding: 10,
                               )
                                   : getProductsDataFromApi.productsList.isEmpty
                                   ? Center(
                                   child: Text(
                                     (appModel.activeLanguage
                                         .languageCode ==
                                         'ar')
                                         ? "لايوجد منتجات في هذا القسم"
                                         : "There are no products in this section",
                                     style: GoogleFonts.tajawal(
                                       fontSize:
                                       15.sp,
                                       fontWeight:
                                       FontWeight.bold,
                                     ),))

                                   : GridView.builder(
                                 shrinkWrap: true,
                                 physics: const NeverScrollableScrollPhysics(),
                                 controller: _scrollController,
                                 itemCount: getProductsDataFromApi
                                     .productsList.length,
                                 gridDelegate:
                                 SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount:
                                   _getCrossAxisCount(context),
                                   childAspectRatio:
                                   _getAspectRatio(context),
                                   crossAxisSpacing: 2,
                                   mainAxisSpacing: 5,
                                 ),
                                 itemBuilder: (context, index) {
                                   if (widget.scrollOffset != null && widget.scrollOffset != 0.0) {
                                     _scrollController2.animateTo(
                                       double.tryParse(widget.scrollOffset.toString()) ?? 0.0,
                                       duration: const Duration(milliseconds: 300), // مدة الحركة
                                       curve: Curves.easeInOut, // نوع الحركة
                                     );


                                   }
                                   final item = getProductsDataFromApi
                                       .productsList[index];
                                   num q1 = listItemOrder.getQuantity(
                                       itemID: item['BarCode']);
                                   num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]);
                                   // int quantity =
                                   // listItemOrder.getQuantityByItemID(
                                   //     getDataCategoryItemFromApi.categoryAllList[index]['ItemID']);
                                   return


                                     Card(
                                       color: Colors.white,
                                       child: Container(
                                         color: Colors.white,
                                         child: InkWell(
                                           onTap: () {
                                             widget.scrollOffset = _scrollController2.offset;
                                             print(widget.scrollOffset);

                                             print(widget.scrollOffset);

                                             Navigator.pushReplacement(context,   MaterialPageRoute(
                                                 builder: (context) =>
                                                     BannerDetailsPage(
                                                       scrollPosition: widget.scrollOffset,
                                                       productId: item[
                                                       "ProductID"],
                                                       CategoryId:
                                                       categoryId,
                                                       isRoute: true,
                                                       categoryName:widget.CategoryArName,
                                                       name: (appModel
                                                           .activeLanguage
                                                           .languageCode ==
                                                           'ar')
                                                           ? item[
                                                       'ProductArName']
                                                           : item[
                                                       'ProductEnName'],
                                                       image: item[
                                                       'ProductcImage'],
                                                       specification: item[
                                                       'Specification'],
                                                     )),
                                             );
                                           },
                                           child: Stack(
                                             children: [
                                               Padding(
                                                 padding: REdgeInsets
                                                     .symmetric(
                                                     horizontal:
                                                     8.0),
                                                 child: Column(
                                                   crossAxisAlignment:
                                                   CrossAxisAlignment
                                                       .start,
                                                   children: [
                                                     Center(
                                                       child: Stack(
                                                           alignment:
                                                           Alignment
                                                               .bottomRight,
                                                           children: [
                                                             Container(
                                                               width: MediaQuery.of(
                                                                   context)
                                                                   .size
                                                                   .width,
                                                               height:
                                                               130,
                                                               child: Image
                                                                   .network(
                                                                 '${item['ProductcImage']}',
                                                               ),
                                                             ),
                                                             if (categoryId !=
                                                                 2151)

                                                               GestureDetector(
                                                                 onTap:
                                                                     () {
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

                                                                                 print('UserPhone All  ${UserPhoneAll}');

                                                                                 print('UserPhone   ${UserPhone}');

                                                                                 // Navigator.push(context, MaterialPageRoute(builder: (context) {
                                                                                 //   return MainPage();
                                                                                 // }));
                                                                                 Navigator.pushReplacement(
                                                                                   context,
                                                                                   MaterialPageRoute(
                                                                                     builder: (context) => MainPage(

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

                                                                   }else{
                                                                     setState(
                                                                             () {
                                                                           isSecondContainerVisibleList[index] =
                                                                           !isSecondContainerVisibleList[index];
                                                                           // isSecondContainerVisible =
                                                                           // !isSecondContainerVisible;
                                                                         });

                                                                     setState(
                                                                             () {



                                                                           if (q1 ==
                                                                               0) {
                                                                             q1++;
                                                                             print(q1);
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
                                                                     if (isSecondContainerVisibleList[
                                                                     index]) {
                                                                       Future.delayed(Duration(milliseconds: 10000),
                                                                               () {
                                                                             setState(() {
                                                                               isSecondContainerVisibleList[index] = false;
                                                                             });
                                                                           });
                                                                     }

                                                                   }





                                                                 },
                                                                 child: !isSecondContainerVisibleList[index]
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
                                                     (item["DiscountPercent"] ==
                                                         0)
                                                         ? Row(
                                                       children: [
                                                         Text(
                                                           ' ${item["PriceAfterDiscount"].toStringAsFixed(3)} ',
                                                           style: TextStyle(
                                                             fontSize: 14.sp,
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
                                                             fontSize: 14.sp,
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
                                                             fontSize: 14.sp,
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
                                                             fontSize: 14.sp,
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
                                                       flex: 2,
                                                       child: Text(
                                                         (appModel.activeLanguage
                                                             .languageCode ==
                                                             'ar')
                                                             ? '${item["ProductArName"]} * ${item['UnitValue'].toString()}'
                                                             : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                                         maxLines: 2,
                                                         style: GoogleFonts.tajawal(
                                                           fontSize:
                                                           12.sp,
                                                           fontWeight:
                                                           FontWeight
                                                               .w700,
                                                         ),
                                                       ),
                                                     ),
                                                   ],
                                                 ),
                                               ),
                                               if (item[
                                               "DiscountPercent"] !=
                                                   0)
                                                 Positioned(
                                                   top: 0,
                                                   right: 0,
                                                   child: Container(

                                                     color: Colors.red,
                                                     child: Text(
                                                       '%${item["DiscountPercent"]}خصم',
                                                       style: const TextStyle(
                                                         color: Colors
                                                             .white,
                                                         fontWeight:
                                                         FontWeight
                                                             .bold,
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
                                               if (item[
                                               "StockQuantity"] ==
                                                   0.0)
                                                 Image.asset(AppAssets
                                                     .OutOfStock),
                                               Positioned(
                                                   top: 20,
                                                   left: 0,
                                                   child: IconButton(
                                                     icon: Icon(
                                                       Icons.favorite,
                                                       color: item["IsFavorite"] ==
                                                           1
                                                           ? Colors.red
                                                           : const Color
                                                           .fromRGBO(
                                                           200,
                                                           200,
                                                           200,
                                                           1.0),
                                                     ),
                                                     onPressed: () {
                                                       if (item[
                                                       "IsFavorite"] ==
                                                           0) {
                                                         getDataFavoriteFromApi.AddItemFavoritePost(
                                                             CustomerPhone:
                                                             '${UserPhone}',
                                                             ProductID: item[
                                                             "ProductID"]
                                                                 .toString());
                                                       } else {
                                                         deletFavorite.DeleteItemFavoritePost(
                                                             ProductId: item[
                                                             "ProductID"]
                                                                 .toString());
                                                       }
                                                       setState(() {
                                                         item["IsFavorite"] =
                                                         item["IsFavorite"] ==
                                                             1
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
                             );
                           },
                         ),
                       ],
                     ),
                   )
                       :
                   Container(
                     color: AppColors.white,
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         12.verticalSpace,
                         Consumer(
                           builder: (context, ref, child) {
                             final getDataFavoriteFromApi =
                             ref.watch(addItemFavoriteProvider);
                             final deletFavorite =
                             ref.watch(deleteItemFavoriteProvider);
                             ref.watch(appModelProvider);
                             final appModel = ref.watch(appModelProvider);

                             final getProductsDataFromApi =
                             ref.watch(getProductsFromApi);
                             // getProductsDataFromApi.getProducsts(
                             //     categoryId: categoryId,
                             //     brandId: brandId); // add brandId with me
                             final listItemOrder = ref.watch(orderProviderList);
                             final listItemOrderImage =
                             ref.watch(orderProviderListImage);
                             int getCrossAxisCount(BuildContext context) {
                               double screenWidth = MediaQuery.of(context).size.width;

                               if (screenWidth >= 1200) return 5;
                               if (screenWidth >= 800) return 4;
                               if (screenWidth >= 600) return 3;
                               return 2; // للهواتف
                             }

                             double getAspectRatio(BuildContext context, int crossAxisCount) {
                               double screenWidth = MediaQuery.of(context).size.width;
                               double itemWidth = screenWidth / crossAxisCount;
                               double itemHeight = itemWidth * 1.1;

                               return itemWidth / itemHeight;
                             }

                             return  Padding(
                               padding: REdgeInsets.only(
                                   bottom: 50.0, right: 4, left: 4),
                               child: isLoading3 // isLoading2 || isLoading3
                                   ? const GridListShimmer(
                                 itemCount: 10,
                                 isScrollable: true,
                                 onlyBottomPadding: 10,
                                 verticalPadding: 10,
                               )
                                   : getProductsDataFromApi.productsList.isEmpty
                                   ? Center(
                                   child: Text(
                                     (appModel.activeLanguage
                                         .languageCode ==
                                         'ar')
                                         ? "لايوجد منتجات في هذا القسم"
                                         : "There are no products in this section",

                                     style: GoogleFonts.tajawal(
                                       fontSize:
                                       15.sp,
                                       fontWeight:
                                       FontWeight.bold,
                                     ),

                                   ))

                                   : GridView.builder(
                                 shrinkWrap: true,
                                 physics: const NeverScrollableScrollPhysics(),
                                 controller: _scrollController,
                                 itemCount: getProductsDataFromApi
                                     .productsList.length,
                                 gridDelegate:
                                 SliverGridDelegateWithFixedCrossAxisCount(
                                   crossAxisCount:
                                   getCrossAxisCount(context),
                                   childAspectRatio:
                                   getAspectRatio(context, getCrossAxisCount(context)),
                                   crossAxisSpacing: 2,
                                   mainAxisSpacing: 5,
                                 ),
                                 itemBuilder: (context, index) {
                                   if (widget.scrollOffset != null && widget.scrollOffset != 0.0) {
                                     _scrollController2.animateTo(
                                       double.tryParse(widget.scrollOffset.toString()) ?? 0.0,
                                       duration: const Duration(milliseconds: 300),
                                       curve: Curves.easeInOut,
                                     );

                                   }


                                   final item = getProductsDataFromApi
                                       .productsList[index];
                                   num q1 = listItemOrder.getQuantity(
                                       itemID: item["BarCode"]);
                                   num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]);
                                   // int quantity =
                                   // listItemOrder.getQuantityByItemID(
                                   //     getDataCategoryItemFromApi.categoryAllList[index]['ItemID']);
                                   return Card(
                                     color: Colors.white,
                                     child: Container(
                                       color: Colors.white,
                                       height:200.h,
                                       child: InkWell(
                                         onTap: () {
                                           widget.scrollOffset = _scrollController2.offset;
                                           print(num.parse(widget.scrollOffset.toString()));
                                           print('666666666666666666666666666666666666666');
                                           print(widget.scrollOffset);
                                           print('gggggggggggggggggggggggggg');
                                           Navigator.pushReplacement(context,   MaterialPageRoute(
                                               builder: (context) =>
                                                   BannerDetailsPage(
                                                     scrollPosition: num.parse(widget.scrollOffset.toString()),
                                                     productId: item[
                                                     "ProductID"],
                                                     CategoryId:
                                                     categoryId,
                                                     isRoute: true,
                                                     categoryName:widget.CategoryArName,
                                                     name: (appModel
                                                         .activeLanguage
                                                         .languageCode ==
                                                         'ar')
                                                         ? item[
                                                     'ProductArName']
                                                         : item[
                                                     'ProductEnName'],
                                                     image: item[
                                                     'ProductcImage'],
                                                     specification: item[
                                                     'Specification'],
                                                   )),
                                           );



                                         },
                                         child: Stack(
                                           children: [
                                             Padding(
                                               padding: REdgeInsets
                                                   .symmetric(
                                                   horizontal:
                                                   8.0),
                                               child: Column(
                                                 crossAxisAlignment:
                                                 CrossAxisAlignment
                                                     .start,
                                                 children: [
                                                   Center(
                                                     child: Stack(
                                                         alignment:
                                                         Alignment
                                                             .bottomRight,
                                                         children: [
                                                           SizedBox(
                                                             width: MediaQuery.of(
                                                                 context)
                                                                 .size
                                                                 .width,
                                                             height:
                                                             130,
                                                             child: Image
                                                                 .network(
                                                               '${item['ProductcImage']}',
                                                             ),
                                                           ),
                                                           if (categoryId != 2151)
                                                             GestureDetector(
                                                               onTap:
                                                                   () {
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

                                                                 }else{
                                                                   setState(
                                                                           () {
                                                                         isSecondContainerVisibleList[index] =
                                                                         !isSecondContainerVisibleList[index];
                                                                         // isSecondContainerVisible =
                                                                         // !isSecondContainerVisible;
                                                                       });

                                                                   setState(
                                                                           () {



                                                                         if (q1 ==
                                                                             0) {
                                                                           q1++;
                                                                           print(q1);
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
                                                                   if (isSecondContainerVisibleList[
                                                                   index]) {
                                                                     Future.delayed(const Duration(milliseconds: 10000),
                                                                             () {
                                                                           setState(() {
                                                                             isSecondContainerVisibleList[index] = false;
                                                                           });
                                                                         });
                                                                   }

                                                                 }





                                                               },
                                                               child: !isSecondContainerVisibleList[index]
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

                                                   (item["DiscountPercent"] ==
                                                       0)
                                                       ? Row(
                                                     children: [
                                                       Text(
                                                         ' ${item["PriceAfterDiscount"].toStringAsFixed(3)} ',
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
                                                     ],
                                                   )
                                                       : Row(
                                                     children: [
                                                       Text(
                                                         '${(item["PriceAfterDiscount"]??0).toStringAsFixed(3)}',
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
                                                         ' ${item["Price"]??0.toStringAsFixed(3)}',
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
                                                   Expanded(
                                                     flex: 2,
                                                     child: Text(
                                                       (appModel.activeLanguage
                                                           .languageCode ==
                                                           'ar')
                                                           ? '${item["ProductArName"]} * ${item['UnitValue'].toString()}'
                                                           : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                                       maxLines: 2,

                                                       style: TextStyle(
                                                         fontSize: 13.sp,
                                                         fontWeight: FontWeight.w500,
                                                         fontFamily: 'Monadi',


                                                       ),

                                                     ),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                             if (item[
                                             "DiscountPercent"] !=
                                                 0)
                                               Positioned(
                                                 top: 0,
                                                 right: 0,
                                                 child: Container(
                                                   padding:
                                                   const EdgeInsets
                                                       .symmetric(
                                                       horizontal:
                                                       0,
                                                       vertical:
                                                       0),
                                                   color: Colors.red,
                                                   child: Text(
                                                     '%${item["DiscountPercent"]}خصم',
                                                     style: GoogleFonts.tajawal(
                                                       color: Colors.white,
                                                       fontWeight: FontWeight.bold,
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
                                             if (item[
                                             "StockQuantity"] ==
                                                 0.0)
                                               Image.asset(AppAssets
                                                   .OutOfStock),
                                             Positioned(
                                                 top: 20,
                                                 left: 0,
                                                 child: IconButton(
                                                   icon: Icon(
                                                     Icons.favorite,
                                                     color: item["IsFavorite"] ==
                                                         1
                                                         ? Colors.red
                                                         : const Color
                                                         .fromRGBO(
                                                         200,
                                                         200,
                                                         200,
                                                         1.0),
                                                   ),
                                                   onPressed: () {
                                                     if (item[
                                                     "IsFavorite"] ==
                                                         0) {
                                                       getDataFavoriteFromApi.AddItemFavoritePost(
                                                           CustomerPhone:
                                                           '$UserPhone',
                                                           ProductID: item[
                                                           "ProductID"]
                                                               .toString());
                                                     } else {
                                                       deletFavorite.DeleteItemFavoritePost(
                                                           ProductId: item[
                                                           "ProductID"]
                                                               .toString());
                                                     }
                                                     setState(() {
                                                       item["IsFavorite"] =
                                                       item["IsFavorite"] ==
                                                           1
                                                           ? 0
                                                           : 1;
                                                     });
                                                   },
                                                 )



                                             )
                                           ],
                                         ),
                                       ),
                                     ),
                                   );
                                 },
                               ),
                             );
                           },
                         ),
                       ],
                     ),
                   )
                 ]
             ),
           ),)



       ],
     )
    );
  }
}
