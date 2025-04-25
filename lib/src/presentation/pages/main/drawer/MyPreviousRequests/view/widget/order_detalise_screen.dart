import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../riverpod/gh.dart';
import '../../../../shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import '../../../../shop/cart/checkout/oneSystem/widget/basct_shop.dart';
import '../../manager/my_previous_requets_riverpod.dart';


class OrderDetalise extends ConsumerStatefulWidget {
  dynamic IteamID;
  OrderDetalise({required this.IteamID});

  @override
  _OrderDetaliseState createState() => _OrderDetaliseState();
}

class _OrderDetaliseState extends ConsumerState<OrderDetalise> {
  @override
  bool isLoading = true;
  void initState() {
    Future.delayed(Duration(milliseconds: 50), () {
      setState(() {
        isLoading = false;
      });
    });
    super.initState();
    ref
        .read(getDataMyPreviousRequetsApiProvider.notifier)
        .getMyPreviousRequetsProduct(ItemID: widget.IteamID);
  }

  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    final listItemOrder = ref.watch(orderProviderList);
    final listItemOrderImage = ref.watch(orderProviderListImage);
    final myPreviousRequetsProduct = ref.watch(
        getDataMyPreviousRequetsApiProvider);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_forward_ios,color: Colors.black),
          ),
          elevation: 0.0,

          title:
          Text(
            (appModel.activeLanguage.languageCode == 'ar')?
            'تفاصيل الطلبيه' :'Order Detalise ',

            style: TextStyle(
              color: Colors.black,
              fontSize: 20.sp,
              fontWeight: FontWeight.w300,
              fontFamily: 'Monadi',
            ),

          ), centerTitle: true,

          actions: [
            TextButton(
              onPressed: (){
                print(myPreviousRequetsProduct.myPreviousRequetsProductList[0]);
                for(int i = 0; i < myPreviousRequetsProduct.myPreviousRequetsProductList.length; i++) {
                  print(myPreviousRequetsProduct.myPreviousRequetsProductList[i]["CustomerQuantity"]);
                  if(myPreviousRequetsProduct.myPreviousRequetsProductList[i]["CustomerQuantity"]>0.0)
                  {


                    listItemOrder.addItem({
                      "ItemID": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["ProductID"],
                      "Quantity": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["Quantity"],
                      "Price":myPreviousRequetsProduct.myPreviousRequetsProductList[i]["PriceAfterDiscount"],
                      "StockQuantity": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["StockQuantity"],
                      "BarCode": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["Barcode"],
                      "Colors_ID": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["Colors_ID"],
                      "Size_ID": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["Size_ID"],
                      "RequiredQTY": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["RequiredQTY"],
                      "GiftQTY": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["GiftQTY"],
                      "Y_Gift_Qty": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["Y_Gift_Qty"],
                    });


                    listItemOrderImage.addItem({
                      "image":  myPreviousRequetsProduct.myPreviousRequetsProductList[i]["ProductcImage"],
                      "ItemID": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["ProductID"],
                      "Quantity": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["Quantity"],
                      "ProductArName": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["ProductArName"] +' * '+myPreviousRequetsProduct.myPreviousRequetsProductList[i]['UnitValue'].toString(),
                      "ProductEnName": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["ProductEnName"] +' * '+myPreviousRequetsProduct.myPreviousRequetsProductList[i]['UnitValue'].toString(),
                      "Price":myPreviousRequetsProduct.myPreviousRequetsProductList[i]["PriceAfterDiscount"],
                      "StockQuantity": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["StockQuantity"],
                      "BarCode": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["Barcode"],
                      "Colors_ID": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["Colors_ID"],
                      "Size_ID": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["Size_ID"],
                      "CustomerQuantity": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["CustomerQuantity"],
                      "RequiredQTY": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["RequiredQTY"],
                      "GiftQTY": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["GiftQTY"],
                      "Y_Gift_Qty": myPreviousRequetsProduct.myPreviousRequetsProductList[i]["Y_Gift_Qty"],
                    });

                  }


                }


                print('      *************************             ');
                print(' listItemOrder            ${listItemOrder.basctList}');
                print('      *************************             ');
                print(' listItemOrder.orderList            ${listItemOrder.orderList}');
                print('      *************************             ');
                print('listItemOrderImage.ListOrderImage         ${listItemOrderImage.ListOrderImage}');
                print('      *************************             ');
                print('listItemOrderImage.orderListImage      ${listItemOrderImage.orderListImage}');
                print('      *************************             ');

               if(listItemOrder.basctList.length>0&&listItemOrder.orderList.length>0&&
                   listItemOrderImage.ListOrderImage.length>0&&listItemOrderImage.orderListImage.length>0)
               {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => BactShop()),
                 );
               }
               else
                 {
                   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                       backgroundColor:
                       Colors.red,
                       content: Text(
                        'لا توجد كميات متاحه من هذه الاصناف',
                       )));
                 }


              },
            child: Text('إعادة الشراء',style: TextStyle(
              color: Colors.indigo,
              fontSize: 15.sp,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monadi',
            ),),
            ),
          ],

        ),
        body: Column(
          children: [
            Container(
              color: Colors.indigo,
              padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 8),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? 'اسم الصنف'
                          : 'Product Name',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Monadi',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        (appModel.activeLanguage.languageCode == 'ar')
                            ? 'الكميه'
                            : 'Quantity',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Monadi',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        (appModel.activeLanguage.languageCode == 'ar')
                            ? 'السعر'
                            : 'price',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Monadi',
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Text(
                        (appModel.activeLanguage.languageCode == 'ar')
                            ? 'الاجمالى '
                            : 'Total',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Monadi',
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            isLoading
                ? const CircularProgressIndicator()
                :
            Consumer(
                builder: (context, ref, child) {
                  final myPreviousRequetsProduct = ref.watch(
                      getDataMyPreviousRequetsApiProvider);

                  return Flexible(
                    child: ListView.builder(
                        shrinkWrap: true,

                        itemCount:myPreviousRequetsProduct.myPreviousRequetsProductList.length,
                        itemBuilder: (context, index)

                        {
                          final item=myPreviousRequetsProduct.myPreviousRequetsProductList[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        (appModel.activeLanguage.languageCode == 'ar')
                                            ? '${item["ProductArName"]}'
                                            : '${item["ProductEnName"]}',
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontSize: 12.sp,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal,
                                          fontFamily: 'Monadi',
                                        ),
                                      ),
                                    ),


                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          '${item['Quantity']}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'Monadi',
                                            letterSpacing: 1.1,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          '${item['Price']
                                              .toStringAsFixed(3)}',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'Monadi',
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text(
                                          '${(item['Price'] *
                                              item['Quantity'])
                                              .toStringAsFixed(3)} ',
                                          style: TextStyle(
                                            fontSize: 12.sp,
                                            fontWeight: FontWeight.w300,
                                            fontFamily: 'Monadi',
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(thickness: 1),
                              ],
                            ),
                          );}
                    ),
                  );
                }  ),
          ],
        )
    );
  }
}