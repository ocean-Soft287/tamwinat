import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymart/main.dart';
import '../../../../core/routes/app_router.gr.dart';
import '../../../../riverpod/gh.dart';
import '../../../components/components.dart';
import '../../auth/login/one_system/login_screen.dart';
import '../../auth/signup/one_system/register_screen.dart';
import '../../main/main_page.dart';

import 'riverpod/provider/select_lang_provider.dart';
import 'widgets/language_item_widget.dart';

class SelectLangPage extends ConsumerStatefulWidget {
  final bool isRequired;

  const SelectLangPage({Key? key, this.isRequired = true}) : super(key: key);

  @override
  ConsumerState<SelectLangPage> createState() => _SelectLangPageState();
}

class _SelectLangPageState extends ConsumerState<SelectLangPage> {
  var customPhoneGuestController = TextEditingController();
  var keyFormCheckOutOnSystem = GlobalKey<FormState>();
  bool button = false;
  int selectedIndex = 1;
  bool guestButton = false;
  bool isChecked1 = true;
  bool isChecked2 = false;

  Future<void> _showGuestLoadingDialog(BuildContext context, bool isArabic) {
    return showDialog<void>(
      context: context,
      useRootNavigator: true,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        content: Row(
          children: [
            SizedBox(
              height: 22.r,
              width: 22.r,
              child: CircularProgressIndicator(
                strokeWidth: 3.r,
                color: Colors.orange,
              ),
            ),
            12.horizontalSpace,
            Expanded(
              child: Text(
                isArabic ? 'يرجى الانتظار...' : 'Please wait...',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

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
      absorbing: state.isSaving || guestButton,
      child: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        appBar: CommonAppBar(
          backgroundColor: Colors.white,
          title: (appModel.activeLanguage.languageCode == 'l')
              ? (appModel.activeLanguage.languageCode == 'ar')
                  ? 'اختيار للغه '
                  : ' Select language'
              : '',
          hasBack: !widget.isRequired,
          onLeadingPressed: () => Navigator.pop(context),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Image.asset(
                'assets/images/all/logoGuest.png',
              ),
              10.verticalSpace,
              (appModel.activeLanguage.languageCode == 'l')
                  ? Row(
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
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              // String? selectedLanguage = await prefs.getString('selectedLanguage');

                              ref
                                  .read(appModelProvider.notifier)
                                  .setActiveLanguageCode('ar');
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
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              ref
                                  .read(appModelProvider.notifier)
                                  .setActiveLanguageCode('en');
                              await prefs.setString('selectedLanguage', 'en');
                            },
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(
                      height: 2,
                    ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 70),
                child: ((appModel.activeLanguage.languageCode != 'l') ||
                        button == true)
                    ? Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()),
                              );
                            },
                            child: Container(
                              height: 60.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 8.0),
                              child: Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? 'تسجيل دخول'
                                    : 'Login',
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
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => RegisterScreen()),
                              );
                            },
                            child: Container(
                              height: 60.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? 'تسجيل حساب جديد'
                                    : 'Register a new account',
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                          ),
                          20.verticalSpace,
                          Text(
                            (appModel.activeLanguage.languageCode == 'ar')
                                ? 'او'
                                : 'OR',
                            style: GoogleFonts.inter(
                              fontWeight: FontWeight.bold,
                              fontSize: 14.sp,
                              color: Colors.orange,
                            ),
                          ),
                          20.verticalSpace,
                          InkWell(
                            onTap: guestButton
                                ? null
                                : () async {
                                    if (guestButton) return;
                                    setState(() {
                                      guestButton = true;
                                    });

                                    final rootNavigator =
                                        Navigator.of(context,
                                            rootNavigator: true);
                                    final isArabic =
                                        appModel.activeLanguage.languageCode ==
                                            'ar';

                                    try {
                                        final prefs =
                                          await SharedPreferences.getInstance();
                                        await prefs.setBool('IsGuestMode', true);
                                      isGuestMode = true;
                                      UserPhone = null;

                                      _showGuestLoadingDialog(context, isArabic);

                                      await Future.delayed(
                                          const Duration(seconds: 1));

                                      if (rootNavigator.canPop()) {
                                        await rootNavigator.maybePop();
                                      }

                                      if (!mounted) return;
                                      await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const MainPage(
                                            showGuestDialog: true,
                                          ),
                                        ),
                                      );
                                    } finally {
                                      if (rootNavigator.canPop()) {
                                        await rootNavigator.maybePop();
                                      }

                                      if (mounted) {
                                        setState(() {
                                          guestButton = false;
                                        });
                                      }
                                    }
                                  },
                            child: Container(
                              height: 60.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: guestButton
                                  ? SizedBox(
                                      height: 20.r,
                                      width: 20.r,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 3.r,
                                        color: Colors.orange,
                                      ),
                                    )
                                  : Text(
                                      (appModel.activeLanguage.languageCode ==
                                              'ar')
                                          ? "متابعه كضيف"
                                          : 'Continue as a guest',
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
                      )
                    : const Text(''),
              ),
              Column(
                children: [
                  Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'جميع الحقوق محفوظة لشركة تموينات ®'
                        : 'All rights reserved to Tmween ®',
                    textAlign: TextAlign.center, // يجعل النص في المنتصف
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: const Color(0xff1c6da5),
                    ),
                  ),
                  Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? 'علامة تجارية مسجلة تحت رقم 005471/2024'
                        : 'Registered Trademark under No. 005471/2024',
                    textAlign: TextAlign.center, // يجعل النص في المنتصف
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp,
                      color: const Color(0xff1c6da5),
                    ),
                  ),
                  Image.asset(
                    'assets/images/all/qrCode.png',
                    width: 100,
                    height: 100,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

Future<void> guestOfferPromptDialog(
    BuildContext context, final appModel) async {
  showGeneralDialog(
    context: context,
    barrierDismissible: false,
    barrierLabel: (appModel.activeLanguage.languageCode == 'ar')
        ? "لا تفوّت الفرصة 🎁"
        : "guest_offer",
    barrierColor: Colors.black.withValues(alpha: 0.4),
    transitionDuration: const Duration(milliseconds: 350),
    pageBuilder: (_, __, ___) {
      final size = MediaQuery.of(context).size;

      return WillPopScope(
        onWillPop: () async {
          return false; // 👈 يمنع زر الرجوع تمامًا
        },
        child: Center(
          child: Material(
            color: Colors.transparent,
            child: Container(
              width: size.width * 0.9,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  )
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.blue.withValues(alpha: 0.12),
                    ),
                    child: Icon(
                      Icons.card_giftcard,
                      color: Colors.blue,
                      size: 38.sp,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? "لا تفوّت الفرصة 🎁"
                        : "Don’t miss the chance 🎁",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alexandria(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    (appModel.activeLanguage.languageCode == 'ar')
                        ? "قم بتسجيل دخولك للحصول على مزايا الكاش باك والنقاط والعديد من المزايا الحصرية"
                        : "Sign in to get cashback benefits, points, and many exclusive advantages",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.alexandria(
                      fontSize: 13.sp,
                      height: 1.6,
                      color: Colors.black87,
                    ),
                  ),

                  const SizedBox(height: 26),

                  Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.grey[600],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          child: Text(
                            appModel.activeLanguage.languageCode == 'ar'
                                ? 'تخطي'
                                : 'Skip',
                            style: GoogleFonts.alexandria(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            context.replaceRoute(
                                SelectLangRoute(isRequired: true));
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            elevation: 1.5,
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: Text(
                            appModel.activeLanguage.languageCode == 'ar'
                                ? 'تسجيل دخول'
                                : 'Login',
                            style: GoogleFonts.alexandria(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    },
    transitionBuilder: (_, animation, __, child) {
      return FadeTransition(
        opacity: animation,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.85, end: 1.0).animate(CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutBack,
          )),
          child: child,
        ),
      );
    },
  );
}
