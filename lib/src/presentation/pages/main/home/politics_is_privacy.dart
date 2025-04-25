// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// import '../../../../core/constants/app_assets.dart';
// import '../../../../riverpod/gh.dart';
// import '../../../theme/app_colors.dart';
// import '../favorite/controler/favorite_riverpod.dart';
//
//
// class PoliticsIsPrivacy extends ConsumerStatefulWidget {
//   const PoliticsIsPrivacy({Key? key}) : super(key: key);
//
//   @override
//   _PoliticsIsPrivacyState createState() => _PoliticsIsPrivacyState();
// }
//
// class _PoliticsIsPrivacyState extends ConsumerState<PoliticsIsPrivacy> {
//
//   bool isLoading = true;
//   List<bool>isSecondContainerVisibleList = List.generate(100, (index) => false);
//   List<bool>itemLoveStates=List.generate(100, (index) => false);
//   late   List<Map<String, dynamic>>Image;
//   @override
//   void initState() {
//     print('ssssssss');
//     super.initState();
//     ref
//         .read(getPoliticsIsPrivacyApiProvider.notifier).getPoliticsIsPrivacyImage();
//
//     Image= ref.read(getPoliticsIsPrivacyApiProvider.notifier).politicsIsPrivacyList;
//     Future.delayed(Duration(milliseconds: 200), () {
//       setState(() {
//         isLoading = false;
//       });
//     });
//   }
//   @override
//
//   Widget build(BuildContext context) {
//     final appModel = ref.watch(appModelProvider);
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: (){
//             Navigator.pop(context);
//           },
//           icon: Icon(Icons.arrow_forward_ios,color: Colors.black),
//         ),
//         elevation: 0.0,
//
//         title:
//         Text(
//           (appModel.activeLanguage.languageCode == 'ar')?
//           'السياسه والخصوصيه':'Policy and Privacy',
//
//           style:
//           TextStyle(
//             fontWeight: FontWeight.w500,
//             fontSize: 14.sp,
//             fontFamily: 'Monadi',
//             color: AppColors.black,
//           ),
//
//
//         ),
//
//         centerTitle: true,
//
//
//
//       ),
//       body:
//
//
//       Consumer(
//         builder: (context,ref,child)
//         {
//           final getDataCategoryByParentId = ref.watch(getPoliticsIsPrivacyApiProvider);
//           return ListView.builder(
//               itemCount: getDataCategoryByParentId.politicsIsPrivacyList.length,
//               itemBuilder: (context, index) {
//                 return
//
//                   Text('${getDataCategoryByParentId
//                       .politicsIsPrivacyList[index]["ImagePath"]}');
//               }
//
//           );
//         },
//       ),
//
//
//
//
//     );
//   }
// }
//
//
//
//
//
//
//
//


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../riverpod/gh.dart';
import '../../../theme/app_colors.dart';
import '../drawer/favorite/controler/favorite_riverpod.dart';


class PoliticsIsPrivacy extends ConsumerStatefulWidget {
  @override
  _PoliticsIsPrivacyState createState() => _PoliticsIsPrivacyState();
}

class _PoliticsIsPrivacyState extends ConsumerState<PoliticsIsPrivacy> {

    void initState() {
    print('ssssssss');
    super.initState();
    ref
        .read(getPoliticsIsPrivacyApiProvider.notifier).getPoliticsIsPrivacyImage();


  }
  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    return
      Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_forward_ios,color: Colors.black),
        ),
        elevation: 0.0,

        title:
        Text(
          (appModel.activeLanguage.languageCode == 'ar')?
          'السياسه والخصوصيه':'Policy and Privacy',

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
          final getPoliticsIsPrivacy = ref.watch(getPoliticsIsPrivacyApiProvider);
          return ListView.builder(
              itemCount: getPoliticsIsPrivacy.politicsIsPrivacyList.length,
              itemBuilder: (context, index) {
                final item =getPoliticsIsPrivacy.politicsIsPrivacyList[index];
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
