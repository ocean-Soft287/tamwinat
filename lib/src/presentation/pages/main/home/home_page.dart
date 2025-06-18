import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/src/presentation/pages/main/Notification/notification_service.dart/notification.service.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/best_seller_widget.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/image_banner_on_list.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/image_banner_two_list.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/list_item_order.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/main_category_list.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/new_list_widget.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/offer_items.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/product_version_list.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/show_group.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/show_offers.dart';
import '../../../../../main.dart';
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
  int currentPage = 0;


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
    return   SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageBannerOnList(currentPage: currentPage,),
            14.verticalSpace,
            NewListWidget(),
            14.verticalSpace,
            MainCategoryList(),
            10.verticalSpace,
            ImageBannerTwoList(currentPage: currentPage,),
            10.verticalSpace,
            BestSellerWidget(isSecondContainerVisibleListbestSeller:isSecondContainerVisibleListbestSeller
             , UserPhone: UserPhone
             , UserPhoneAll: UserPhoneAll,
               isSecondContainerVisibleListBiggestDiscount: isSecondContainerVisibleListBiggestDiscount
         ),
            5.verticalSpace,
            ListItemOrderPage( UserPhone:UserPhone,UserPhoneAll:UserPhoneAll ,isSecondContainerVisibleListBiggestDiscount: isSecondContainerVisibleListBiggestDiscount),
            5.verticalSpace,

           ProductVersionList( UserPhone
           : UserPhone, UserPhoneAll: UserPhoneAll,
            isSecondContainerProductVersion: isSecondContainerProductVersion, ),
          
            5.verticalSpace,
            ShowOffers(isSecondContainerVisibleList1: isSecondContainerVisibleList1 ,),
           
            5.verticalSpace,
             ShowGroup(currentPage: currentPage,)  ,        
            10.verticalSpace,
          
            OfferItems( UserPhone: UserPhone, UserPhoneAll: UserPhoneAll,   isSecondContainerVisibleList2: isSecondContainerVisibleList2,),
          ],
        ),
      );
    
 
  }


}
