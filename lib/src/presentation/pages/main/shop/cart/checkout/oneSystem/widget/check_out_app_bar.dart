  import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/model/address_model.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/add_address.dart';
import 'package:sundaymart/src/presentation/theme/theme.dart';
import 'package:sundaymart/src/riverpod/gh.dart';

PreferredSizeWidget checkout_system_app_bar({



  
  required BuildContext context,
  required WidgetRef ref,
  dynamic BillValue,
  int selectAddress = -1,
  dynamic deleveryValue,
  int paymentMethod = 0,
  dynamic valueselectedDistrict,
  required AppModel lang,
  AddressModel ? address,
  required GetDataAddressFromApi listAddressUser,
}){
        return AppBar(
      
  backgroundColor: AppColors.mainBackground(),
        centerTitle: true,
        title: 
        // (UserPhone != null)
        //     ?
             InkWell(
                onTap:address != null?null: () {
                  ref.watch(getAddressFromApiProvider);
                  ref.watch(getAddressFromApiProvider).dataAddressList;
              address !=null?   ref.watch(getAddressFromApiProvider).passAddressToGuest(address: address):    ref.watch(getAddressFromApiProvider).getAddresss();
                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return StatefulBuilder(
                        builder:
                            (BuildContext context, StateSetter setState) {
                          return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  InkWell(
                                    onTap: () {
                                   Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AddNewAddress()));
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            (lang.activeLanguage
                                                        .languageCode ==
                                                    'ar')
                                                ? 'اضافه عنوان جديد'
                                                : 'Enter Please Address',
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16.sp,
                                              fontFamily: 'Monadi',
                                              color: AppColors.black,
                                            )),
                                        Container(
                                          width: 30,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            border: Border.all(
                                              color: Colors.orange,
                                              width: 2.0,
                                            ),
                                          ),
                                          child: const Icon(Icons.add,
                                              color: Colors.orange),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(
                                      (lang.activeLanguage.languageCode ==
                                              'ar')
                                          ? 'العناوين المحفوظه'
                                          : 'Save titles',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16.sp,
                                        fontFamily: 'Monadi',
                                        color: AppColors.black,
                                      )),
                                  const SizedBox(height: 16),
                                  Flexible(
                                    child: Consumer(
                                        builder: (context, ref, child) {
                                      ref.watch(getAddressFromApiProvider);

                                      return ListView.builder(
                                          itemCount: listAddressUser
                                              .dataAddressList.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemBuilder: (context, index) {
                                            final item = listAddressUser
                                                .dataAddressList[index];
                                            return Column(
                                              children: [
                                                Container(
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              const Icon(
                                                                Icons
                                                                    .location_on,
                                                                color: Colors
                                                                    .orange,
                                                              ),
                                                              InkWell(
                                                                onTap: () {
                                                                  print(
                                                                      'Gamal');
                                                                  print(item);
                                                                },
                                                                child: Text(
                                                                    (lang.activeLanguage.languageCode ==
                                                                            'ar')
                                                                        ? '${item["DistrictName2"]}'
                                                                        : '${item["DistrictEName2"]}',
                                                                    style:
                                                                        TextStyle(
                                                                      fontWeight:
                                                                          FontWeight.w500,
                                                                      fontSize:
                                                                          16.sp,
                                                                      fontFamily:
                                                                          'Monadi',
                                                                      color: AppColors
                                                                          .black,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                          Radio(
                                                            value: index,
                                                            groupValue:
                                                                selectAddress,
                                                            onChanged:
                                                                (value) {
                                                              print(
                                                                  'index $index');
                                                              print(
                                                                  selectAddress);

                                                              setState(() {
                                                                selectAddress =
                                                                    value!;
                                                              });
                                                              setState(() {
                                                                print(listAddressUser
                                                                        .dataAddressList[
                                                                    selectAddress]);
                                                                // print(
                                                                //     selectAddress);
                                                                print(listAddressUser
                                                                            .dataAddressList[
                                                                        selectAddress]
                                                                    [
                                                                    "DeliveryValue"]);
                                                                deleveryValue = (UserPhone !=
                                                                        null)
                                                                    ? listAddressUser
                                                                            .dataAddressList[selectAddress]
                                                                        [
                                                                        "DeliveryValue"]
                                                                    : deleveryValue;
                                                                print(
                                                                    'deleveryValue   $deleveryValue');
                                                                print(
                                                                    '"deleveryValue"   $BillValue (${DeliveryValue.runtimeType})');

                                                                paymentMethod =
                                                                    int.parse(listAddressUser.dataAddressList[selectAddress]
                                                                            [
                                                                            "PaymentMethod"]) ??
                                                                        2;
                                                                // widget.BilleValue=int.parse(listAddressUser.dataAddressList[selectAddress]["BillValue"]);
                                                                BillValue = listAddressUser
                                                                        .dataAddressList[
                                                                    listAddressUser
                                                                        .SelectIndexAddress]["BillValue"];
                                                                print(
                                                                    '"BillValue"   $BillValue');
                                                                print(
                                                                    '"BillValue"   $BillValue (${BillValue.runtimeType})');

                                                                BillValue = (UserPhone !=
                                                                        null)
                                                                    ? listAddressUser
                                                                            .dataAddressList[
                                                                        listAddressUser
                                                                            .SelectIndexAddress]["BillValue"]
                                                                    : BillValue;
                                                                print(
                                                                    BillValue);
                                                              });

                                                              listAddressUser
                                                                  .changeSelectIndex(
                                                                      index);
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            visualDensity:
                                                                const VisualDensity(
                                                                    horizontal:
                                                                        -4,
                                                                    vertical:
                                                                        -4),
                                                          ),
                                                        ],
                                                      ),
                                                      item["MapCustomerAddress"] ==
                                                              null
                                                          ? const SizedBox
                                                              .shrink()
                                                          : InkWell(
                                                              onTap: () {
                                                                print(item);
                                                              },
                                                              child: Text(
                                                                '${item["MapCustomerAddress"]}',
                                                                maxLines: 2,
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      11.sp,
                                                                  color: Colors
                                                                      .black,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontFamily:
                                                                      'Monadi',
                                                                ),
                                                                textAlign:
                                                                    TextAlign
                                                                        .center,
                                                              ),
                                                            ),
                                                      5.verticalSpace,
                                                      Text(
                                                        '${item["CustomerAddress"]}',
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontSize: 11.sp,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontFamily:
                                                              'Monadi',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                10.verticalSpace,
                                                const Divider(
                                                  height: 1, // ارتفاع الخط
                                                  color:
                                                      Colors.grey, // لون الخط
                                                ),
                                              ],
                                            );
                                          });
                                    }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Row(
                  children: [
                    Text(
                      (lang.activeLanguage.languageCode == 'ar')
                          ? 'التوصيل الى '
                          : 'Delivery to ',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: AppColors.black,
                      ),
                    ),
                    Text(
                      '${(UserPhone != null ) ? listAddressUser.dataAddressList[listAddressUser.SelectIndexAddress]["DistrictName2"] : valueselectedDistrict}',
                      style: GoogleFonts.cairo(
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp,
                        color: AppColors.black,
                      ),
                    )
                  ],
                ),
              )
          //  : Text(''),
      );
  }
