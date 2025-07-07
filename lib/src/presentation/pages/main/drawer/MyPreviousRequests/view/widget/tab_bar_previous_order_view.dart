import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymart/src/core/constants/app_assets.dart';
import 'package:sundaymart/src/core/utils/shared_refrence.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/MyPreviousRequests/manager/my_previous_request_state.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/MyPreviousRequests/manager/my_previous_requets_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/MyPreviousRequests/view/widget/custom_step.dart';
import 'package:sundaymart/src/riverpod/gh.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/MyPreviousRequests/view/widget/order_detalise_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersTabBar extends ConsumerStatefulWidget {
  const OrdersTabBar({
    super.key,
    required this.appModel,
  });

  final AppModel appModel;

  @override
  ConsumerState<OrdersTabBar> createState() => _OrdersTabBarState();
}

class _OrdersTabBarState extends ConsumerState<OrdersTabBar> with SingleTickerProviderStateMixin {
      late TabController tabController ;

  
    @override
  void initState() {
    init();

    super.initState();
  }
  void init(){
   
  setState(() {
   tabController = TabController(length: 2, vsync: this);
  });

  }
  @override
  void dispose() {
    if(mounted){
    tabController .dispose();

    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
   return     Column(
        
        children: [
          TabBar(
            controller: tabController,
            onTap: (value) {
              tabController.animateTo(value);
            },
            tabs: [
              tab1(appModel: widget.appModel),
              tab2(appModel: widget.appModel),
            ],
          ),
          Expanded(
            child: TabBarView(
                          controller: tabController,
      
              children: [
                TabView1(appModel: widget.appModel,onTabTapped: (isDelervery) {
                     WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isDelervery) {
        tabController.animateTo(1);
      }
    });
              
                },),
                TabView2(appModel: widget.appModel),
           
              ],
            ),
          ),
       
        ],
      );
        
      }
   
    );
  }
}

class TabView2 extends StatelessWidget {
  const TabView2({
    super.key,
    required this.appModel,
  });

  final AppModel appModel;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
            final myPreviousRequetsProduct = ref.watch(getDataMyPreviousRequetsApiProvider);

        
     return   StreamBuilder(
          stream: myPreviousRequetsProduct.getMyPreviousRequetsPhoneStreamBuilder(),
          builder: (context, snapshot) {
             
            if (snapshot.hasError) {
                                          return Text('Error: ${snapshot.error}');
        
            }
            if (snapshot.hasData) 
            {
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
        
        
               myPreviousRequetsProduct.myPreviousRequetsPhoneList=snapshot.data!;
               myPreviousRequetsProduct.myPreviousRequetsPhoneList.sort((a, b) => b["OrderNo"].compareTo(a["OrderNo"]));
              // myPreviousRequetsProduct.myPreviousRequetsPhoneList= myPreviousRequetsProduct.myPreviousRequetsPhoneList.reversed.toList();
           return                         ListView.builder(
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
        
              
            }
              return Center(child: const CircularProgressIndicator());
         
          }
        );
        
            
      },
    );
  }
}

class TabView1 extends StatefulWidget {
  const TabView1({
    super.key,
    required this.appModel, required this.onTabTapped,
  });

  final AppModel appModel;
  final Function(bool isDelervery) onTabTapped;

  @override
  State<TabView1> createState() => _TabView1State();
}

