import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../core/constants/app_assets.dart';
import '../../../../../../riverpod/gh.dart';
import '../../../../../components/components.dart';
import '../../../../../theme/app_colors.dart';

import '../../../../pages.dart';

import '../../../shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import '../../../shop/cart/checkout/oneSystem/widget/basct_shop.dart';

import '../controler/favorite_riverpod.dart';

class Favorite extends ConsumerStatefulWidget {
  const Favorite({Key? key}) : super(key: key);

  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends ConsumerState<Favorite> {

  bool isLoading = true;
  List<bool> isSecondContainerVisibleList1 =
  List.generate(100, (index) => false);
  List<bool>itemLoveStates=List.generate(100, (index) => false);
  @override
  void initState() {
    print('ssssssss');
    super.initState();
    ref
        .read(getDataFavoriteApiProvider)
        .getFavorite();

    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  @override

  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(

                ),
              ),
            );
          },
          icon: const Icon(Icons.arrow_forward_ios,color: Colors.black),
        ),
        elevation: 0.0,
actions: [
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
        title:
        Text(
          (appModel.activeLanguage.languageCode == 'ar')?
          'منتجاتى المفضله':'My Wish List',

          style: const TextStyle(
              color: Colors.black
          ),

        ),

        centerTitle: true,



      ),
      body:

      Container(
        color: AppColors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            32.verticalSpace,



            Consumer(

              builder: (context, ref, child) {


                final getDataFavoriteFromApi =
                ref.watch(getDataFavoriteApiProvider);

                final deleteItemInFavorite= ref.watch(deleteItemFavoriteProvider);
                final listItemOrder =
                ref.watch(orderProviderList);
                final listItemOrderImage =
                ref.watch(orderProviderListImage);
                int _getCrossAxisCount(BuildContext context) {
                  final screenWidth = MediaQuery.of(context).size.width;

                  // Adjust the values as per your needs
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
                    return 0.75; // Wider aspect ratio for large screens
                  } else {
                    return 0.8; // Regular aspect ratio for medium and small screens
                  }
                }


                return isLoading
                    ? const Expanded(
                  child: GridListShimmer(
                    itemCount: 10,
                    isScrollable: true,
                    onlyBottomPadding: 10,
                    verticalPadding: 10,
                  ),
                )
                    :  (getDataFavoriteFromApi.favoriteList.length==0)?

                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar') ?
                    'لا توجد منتجات فى قائمه المفضله' : 'There are no products in the favorites list',

                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14.sp,
                      fontFamily: 'Monadi',
                      color: AppColors.black,
                    ),

                  ),
                )

                    :Expanded(
                    child: Padding(
                      padding: REdgeInsets.only(left: 4,right: 4,bottom: 60),
                      child:
                      GridView.builder(
                        itemCount: getDataFavoriteFromApi.favoriteList.length,
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: _getCrossAxisCount(context),
                          childAspectRatio: _getAspectRatio(context),
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 5,
                        ),
                        itemBuilder: (context, index) {
                          final item = getDataFavoriteFromApi.favoriteList[index];
                          num q1 = listItemOrder.getQuantity(itemID: item['BarCode']);
                          num y = listItemOrder.getYGiftQty(itemID: item["BarCode"]);
                          return
                            Card(

                              color: Colors.white,
                              child: Container(
                                color: Colors.white,
                                child: InkWell(
                                  onTap: () {
                                    print(item);
                                    //2105
                                    //  deleteItemInFavorite.DeleteItemFavoritePost(ProductId: item["Pro"]);

                                    //  Navigator.push(
                                    //    context,
                                    // //   getDataFromApi.dataCategoryAllList[index]["productId"]
                                    //    MaterialPageRoute(
                                    //        builder: (context) => BannerDetailsPage(
                                    //          productId: item["ProductID"],
                                    //         // CategoryId:widget.categoryId ,
                                    //        )),
                                    // );
                                  },
                                  child:
                                  Stack(

                                    children: [
                                      Padding(
                                        padding: REdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,

                                          children: [
                                            Center(
                                              child:
                                              Stack(
                                                  alignment: Alignment.bottomRight,
                                                  children: [
                                                    SizedBox(
                                                      width: MediaQuery.of(context)
                                                          .size
                                                          .width,
                                                      height: 130,
                                                      child: Image.network(
                                                        '${item['ProductImage']}',
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {


                                                        setState(() {
                                                          isSecondContainerVisibleList1[
                                                          index] =
                                                          !isSecondContainerVisibleList1[
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

                                                        if (isSecondContainerVisibleList1[
                                                        index]) {
                                                          Future.delayed(
                                                              const Duration(
                                                                  milliseconds:
                                                                  10000), () {
                                                            setState(() {
                                                              isSecondContainerVisibleList1[
                                                              index] = false;
                                                            });
                                                          });
                                                        }





                                                      },
                                                      child:
                                                      !isSecondContainerVisibleList1[
                                                      index]
                                                          ? Card(
                                                        child:
                                                        Container(
                                                          height: 40.h,
                                                          width: 35.w,
                                                          color: (q1 >=
                                                              1)
                                                              ? Colors
                                                              .green
                                                              : Colors
                                                              .white,
                                                          child: Center(
                                                            child: Text(
                                                                (q1 >= 1)
                                                                    ? '${q1}'
                                                                    : '+',
                                                                style:
                                                                TextStyle(
                                                                  fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                                  fontFamily: 'Monadi',
                                                                  fontSize:
                                                                  20.sp,
                                                                  color: (q1 >= 1)
                                                                      ? Colors.white
                                                                      : Colors.orange,
                                                                )),
                                                          ),
                                                        ),
                                                      )
                                                          :Container(
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

                                            (item["DiscountPercent"]==0)?
                                            Row(

                                              children: [



                                                Text(
                                                  ' ${item["PriceAfterDiscount"].toStringAsFixed(3)} ',
                                                  style: TextStyle(

                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'Monadi',
                                                  ),
                                                ),

                                                Text(
                                                  (appModel.activeLanguage.languageCode == 'ar')?
                                                  'د.ك':'K.D',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w300,

                                                    fontFamily: 'Monadi',
                                                  ),
                                                ),

                                              ],

                                            ):

                                            Row(

                                              children: [



                                                Text(
                                                  '${item["PriceAfterDiscount"].toStringAsFixed(3)}',
                                                  style: TextStyle(

                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'Monadi',
                                                  ),
                                                ),

                                                Text(
                                                  (appModel.activeLanguage.languageCode == 'ar')?
                                                  'د.ك':'K.D',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w300,

                                                    fontFamily: 'Monadi',
                                                  ),
                                                ),
                                                10.horizontalSpace,
                                                Text(
                                                  ' ${item["Price"].toStringAsFixed(3)}',
                                                  style: TextStyle(
                                                    decoration: TextDecoration.lineThrough,
                                                    color: Colors.red,
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w300,
                                                    decorationThickness: 12.0,
                                                    fontFamily: 'Monadi',
                                                  ),
                                                ),

                                                Text(
                                                  'د.ك',
                                                  style: TextStyle(
                                                    fontSize: 16.sp,
                                                    fontWeight: FontWeight.w300,
                                                    decoration: TextDecoration.lineThrough,
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

                                                (appModel.activeLanguage.languageCode == 'ar')
                                                  ? '${item["ProductName"]} * ${item['UnitValue'].toString()}'
                                                : '${item["ProductEnName"]} * ${item['UnitValue'].toString()}',
                                                maxLines: 2,
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
                                      if(item["DiscountPercent"]!=0)
                                        Positioned(
                                          top: 0,
                                          right: 0,
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4, vertical: 2),
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
                                      if(item["StockQuantity"]<=0.0)
                                        Image.asset(AppAssets.OutOfStock),
                                      Positioned(
                                        top: 0,

                                        left:0,


                                        child:
                                        IconButton(
                                          icon: Icon(Icons.favorite, color: Colors.red), // Love Active

                                          onPressed: () {
                                            print(item["ProductID"]);


                                            deleteItemInFavorite.DeleteItemFavoritePost(ProductId: item["ProductID"]);
                                            getDataFavoriteFromApi.getFavorite();

                                            // setState(() {
                                            //
                                            // });



                                          },
                                        ),

                                      )


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


          ],
        ),
      ),


    );
  }
}