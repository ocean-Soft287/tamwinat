import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../riverpod/gh.dart';
import '../../../../theme/app_colors.dart';
import '../../drawer/favorite/controler/favorite_riverpod.dart';

class ContactUs extends ConsumerStatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends ConsumerState<ContactUs> {
  void initState() {
    print('ssssssss');
    super.initState();
    ref
        .read(getAboutUsApiProvider.notifier).getAboutUsImage();


  }
  @override
Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_forward_ios,color: Colors.black),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        title:
        Text(
          (appModel.activeLanguage.languageCode == 'ar')?
          'من نحن':'About us',

          style:
          TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14.sp,
            fontFamily: 'Monadi',
            color: AppColors.black,
          ),


        ),

        centerTitle: true,



      ),
      body:
      Consumer(
        builder: (context,ref,child)
        {
          final getAboutUsImage = ref.watch(getAboutUsApiProvider);
          return ListView.builder(
              itemCount: getAboutUsImage.aboutUsFromApiList.length,
              itemBuilder: (context, index) {
                final item=getAboutUsImage.aboutUsFromApiList[index];
                return


                  Container(




                    child:Image.network('${item["ImagePath"]}',width: MediaQuery.of(context).size.width) ,
                  );

              }

          );
        },
      ) ,



    );
  }
}
// Future<void> lunchURL({required String url,required String method})async{
//
//   final Uri uri=Uri(scheme: method,path: url);
//   if(!await launchUrl(uri,mode: LaunchMode.externalApplication))
//   {
//     throw "cant lunch uri";
//   }
// }
//
// Padding(
// padding: const EdgeInsets.all(8.0),
// child:SingleChildScrollView(
// child:  Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// 10.verticalSpace,
//
//
// // InkWell(
// //   onTap: ()  {
// //
// //     lunchURL(url:'x.com/tmwenatapp',method: "https"  );
// //
// //   },
// //   child: CircleAvatar(
// //     backgroundColor: Colors.black,
// //     radius: 30.0,
// //     child: ImageIcon(
// //       AssetImage(AppAssets.x),
// //       color: Colors.white,
// //     ),
// //   ),
// // ),
// //
// // InkWell(
// //   onTap: ()  {
// //
// //     lunchURL(url:'instagram.com/tmwenatapp?igsh=ZmlrOHNkd2w0YThr&utm_source=qr',method: "https"  );
// //
// //   },
// //   child: Image.asset(
// //     width: 50,
// //       AppAssets.insta
// //
// //   ),
// // ),
// // InkWell(
// //   onTap: ()  {
// //
// //     lunchURL(url:'96590080770',method: "sms"  );
// //
// //   },
// //   child: Image.asset(
// //       width: 50,
// //       AppAssets.whats
// //
// //   ),
// // ),
// // InkWell(
// //   onTap: ()  {
// //
// //     lunchURL(url:'96590080770',method: "tel"  );
// //
// //   },
// //   child: Image.asset(
// //       width: 50,
// //       AppAssets.call
// //
// //   ),
// // ),
//
//
//
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
// 'شركة كويتية 100٪ ونقدم خدماتنا البيع بالجملة والبيع بالتجزئة للمواد الغذائيه والاستهلاكية والخضار والفواكة بارخص  الاسعار مع افضل جودة .':
// 'A 100% Kuwaiti company. We offer our services in wholesale and retail sale of food and consumer goods, vegetables and fruits at the cheapest prices with the best quality.',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 14.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
//
// ),
//
// 20.verticalSpace,
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
// 'تابعونا على وسائل التواصل الاجتماعي':'Follow us on social media',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 14.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 5.verticalSpace,
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
// 'نستقرام':'Instagram',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 4.verticalSpace,
//
// InkWell(
// onTap: (){
//
// lunchURL(url:'instagram.com/tmwenatapp?igsh=ZmlrOHNkd2w0YThr&utm_source=qr',method: "https"  );
// },
// child:   Text(
//
// 'Tmwenatapp',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.indigo,
// ),
// ),
// ),
//
// 5.verticalSpace,
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
// 'تويتر':'Twitter',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 4.verticalSpace,
// InkWell(
// onTap: (){
// lunchURL(url:'x.com/tmwenatapp',method: "https"  );
// },
// child:  Text(
//
// 'Tmwenatapp',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.indigo,
// ),
// ),
// ),
//
// 5.verticalSpace,
//
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
// 'توصل معنا عبر:':'Contact us via:',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 4.verticalSpace,
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
// ' واتساب':' WhatsApp',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 4.verticalSpace,
//
// InkWell(
// onTap: (){
//
// lunchURL(url:'96590080770',method: "tel"  );
// },
// child:Text(
//
// ' 90080770',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.indigo,
// ),
// ),
// ) ,
// 4.verticalSpace,
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
// 'اتصال':'Call',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 4.verticalSpace,
//
// InkWell(
// onTap: (){
// lunchURL(url:'96590080770',method: "tel"  );
// },
// child: Text(
//
// '90080770',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.indigo,
// ),
// ) ,
// )   ,
// 4.verticalSpace,
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
//
// 'الاستفسارات ':'Inquiries',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 4.verticalSpace,
//
// InkWell(
// onTap: (){
// lunchURL(url:'Info@tmwenatapp.com',method: "https"  );
// },
// child:  Text(
//
// 'Info@tmwenatapp.com',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
//
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.indigo,
// ),
// ) ,
// )  ,
//
//
// 4.verticalSpace,
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
// 'المشتريات':'Purchases',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 4.verticalSpace,
// InkWell(
// onTap: (){
//
// lunchURL(url:'Sales@tmwenatapp.com',method: "https"  );
// },
// child:  Text(
//
// 'Sales@tmwenatapp.com',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.indigo,
// ),
// ) ,
// ),
//
// 4.verticalSpace,
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
// 'التوظيف':'recruitment',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 4.verticalSpace,
// InkWell(
// onTap: (){
//
// lunchURL(url:'HR@tmwenatapp.com',method: "https"  );
// },
// child: Text(
//
// 'HR@tmwenatapp.com',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.indigo,
// ),
// ),
// ),
//
// 4.verticalSpace,
// Text(
// (appModel.activeLanguage.languageCode == 'ar')?
// 'التسويق':'Marketing',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 4.verticalSpace,
//
// InkWell(
//
// onTap: (){
//
// lunchURL(url:'marketing@tmwenatapp.com',method: "https"  );
// },
// child: Text(
//
// 'marketing@tmwenatapp.com',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.indigo,
// ),
// ),
// ) ,
//
// 4.verticalSpace,
// Text(
//
// 'الدعم الفني',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.black,
// ),
// ),
// 4.verticalSpace,
//
// InkWell(
// onTap: (){
// lunchURL(url:'Support@tmwenatapp.com',method: "https"  );
// },
// child: Text(
//
// 'Support@tmwenatapp.com',
//
// style: TextStyle(
// fontWeight: FontWeight.w300,
// fontSize: 12.sp,
// fontFamily: 'Monadi',
// color: Colors.indigo,
// ),
// ),
// )  ,
//
// 4.verticalSpace,
//
//
//
//
//
// //   اتصال
// //   90080770
// //
// //   الاستفسارات
// // Info@tmwenatapp.com
// //
// // المشتريات
// // Sales@tmwenatapp.com
// //
// //   التوظيف
// //   HR@tmwenatapp.com
// //
// // التسويق
// // marketing@tmwenatapp.com
// //
// // الدعم الفني
// // Support@tmwenatapp.com
// 20.verticalSpace,
//
//
// Container(
// padding: EdgeInsets.all(20),
// width: MediaQuery.of(context).size.width,
// decoration: BoxDecoration(
// color: Colors.white,
// borderRadius: BorderRadius.circular(20)
// ),
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// // Text(
// //   'تواصل معنا عبر الايميل ',
// //   style: TextStyle(
// //     fontWeight: FontWeight.w500,
// //     fontSize: 14.sp,
// //     fontFamily: 'Monadi',
// //     color: Colors.orange,
// //   ),
// // ),
// // TextButton(
// //   onPressed: () async {
// //     try {
// //       final Uri _emailLaunchUri = Uri(
// //         scheme: 'mailto',
// //         path: email,
// //       );
// //
// //       if (await canLaunch(_emailLaunchUri.toString())) {
// //         await launch(_emailLaunchUri.toString());
// //       } else {
// //         throw 'Could not launch $email';
// //       }
// //     } catch (e) {
// //       print('Error launching email: $e');
// //     }
// //   },
// //   child: Text(
// //     'Info@tmwenat.app',
// //     style: TextStyle(
// //       fontWeight: FontWeight.w500,
// //       fontSize: 14.sp,
// //       fontFamily: 'Monadi',
// //       color: AppColors.black,
// //     ),
// //   ),
// // ),
// // Text(
// //   'طلب توظيف',
// //   style: TextStyle(
// //     fontWeight: FontWeight.w500,
// //     fontSize: 14.sp,
// //     fontFamily: 'Monadi',
// //     color: Colors.orange,
// //   ),
// // ),
// // TextButton(
// //   onPressed: ()  {
// //     print('gamal');
// //     lunchURL(method: "maiito",
// //
// //     url: "Info@tmwenat.app"
// //     );
// //   },
// //   child: Text(
// //     'Info@tmwenat.app',
// //     style: TextStyle(
// //       fontWeight: FontWeight.w500,
// //       fontSize: 14.sp,
// //       fontFamily: 'Monadi',
// //       color: AppColors.black,
// //     ),
// //   ),
// // ),
//
// ],
// ),
// ),
// // Padding(
// //   padding: const EdgeInsets.all(2.0),
// //   child: RichText(
// //     text: TextSpan(
// //       children: [
// //         TextSpan(
// //
// //           text: ' + للشكاوى يرجى الاتصال على الرقم',
// //           style: TextStyle(
// //             fontSize: 16.sp,
// //             color: Colors.black,
// //             fontWeight: FontWeight.normal,
// //             fontFamily: 'Monadi',
// //           ),
// //         ),
// //         TextSpan(
// //           text: ' 96590080770',
// //           style: TextStyle(
// //             fontSize: 16.sp,
// //             color: Colors.orange,
// //             fontWeight: FontWeight.w300,
// //             fontFamily: 'Monadi',
// //           ),
// //         ),
// //       ],
// //     ),
// //   ),
// // ),
//
//
//
// ],
// ),
// )
//
// )