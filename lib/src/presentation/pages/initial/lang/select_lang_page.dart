import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../riverpod/gh.dart';
import '../../../components/components.dart';
import '../../../theme/theme.dart';
import '../../auth/login/one_system/login_screen.dart';
import '../../auth/signup/one_system/register_screen.dart';
import '../../main/main_page.dart';

import 'riverpod/provider/select_lang_provider.dart';
import 'widgets/language_item_widget.dart';

class SelectLangPage extends ConsumerStatefulWidget {
  final bool isRequired;



  const SelectLangPage({Key? key, required this.isRequired}) : super(key: key);

  @override
  ConsumerState<SelectLangPage> createState() => _SelectLangPageState();
}

class _SelectLangPageState extends ConsumerState<SelectLangPage> {
  var customPhoneGuestController = TextEditingController();
  var keyFormCheckOutOnSystem = GlobalKey<FormState>();
  bool button= false;
  int selectedIndex = 1;
  bool guestButton=false;
  bool isChecked1=true;
  bool isChecked2=false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        ref
            .read(selectLangProvider.notifier)
            .getLanguages(isRequired: widget.isRequired);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(selectLangProvider);

    final appModel = ref.watch(appModelProvider);
    return AbsorbPointer(
      absorbing: state.isLoading || state.isSaving,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: CommonAppBar(

   backgroundColor: Colors.white,
          title: (appModel.activeLanguage.languageCode=='l')?  (appModel.activeLanguage.languageCode == 'ar')?
          'اختيار للغه ':' Select language':'',
          hasBack: !widget.isRequired,
          onLeadingPressed: ()=> Navigator.pop(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              Image.asset('assets/images/all/logoGuest.png',),
              10.verticalSpace,


              (appModel.activeLanguage.languageCode=='l')?
              Row(
                children: [
                  Expanded(
                    child: LanguageItemWidget(
                      isChecked: isChecked1,
                      text: 'عربى',
                      onPress: () async {
                        setState(() {
                          isChecked1 = true;
                          isChecked2 = false;
                          button = true;
                        });
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        String? selectedLanguage = await prefs.getString('selectedLanguage');

                        ref.read(appModelProvider.notifier).setActiveLanguageCode('ar');
                        await prefs.setString('selectedLanguage', 'ar');
                      },
                    ),
                  ),
                  Expanded(
                    child: LanguageItemWidget(
                      isChecked: isChecked2,
                      text: 'English',
                      onPress: () async {
                        setState(() {
                          isChecked1 = false;
                          isChecked2 = true;
                          button = true;
                        });
                        SharedPreferences prefs = await SharedPreferences.getInstance();


                        ref.read(appModelProvider.notifier).setActiveLanguageCode('en');
                        await prefs.setString('selectedLanguage', 'en');
                      },
                    ),
                  ),
                ],
              )

                  :const SizedBox(height: 2,),




              Padding(
                padding: const EdgeInsets.symmetric(horizontal:70),
                child:
                ((appModel.activeLanguage.languageCode!='l')||button==true)?
                Column(
                  children: [
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>const LoginScreen()),
                        );
                      },
                      child: Container(
                        height: 60.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ), padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        child:
                        Text(
                          (appModel.activeLanguage.languageCode == 'ar')?
                          'تسجيل دخول':'Login',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    10.verticalSpace,

                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) =>RegisterScreen()),
                        );
                      },
                      child: Container(
                        height: 60.h,

                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          (appModel.activeLanguage.languageCode == 'ar')?
                          'تسجيل حساب جديد':'Register a new account',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                    20.verticalSpace,
                    Text( (appModel.activeLanguage.languageCode == 'ar')?
                    'او':'OR',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        color: Colors.orange,
                      ),

                    ),
                    20.verticalSpace,
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>  const MainPage()),
                        );
                      },
                      child: Container(
                        height: 60.h,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state.isSaving
                            ? SizedBox(
                          height: 20.r,
                          width: 20.r,
                          child: CircularProgressIndicator(
                            strokeWidth: 3.r,
                            color: AppColors.white,
                          ),
                        )
                            : Text(
                          (appModel.activeLanguage.languageCode == 'ar')?

                          "متابعه كضيف":'Continue as a guest',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            fontSize: 14.sp,
                            color: Colors.orange,
                          ),
                        ),
                      ),
                    ),
                50.verticalSpace,


                  ],
                ):const Text(''),
              ),


              Column(
                children: [
                  Text(
                    (appModel.activeLanguage.languageCode == 'ar')?
                    'جميع الحقوق محفوظة لشركة تموينات ®':
                    'All rights reserved to Tmween ®',
                    textAlign: TextAlign.center, // يجعل النص في المنتصف
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: const Color(0xff1c6da5),
                    ),
                  ) ,
                  Text(
                    (appModel.activeLanguage.languageCode == 'ar')?
                    'علامة تجارية مسجلة تحت رقم 005471/2024':
                    'Registered Trademark under No. 005471/2024',
                    textAlign: TextAlign.center, // يجعل النص في المنتصف
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: const Color(0xff1c6da5),
                    ),
                  ),
                  Image.asset('assets/images/all/qrCode.png',width: 100,height: 100,)

                ],
              )





            ],
          ),
        ),


      ),
    );
  }
}
