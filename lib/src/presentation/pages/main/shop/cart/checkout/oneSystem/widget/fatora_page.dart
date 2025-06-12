
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';
import '../../../../../../../../core/constants/app_assets.dart';
import '../../../../../../../../riverpod/gh.dart';
import '../../../../../../pages.dart';
import '../../../../../drawer/MyPreviousRequests/view/my_previous_requets_screen.dart';

class Fatora extends ConsumerStatefulWidget {
  List<Map<String, dynamic>> listIteamFatora;
  List<Map<String, dynamic>> listImageFatora;
  dynamic totalValue;
  String data;
  String time;
  dynamic discount;
  dynamic finalValue;
  dynamic payId;
  String ordeTime;
  String DeliveryDay;
  String DeliveryData;
  String numberFaota;
  String address;
  String block;
  String distrubit;
  String name;
  String phone;
  String Strate;
  String House;
  num ValueFi;
  num delivery;
  String gada;
  String? addressCustoomer;
  String? Details;
  String? Floor;
  String? Apartment;
  String? regionName;
  dynamic paymentMethodeWalet;
  dynamic discountPointsValue;

  Map<String, String> Day = {
    "Saturday": "السبت",
    "Sunday": "الأحد",
    "Friday": "الجمعة",
    "Monday": "الإثنين",
    "Tuesday": "الثلاثاء",
    "Wednesday": "الأربعاء",
    "Thursday": "الخميس",
  };

  Fatora(
      {super.key,
      required this.numberFaota,
      required this.DeliveryData,
      required this.address,
      required this.ordeTime,
      required this.DeliveryDay,
      required this.listIteamFatora,
      required this.data,
      required this.time,
      required this.totalValue,
      required this.discount,
      required this.finalValue,
      required this.payId,
      required this.listImageFatora,
      required this.phone,
      required this.name,
      required this.gada,
      required this.block,
      required this.distrubit,
      required this.Strate,
      required this.House,
      required this.ValueFi,
      required this.delivery,
      this.addressCustoomer,
      this.Details,
      this.Floor,
      this.regionName,
      this.Apartment,
      this.discountPointsValue,
      this.paymentMethodeWalet});

  @override
  _FatoraState createState() => _FatoraState();
}

class _FatoraState extends ConsumerState<Fatora> {
  int totalQuantity = 0;

  void initState() {
    super.initState();
    totalQuantity = calculateTotalQuantity(widget.listIteamFatora);
  }

