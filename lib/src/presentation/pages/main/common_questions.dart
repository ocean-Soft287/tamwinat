import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../riverpod/gh.dart';
import '../../theme/app_colors.dart';

class CommonQuestion extends ConsumerStatefulWidget {
  @override
  _CommonQuestionState createState() => _CommonQuestionState();
}

class _CommonQuestionState extends ConsumerState<CommonQuestion> {
@override

Widget build(BuildContext context) {
  final appModel = ref.watch(appModelProvider);
  List<dynamic>Quation=[

    {
      'q1':(appModel.activeLanguage.languageCode == 'ar')?'ماهي ساعات العمل':'What are the working hours?',
      'q1de':(appModel.activeLanguage.languageCode == 'ar')?'ساعات العمل تبدأ من 9 صباحا لغاية 9 مساءا طوال ايام الاسبوع':'Working hours start from 9 am to 9 pm, all days of the week'
    },
    {
      'q1':(appModel.activeLanguage.languageCode == 'ar')?'ماهي المناطق التي تتوفر بها خدمة التوصيل داخل دولة الكويت؟':'What are the areas where delivery service is available within the State of Kuwait?',
      'q1de':(appModel.activeLanguage.languageCode == 'ar')?'بالوقت الحالي جميع مناطق محافظات العاصمه والقروانية والجهراء':'At the present time, all areas of the capital, Al-Qarawaniyah, and Al-Jahra governorates',
    },

    {
      'q1':(appModel.activeLanguage.languageCode == 'ar')?'ماهي اقل قيمة لطلب ؟':'What is the minimum order value?',
      'q1de':(appModel.activeLanguage.languageCode == 'ar')?'8 د.ك':'8 K.D'
    },
    {
      'q1':(appModel.activeLanguage.languageCode == 'ar')?'هل يمكنني استلام الطلب بنفسي ؟':'Can I collect the order myself?',
      'q1de':(appModel.activeLanguage.languageCode == 'ar')?'نعتذر منكم حاليا نعمل على خدمة توصيل الطلب فقط':'We apologize, we are currently working on delivery service only',
    },
    {
      'q1':(appModel.activeLanguage.languageCode == 'ar')?'متى يتم التوصيل ؟':'When is the delivery done?',
      'q1de':(appModel.activeLanguage.languageCode == 'ar')?'بعد عملة اتمام الدفع سيصلك الطلب خلال ساعتين':'After completing the payment, you will receive the order within two hours',
    },
    {
      'q1':(appModel.activeLanguage.languageCode == 'ar')?'هل يوجد رسوم توصيل للطلب ؟':'Is there a delivery fee for the order?',
      'q1de':(appModel.activeLanguage.languageCode == 'ar')?'نعم يوجد رسوم توصيل بقيمه 1د.ك':'Yes, there is a delivery fee of 1 KD.',
    },
    {
      'q1':(appModel.activeLanguage.languageCode == 'ar')?'ماهي طرق الدفع المتاحة ؟':'What payment methods are available ?',
      'q1de':(appModel.activeLanguage.languageCode == 'ar')?'- كي نت اونلاين- الدفع نقدا عند الاستلام':'- KNET Online - Payment in cash upon receipt',
    },

    {
      'q1':(appModel.activeLanguage.languageCode == 'ar')?' وصلني الطلب ناقص ؟':'I received an incomplete order?',
      'q1de':(appModel.activeLanguage.languageCode == 'ar')?'نحن نعمل بفريق عمل ذوة خبرة عاليه اذالك نحرص بكل جهد على عدم حصول ذالك . وفي الحالات النادرة جدا يرجى التوصل مع خدمة العملاء وستم استلام وحل الخلل فوراً':'We work with a highly experienced team, so we make every effort to prevent this from happening. In very rare cases, please contact customer service and the defect will be received and resolved immediately',
    },
    {
      'q1':(appModel.activeLanguage.languageCode == 'ar')?'هل يمكن تغيير العنوان بعد اتمام الدفع ؟':'Can I change the address after completing the payment?',
      'q1de':(appModel.activeLanguage.languageCode == 'ar')?' نعم. على ان يكون العنوان الجديد ضمن المنطقه او المناطق المجاورة لها':' Yes. The new address must be within the area or its neighboring areas.'
    },

  ];
  return Scaffold(
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
          'الاسئله الشائعه':'Common Question',

          style: TextStyle(
              color: Colors.black
          ),

        ),

        centerTitle: true,



      ),

    body:Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:   ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder:(context,index)=>ListTile(

              trailing: Icon(Icons.arrow_forward_ios,color: Colors.black),

              title: Text(

                '${Quation[index]["q1"]}',

                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  fontFamily: 'Monadi',
                  color: AppColors.black,
                ),

              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) =>QuestionDetailsPage(questionText:Quation[index]["q1de"] ,)),
                );

              },
            ),
            separatorBuilder: (context,index)=>SizedBox(width: 10,),
            itemCount: Quation.length,

        ),


      ),
    )

  );
}
}


class QuestionDetailsPage extends StatelessWidget {
  final String questionText;

  QuestionDetailsPage({required this.questionText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              questionText,
              style: TextStyle(fontSize: 16),
            ),

          ],
        ),
      ),
    );
  }
}