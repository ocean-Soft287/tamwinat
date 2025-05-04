import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tawkto/flutter_tawk.dart';


import '../../../../../../main.dart';
class SupportPage extends StatelessWidget {
  dynamic dataUser;
   SupportPage({super.key,required this.dataUser});

  @override
  Widget build(BuildContext context) {

    return
      Scaffold(
        appBar: AppBar(
          title:  Text('خدمه عملاء تموينات', style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w300,
            color:Colors.white,
            fontFamily: 'Monadi',
          ),),
          backgroundColor: const Color(0XFFF7931E),
          elevation: 0,
          iconTheme: const IconThemeData(color:Colors.white,),
        ),
        body: Tawk(
          directChatLink: 'https://tawk.to/chat/661e6dbba0c6737bd12c7e72/1hrjdp9o8',
          visitor: TawkVisitor(
            name: (UserPhoneAll != null) ? '${dataUser['ArabicName']}' : 'guest',
            email: dataUser['Email'] ?? '',
            hash: (UserPhoneAll != null) ? '${dataUser['ArabicName']}_${DateTime.now().millisecondsSinceEpoch}' : 'guest_${DateTime.now().millisecondsSinceEpoch}',
          ),
          onLoad: () {
            print(dataUser['ArabicName']);
            print('Hello Tawk!');
          },
          onLinkTap: (String url) {
            print(url);
          },
          placeholder: const Center(
            child: CircularProgressIndicator(color: Colors.orange, value: 1),
          ),
        ),

    );
  }
}