  int calculateTotalQuantity(List<Map<String, dynamic>> items) {
    return items.fold(
        0,
        (total, item) =>
            total + (int.tryParse(item['Quantity'].toString()) ?? 10));
  }

  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0,
          backgroundColor: Colors.white,
          leading: Text(''),
          elevation: 0.0,
          title: Text(
            (appModel.activeLanguage.languageCode == 'ar')
                ? 'تم  الطلب بنجاح'
                : 'The order has been registered successfully',
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
              fontFamily: 'Monadi',
            ),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    AppAssets.pngOneSystemTomnaLogo,
                    height: 100,
                  ),
                ),

                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'تفاصيل الفاتورة'
                        : 'INVOCE DETAILS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),
                10.verticalSpace,
                Row(
                  children: [
                      Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'رقم الفاتوره:'
                              : 'Invoice Number:',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                     
                     10.horizontalSpace,

                      SizedBox(
                          
                          width: MediaQuery.of(context).size.width *0.6 ,
                          child: Text(
                            maxLines: 3,
                            widget.numberFaota,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Monadi',
                            ),
                          ),
                        ),

                  
                  ],
                ),
                const SizedBox(
                      height: 10,
                    ),
                  
                 Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'وقت التوصيل:'
                              : 'Delivery Time:',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                       10.horizontalSpace,
                        Directionality(
                          textDirection: TextDirection.ltr,
                          child: Text(
                            widget.ordeTime,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Monadi',
                            ),
                          ),
                        ),
                      ],
                    )
                 ,
               const SizedBox(
                      height: 10,
                    ),
                  
                Row(
                  children: [
                    Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? 'تاريخ التوصيل:'
                          : 'Delivery Date:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.indigo,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Monadi',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      widget.DeliveryData,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Monadi',
                      ),
                    ),
                  ],
                ),
              
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? 'يوم التوصيل:'
                          : 'Delivery Day:',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.indigo,
                        fontWeight: FontWeight.normal,
                        fontFamily: 'Monadi',
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      (appModel.activeLanguage.languageCode == 'ar')
                          ? ' ${widget.Day[widget.DeliveryDay]}'
                          : '  ${widget.DeliveryDay}',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.black,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Monadi',
                      ),
                    ),
                  ],
                ),

                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'تفاصيل العميل'
                        : 'CUSTOMER DETAILS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'الاسم '
                              : 'Name',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'الموبيل'
                              : 'Phone',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          '${widget.phone}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'تفاصيل العنوان'
                        : 'ِADDRESS DETAILS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),

                if (UserPhone == null)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'المحافظه '
                                      : 'Governorate',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'المنطقه  '
                                      : 'Address',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'الجاده  '
                                      : 'Gada',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "المنزل  "
                                      : 'House',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 40,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.regionName ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.distrubit ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.gada ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.House ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "الدور"
                                      : 'Floor',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'البلوك  '
                                      : 'Block',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "الشارع"
                                      : 'Street',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? "الشقه"
                                      : 'Apartment',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.indigo,
                                    fontWeight: FontWeight.normal,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  widget.Floor ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.block ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.Strate ?? '',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                Text(
                                  widget.Apartment ?? '',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                if (UserPhone != null)
                  Text(
                    '${widget.addressCustoomer}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.indigo,
                      fontWeight: FontWeight.w300,
                      fontFamily: 'Monadi',
                    ),
                  ),
                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'تفاصيل الطلب'
                        : 'ِORDER DETAILS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'اسم الصنف'
                              : 'Product Name',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
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
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
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
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
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
                              color: Colors.black,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Monadi',
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: widget.listIteamFatora.length,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? '${widget.listImageFatora[index]["ProductArName"]}'
                                    : '${widget.listImageFatora[index]["ProductEnName"]}',
                                maxLines: 2,
                                style: TextStyle(
                                  fontSize: 14.sp,
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
                                  '${widget.listIteamFatora[index]['Quantity']}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
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
                                  '${widget.listIteamFatora[index]['Price'].toStringAsFixed(3)}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 1,
                              child: Center(
                                child: Text(
                                  '${(widget.listIteamFatora[index]['Price'] * widget.listIteamFatora[index]['Quantity']).toStringAsFixed(3)} ',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Center(
                  child: Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? "تفاصيل الدفع"
                        : 'ِPAYMENT DETAILS',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Monadi',
                    ),
                  ),
                ),

                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? "المجموع الفرعي"
                              : 'SUB TOTAL',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? ' الخصم : '
                              : ' Discount : ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? ' رسوم التوصيل : '
                              : ' Delivery : ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        // Text((appModel.activeLanguage.languageCode == 'ar')
                        //                         ? ' الخصم من النقاط : '
                        //                         : ' Discount : ',
                        //                       style: TextStyle(
                        //                         fontSize: 16.sp,
                        //                         color: Colors.indigo,
                        //                         fontWeight: FontWeight.normal,
                        //                         fontFamily: 'Monadi',
                        //                       ),),
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? 'طريقه الدفع '
                              : 'Payment Method',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),

                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')
                              ? ' السعر النهائى : '
                              : ' final price : ',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.indigo,
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${widget.totalValue.toStringAsFixed(3)}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          '${widget.discount ?? ''}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                        Text(
                          '${widget.delivery ?? ''}',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),

                        // Text('${widget.discountPointsValue??''}',
                        //                       style: TextStyle(
                        //                         fontSize: 16.sp,
                        //                         color: Colors.black,
                        //                         fontWeight: FontWeight.w300,
                        //                         fontFamily: 'Monadi',
                        //                       ),),
                        Text.rich(
                          (widget.paymentMethodeWalet != null)
                              ? TextSpan(
                                  text: 'الدفع عن طريق المحفظه',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                )
                              : TextSpan(
                                  text: (widget.payId == 0)
                                      ? 'الدفع عند الاستلام'
                                      : 'الدفع كى نت',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                        ),

                        Text(
                          '${widget.ValueFi.toStringAsFixed(3)}' ?? '',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Monadi',
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                10.verticalSpace,

                // Text('${widget.totalValue.toStringAsFixed(3)}',
                //   style: TextStyle(
                //     color: Colors.black,
                //     fontSize: 16.sp,
                //     fontWeight: FontWeight.w300,
                //     fontFamily: 'Monadi',
                //     letterSpacing: 1.1,
                //   ),),

                10.verticalSpace,

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     RichText(
                //       text: TextSpan(
                //         children: [
                //           TextSpan(
                //             text: (appModel.activeLanguage.languageCode == 'ar')
                //                 ? ' اجمالى الكميه : '
                //                 : 'Total quantity:',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.black,
                //               fontWeight: FontWeight.normal,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //           TextSpan(
                //             text: '${totalQuantity}',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.indigo,
                //               fontWeight: FontWeight.w300,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     RichText(
                //       text: TextSpan(
                //         children: [
                //           TextSpan(
                //             text: (appModel.activeLanguage.languageCode == 'ar')
                //                 ? ' الاجمالى  : '
                //                 : 'Total',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.black,
                //               fontWeight: FontWeight.normal,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //           TextSpan(
                //             text: '${widget.totalValue.toStringAsFixed(3)}',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.indigo,
                //               fontWeight: FontWeight.w300,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),

                // 10.verticalSpace,
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     RichText(
                //       text: TextSpan(
                //         children: [
                //           TextSpan(
                //             text: (appModel.activeLanguage.languageCode == 'ar')
                //                 ? ' رسوم التوصيل : '
                //                 : ' Delivery : ',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.black,
                //               fontWeight: FontWeight.normal,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //           TextSpan(
                //             text: '${widget.delivery}',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.indigo,
                //               fontWeight: FontWeight.w300,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //     RichText(
                //       text: TextSpan(
                //         children: [
                //           TextSpan(
                //             text: (appModel.activeLanguage.languageCode == 'ar')
                //                 ? ' السعر النهائى : '
                //                 : ' final price : ',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.black,
                //               fontWeight: FontWeight.normal,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //           TextSpan(
                //             text: '${widget.ValueFi.toStringAsFixed(3)}',
                //             style: TextStyle(
                //               fontSize: 16.sp,
                //               color: Colors.indigo,
                //               fontWeight: FontWeight.w300,
                //               fontFamily: 'Monadi',
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ],
                // ),
                //
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: (appModel.activeLanguage.languageCode == 'ar')
                //             ? ' الخصم : '
                //             : ' Discount : ',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.black,
                //           fontWeight: FontWeight.normal,
                //           fontFamily: 'Monadi',
                //         ),
                //       ),
                //       TextSpan(
                //         text: '${widget.discount}',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.indigo,
                //           fontWeight: FontWeight.w300,
                //           fontFamily: 'Monadi',
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // RichText(
                //   text: TextSpan(
                //     children: [
                //       TextSpan(
                //         text: (appModel.activeLanguage.languageCode == 'ar')
                //             ? ' الخصم من النقاط : '
                //             : ' Discount : ',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.black,
                //           fontWeight: FontWeight.normal,
                //           fontFamily: 'Monadi',
                //         ),
                //       ),
                //       TextSpan(
                //         text: '${widget.discountPointsValue}',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.indigo,
                //           fontWeight: FontWeight.w300,
                //           fontFamily: 'Monadi',
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // Center(
                //   child: Container(
                //     width: 120.w,
                //     height: 30.h,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         color: Colors.green),
                //     child: Center(
                //       child: Text(
                //         (appModel.activeLanguage.languageCode == 'ar')
                //             ? 'بيانات العميل'
                //             : 'Customer data',
                //         style: TextStyle(
                //           fontSize: 16.sp,
                //           color: Colors.white,
                //           fontWeight: FontWeight.normal,
                //           fontFamily: 'Monadi',
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
                // 10.verticalSpace,

                5.verticalSpace,

                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //
                //
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                       'ar')
                //                       ? 'المحافظه '
                //                       : 'Governorate',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.regionName}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? 'المنطقه  '
                //                       : 'Address',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.distrubit}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? 'الجاده  '
                //                       : 'Gada',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.gada}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? "المنزل  "
                //                       : 'House',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.House}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? "الدور"
                //                       : 'Floor',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.Floor}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //       ],
                //     ),
                //     Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? 'البلوك  '
                //                       : 'Block',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.block}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? "الشارع"
                //                       : 'Street',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.Strate}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         if (UserPhone == null)
                //           RichText(
                //             text: TextSpan(
                //               children: [
                //                 TextSpan(
                //                   text: (appModel.activeLanguage.languageCode ==
                //                           'ar')
                //                       ? "الشقه"
                //                       : 'Apartment',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.black,
                //                     fontWeight: FontWeight.normal,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //                 TextSpan(
                //                   text: '${widget.Apartment}',
                //                   style: TextStyle(
                //                     fontSize: 16.sp,
                //                     color: Colors.indigo,
                //                     fontWeight: FontWeight.w300,
                //                     fontFamily: 'Monadi',
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //       ],
                //     ),
                //   ],
                // ),

                20.verticalSpace,
                Consumer(builder: (context, ref, child) {
                  final listItemOrderImage = ref.watch(orderProviderListImage);
                  final listItemOrder = ref.watch(orderProviderList);
                  return InkWell(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => MainPage()),
                      );

                      print(listItemOrder.orderList.length);
                      print(listItemOrderImage.orderListImage.length);
                      listItemOrder.clearItems();
                      listItemOrderImage.clearItems();
                      listItemOrder.clearItems();
                      print(listItemOrder.orderList.length);
                      print(listItemOrderImage.orderListImage.length);
                      listItemOrder.clearItems();
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Container(
                          height: 40.h,
                          decoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              (appModel.activeLanguage.languageCode == 'ar')
                                  ? 'الرجوع الى الصفحه الرئيسية'
                                  : 'Home page',
                              style: TextStyle(
                                fontSize: 18.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'Monadi',
                              ),
                            ),
                          )),
                    ),
                  );
                }),
                20.verticalSpace,
                Consumer(
                  builder: (context, ref, child) {
                    final listItemOrderImage =
                        ref.watch(orderProviderListImage);
                    final listItemOrder = ref.watch(orderProviderList);
                    return InkWell(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyPreviousRequetsScreen()),
                        );
                        print(listItemOrder.orderList.length);
                        print(listItemOrderImage.orderListImage.length);
                        listItemOrder.clearItems();
                        listItemOrderImage.clearItems();
                        listItemOrder.clearItems();
                        print(listItemOrder.orderList.length);
                        print(listItemOrderImage.orderListImage.length);
                        listItemOrder.clearItems();
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                            height: 40.h,
                            decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(30),
                            ),
                            child: Center(
                              child: Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? 'متابعة الطلب'
                                    : 'Order Tracking',
                                style: TextStyle(
                                  fontSize: 18.sp,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'Monadi',
                                ),
                              ),
                            )),
                      ),
                    );
                  },
                ),
                20.verticalSpace,
                Center(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // محاذاة النصوص في المنتصف
                    children: [
                      Text(
                        (appModel.activeLanguage.languageCode == 'ar')
                            ? 'شكرًا لتسوقكم'
                            : 'Thank you for shopping',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.indigo,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Monadi',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2), // مسافة بين النصوص
                      Text(
                        'WhatsApp: 22285055',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.indigo,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Monadi',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 2), // مسافة بين النصوص
                      Text(
                        '@tmwenatapp',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.indigo,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Monadi',
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                100.verticalSpace,
              ],
            ),
          ),
        ));
  }
}
