
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:sundaymart/src/core/constants/app_assets.dart';

import 'package:sundaymart/src/presentation/pages/main/drawer/MyPreviousRequests/view/widget/custom_step.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/MyPreviousRequests/view/widget/order_detalise_screen.dart';

import '../../../../../../riverpod/gh.dart';


import '../../../../pages.dart';
import '../manager/my_previous_request_state.dart';
import '../manager/my_previous_requets_riverpod.dart';


class MyPreviousRequetsScreen extends ConsumerStatefulWidget {
  @override
  _MyPreviousRequetsScreenState createState() => _MyPreviousRequetsScreenState();
}

class _MyPreviousRequetsScreenState extends ConsumerState<MyPreviousRequetsScreen> {
  @override
  bool isLoading = true;

  void initState() {

    super.initState();

    ref
        .read(getDataMyPreviousRequetsApiProvider.notifier)
        .getMyPreviousRequetsPhone();


    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        isLoading = false;
      });
    });
  }
  @override
  void dispose() {
    // Cancel the stream subscription

    super.dispose();
  }
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey.shade100,

        appBar:PreferredSize(
        preferredSize: const Size.fromHeight(40),

          child:ClipRRect(
            child: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation)=>MainPage(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child)
                      =>SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      ),
                    ),(route) =>true ,



                  );


                },
                icon: const Icon(Icons.arrow_forward_ios,color: Colors.black,size: 20,),
              ),
              elevation: 0.0,

              title:
              Text(
                (appModel.activeLanguage.languageCode == 'ar')?
                'متابعه الطلبات' :'My previous requests',

                style: const TextStyle(
                    color: Colors.black,
                  fontFamily: 'Monadi',
                  fontSize: 18,
                  fontWeight: FontWeight.bold
                ),

              ), centerTitle: true,



            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(child: Text(
                  (appModel.activeLanguage.languageCode == 'ar')?

                  'متابعه الطلب':'Track Order',style: const TextStyle(fontFamily: 'Monadi',),), ),
                Tab(child: Text(  (appModel.activeLanguage.languageCode == 'ar')?'الطلبات السابقه':'Previous Requests',style: TextStyle(fontFamily: 'Monadi',),),),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Consumer(
                    builder: (context, ref, child) {
                      final getDataAsyncValue = ref.watch(getDataStateProvider);

                      return getDataAsyncValue.when(
                        data: (getData) {
                          return Container(
                            color: Colors.white,
                            child:
                            (getData.isEmpty)?
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.center,

                              children: [
                                Lottie.asset(
                                  'assets/lottie/cartEmpty.json', // مسار ملف JSON

                                  height: 300,

                                  repeat: true,
                                  animate: true,
                                ),
                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'لا توجد طلبيات سابقة'
                                      : 'No previous orders',
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[700],
                                    fontFamily: 'Monadi',
                                  ),
                                ),
                                const SizedBox(height: 10), // مسافة بين النص والزر


                                Text(
                                  (appModel.activeLanguage.languageCode == 'ar')
                                      ? 'قم بإنشاء طلبيتك الأولى ومتابعة حالتها من هنا'
                                      : 'Create your first order and track its status from here',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                    fontFamily: 'Monadi',
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 20),
                              ],

                            )
                                :



                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  buildStep(
                                    context,
                                      (appModel.activeLanguage.languageCode == 'ar')?
                                    'تم إرسال طلبك':
                                      'Your request has been sent.',
                                      (appModel.activeLanguage.languageCode == 'ar')?
                                    'جاري متابعة الطلب':'Your request is being processed.',
                                    Icons.check_circle,
                                    getData[0]['SendingOrder'],
                                    AppAssets.sentOrder,
                                      true
                                  ),
                                  buildStep(
                                    context,
                                    (appModel.activeLanguage.languageCode == 'ar')
                                        ? 'تم استلام الطلب بنجاح' // Arabic
                                        : 'The order has been received successfully', // English
                                    (appModel.activeLanguage.languageCode == 'ar')
                                        ? 'لقد استلمنا طلبك ويتم الآن التواصل مع المتجر' // Arabic
                                        : 'We have received your order, and we are now contacting the store', // English
                                    Icons.check_circle,
                                    getData[0]['StartDeliver'],
                                    AppAssets.receivedOrder,
                                    true,
                                  ),
                                  buildStep(
                                    context,
                                    (appModel.activeLanguage.languageCode == 'ar')
                                        ? 'الطلب الآن تحت التحضير' // Arabic
                                        : 'The order is now being prepared', // English
                                    (appModel.activeLanguage.languageCode == 'ar')
                                        ? 'تم استلام الطلب من المتجر ويقوم الموظف المسؤول بتجميع الطلب حاليا' // Arabic
                                        : 'The order has been received from the store, and the responsible staff is currently assembling the order', // English
                                    Icons.check_circle,
                                    getData[0]['Prepare'],
                                    AppAssets.preparingOrder,
                                    true,
                                  ),
                                  buildStep(
                                    context,
                                    (appModel.activeLanguage.languageCode == 'ar')
                                        ? 'طلبك في الطريق الآن' // Arabic
                                        : 'Your order is now on its way', // English
                                    (appModel.activeLanguage.languageCode == 'ar')
                                        ? 'طلبك في الطريق إليك وسوف يصلك خلال ساعة' // Arabic
                                        : 'Your order is on its way to you and will reach you within an hour', // English
                                    Icons.check_circle,
                                    getData[0]['UnderDeliver'],
                                    AppAssets.onTheWayOrder,
                                    true,
                                  ),
                                  buildStep(
                                    context,
                                    (appModel.activeLanguage.languageCode == 'ar')
                                        ? 'تم التوصيل' // Arabic
                                        : 'Delivered', // English
                                    (appModel.activeLanguage.languageCode == 'ar')
                                        ? 'تم توصيل الطلب بنجاح' // Arabic
                                        : 'The order has been successfully delivered', // English
                                    Icons.check_circle,
                                    getData[0]['Delivered'],
                                    AppAssets.onTheWayOrder,
                                    false,
                                  ),

                                ],
                              ),
                            ),
                          );
                        },
                        loading: () => const Center(child: CircularProgressIndicator()),
                        error: (error, stack) => Center(child: Text('Error: $error')),
                      );
                    },
                  ),

                  Consumer(
                    builder: (context, ref, child) {
                      final myPreviousRequetsProduct = ref.watch(getDataMyPreviousRequetsApiProvider);


                      return
                        (myPreviousRequetsProduct.myPreviousRequetsPhoneList.isEmpty)?
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [
                            Lottie.asset(
                              'assets/lottie/cartEmpty.json', // مسار ملف JSON

                              height: 300,

                              repeat: true,
                              animate: true,
                            ),
                                                  Text(
                              (appModel.activeLanguage.languageCode == 'ar')?
                              'لا توجد طلبيات سابقة'
                              :
                              'No previous orders',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey[700],
                                fontFamily: 'Monadi',
                              ),
                            ),
                            const SizedBox(height: 10), // مسافة بين النص والزر

                            // نص تشجيعي
                            Text(
                              (appModel.activeLanguage.languageCode == 'ar')?
                              'ابدأ التسوق الآن وقم بإنشاء طلبك الأول!'

                              :

                              'Start shopping now and create your first order!',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey[600],
                                fontFamily: 'Monadi',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 20),
                          ],

                        )
                          :
                        ListView.builder(
                            itemCount: myPreviousRequetsProduct.myPreviousRequetsPhoneList.length,
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemBuilder: (context, index)
                            {
                              final item= myPreviousRequetsProduct.myPreviousRequetsPhoneList[index];
                              return  Padding(
                                padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 4),
                                child: Container(
                                  padding:  const EdgeInsets.symmetric(vertical: 5,horizontal: 2),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    color: Colors.white,
                                  ),
                                  child: InkWell(
                                      onTap: () {


                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OrderDetalise(IteamID:item["OrderNo"] ,)
                                          ),
                                        );
                                      },
                                      child:
                                      Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [

                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        (appModel.activeLanguage.languageCode == 'ar')?
                                                        ' رقم الطلبيه ':
                                                        'OrderNo:' ,
                                                        style: TextStyle(
                                                          fontSize: 17.sp,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Monadi',
                                                        ),


                                                      ),
                                                      TextSpan(
                                                        text:
                                                        '${item["OrderNo"]}',
                                                        style: TextStyle(
                                                          fontSize: 17.sp,
                                                          color: Colors.black,
                                                          fontWeight: FontWeight.bold,
                                                          fontFamily: 'Monadi',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text( (appModel.activeLanguage.languageCode == 'ar')?
                                                ' تم الاستلام ':
                                                "It was received" ,
                                                  style: TextStyle(
                                                    fontSize: 14.sp,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w300,
                                                    fontFamily: 'Monadi',
                                                  ),),
                                                RichText(
                                                  text: TextSpan(
                                                    children: [
                                                      TextSpan(
                                                        text:
                                                        (appModel.activeLanguage.languageCode == 'ar')?
                                                        '  تاريخ الطلبيه  ':
                                                        'OrderDate:' ,
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight.w300,
                                                          fontFamily: 'Monadi',
                                                        ),


                                                      ),
                                                      TextSpan(
                                                        text:
                                                        DateFormat('dd/MM/yyyy').format(DateTime.parse(item["OrderDate"])),
                                                        style: TextStyle(
                                                          fontSize: 14.sp,
                                                          color: Colors.grey,
                                                          fontWeight: FontWeight.w300,
                                                          fontFamily: 'Monadi',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),

                                                Wrap(
                                                  crossAxisAlignment: WrapCrossAlignment.center,
                                                  children: [
                                                    Text((appModel.activeLanguage.languageCode == 'ar')?
                                                    ' عنوان التوصيل ':
                                                    'Address' ,
                                                      style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: Colors.black,
                                                        fontWeight: FontWeight.w300,
                                                        fontFamily: 'Monadi',
                                                      ),),

                                                    RichText(
                                                      text: TextSpan(
                                                        children: [

                                                          TextSpan(
                                                            text:
                                                            '${item["Details"]}',
                                                            style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color: Colors.grey,
                                                              fontWeight: FontWeight.w300,
                                                              fontFamily: 'Monadi',
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    1.horizontalSpace,








                                                  ],
                                                ),

                                                RichText(textAlign: TextAlign.start,

                                                  text: TextSpan(

                                                    children: [
                                                      TextSpan(

                                                        text:
                                                        (appModel.activeLanguage.languageCode == 'ar')?
                                                        'اجمالى السعر ':
                                                        'total price' ,
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.orange,
                                                          fontWeight: FontWeight.w300,
                                                          fontFamily: 'Monadi',
                                                        ),


                                                      ),
                                                      TextSpan(
                                                        text:
                                                        '${item["TotalValue"].toStringAsFixed(3)}',
                                                        style: TextStyle(
                                                          fontSize: 16.sp,
                                                          color: Colors.orange,
                                                          fontWeight: FontWeight.w300,
                                                          fontFamily: 'Monadi',
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),


                                              ],
                                            ),
                                          ),
                                          Icon(Icons.arrow_forward_ios,size: 60.w,color: Colors.grey,)
                                        ],
                                      )


                                  ),
                                ),
                              );
                            }


                        );

                    },
                  ),
                ],
              ),
            ),
          ],
        )

      ),
    );
  }
}