class _TabView1State extends State<TabView1> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        
               return   StreamBuilder(
      stream: GetMyPreviousRequestStateFromApi().previousRequestStateStream,
     builder: (context, snapshot) {
       if (snapshot.hasData) {
    
         final prefs=  SharedPreferencesService();
         final apiLastOrderNo =   snapshot.data![0]["OrderNo"];
         final lastorderNo  =  prefs.getInt('OrderNo');
         if(
          apiLastOrderNo != lastorderNo && apiLastOrderNo != null
         ){
          Fluttertoast.showToast(msg: 'تم توصيل الطلبية بنجاح',
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
          prefs.remove( 'OrderNo').then((onValue){
           widget.onTabTapped(true);

          });

         }
       prefs.saveInt('OrderNo', apiLastOrderNo );
            return Container(
              color: Colors.white,
              child:
             // (getData.isEmpty)?
               
            //  :
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    buildStep(
                      context,
                        (widget.appModel.activeLanguage.languageCode == 'ar')?
                      'تم إرسال طلبك':
                        'Your request has been sent.',
                        (widget.appModel.activeLanguage.languageCode == 'ar')?
                      'جاري متابعة الطلب':'Your request is being processed.',
                      Icons.check_circle,
                      snapshot.data![0]['SendingOrder'],
                      AppAssets.sentOrder,
                        true
                    ),
                    buildStep(
                      context,
                      (widget.appModel.activeLanguage.languageCode == 'ar')
                          ? 'تم استلام الطلب بنجاح' // Arabic
                          : 'The order has been received successfully', // English
                      (widget.appModel.activeLanguage.languageCode == 'ar')
                          ? 'لقد استلمنا طلبك ويتم الآن التواصل مع المتجر' // Arabic
                          : 'We have received your order, and we are now contacting the store', // English
                      Icons.check_circle,
                      snapshot.data![0]['StartDeliver'],
                      AppAssets.receivedOrder,
                      true,
                    ),
                    buildStep(
                      context,
                      (widget.appModel.activeLanguage.languageCode == 'ar')
                          ? 'الطلب الآن تحت التحضير' // Arabic
                          : 'The order is now being prepared', // English
                      (widget.appModel.activeLanguage.languageCode == 'ar')
                          ? 'تم استلام الطلب من المتجر ويقوم الموظف المسؤول بتجميع الطلب حاليا' // Arabic
                          : 'The order has been received from the store, and the responsible staff is currently assembling the order', // English
                      Icons.check_circle,
                      snapshot.data![0]['Prepare'],
                      AppAssets.preparingOrder,
                      true,
                    ),
                    buildStep(
                      context,
                      (widget.appModel.activeLanguage.languageCode == 'ar')
                          ? 'طلبك في الطريق الآن' // Arabic
                          : 'Your order is now on its way', // English
                      (widget.appModel.activeLanguage.languageCode == 'ar')
                          ? 'طلبك في الطريق إليك وسوف يصلك خلال ساعة' // Arabic
                          : 'Your order is on its way to you and will reach you within an hour', // English
                      Icons.check_circle,
                      snapshot.data![0]['UnderDeliver'],
                      AppAssets.onTheWayOrder,
                      true,
                    ),
                    buildStep(
                      context,
                      (widget.appModel.activeLanguage.languageCode == 'ar')
                          ? 'تم التوصيل' // Arabic
                          : 'Delivered', // English
                      (widget.appModel.activeLanguage.languageCode == 'ar')
                          ? 'تم توصيل الطلب بنجاح' // Arabic
                          : 'The order has been successfully delivered', // English
                      Icons.check_circle,
                      snapshot.data![0]['Delivered'],
                      AppAssets.onTheWayOrder,
                      false,
                    ),
        
                  ],
                ),
              ),
            );
        
        //     return getDataAsyncValue.when(
        //   data: (getData) {
        
        //   },
        //   loading: () => const Center(child: CircularProgressIndicator()),
        //   error: (error, stack) => Center(child: Text('Error: $error')),
        // );
    
       } else if (snapshot.hasError) {
         return   Column(
                crossAxisAlignment: CrossAxisAlignment.center,
        
                children: [
                  Lottie.asset(
                    'assets/lottie/cartEmpty.json', // مسار ملف JSON
        
                    height: 300,
        
                    repeat: true,
                    animate: true,
                  ),
                  Text(
                    (widget.appModel.activeLanguage.languageCode == 'ar')
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
                    (widget.appModel.activeLanguage.languageCode == 'ar')
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
             ;
       }
    return  const Center(child: CircularProgressIndicator());
        
     },
    );
      
    
    
    
      },
    );
  }
}

class tab2 extends StatelessWidget {
  const tab2({
    super.key,
    required this.appModel,
  });

  final AppModel appModel;

  @override
  Widget build(BuildContext context) {
    return Tab(child: Text(  (appModel.activeLanguage.languageCode == 'ar')?'الطلبات السابقه':'Previous Requests',style: TextStyle(fontFamily: 'Monadi',),),);
  }
}

class tab1 extends StatelessWidget {
  const tab1({
    super.key,
    required this.appModel,
  });

  final AppModel appModel;

  @override
  Widget build(BuildContext context) {
    return Tab(child: Text(
      (appModel.activeLanguage.languageCode == 'ar')?
      'متابعه الطلب':'Track Order',style: const TextStyle(fontFamily: 'Monadi',),), );
  }
}


