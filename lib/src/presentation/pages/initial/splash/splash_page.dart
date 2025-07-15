import 'package:auto_route/auto_route.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymart/firebase_dynamic_link_service.dart';
import 'package:sundaymart/src/core/routes/global_context_service.dart';
import 'package:sundaymart/src/presentation/pages/initial/splash/update_widget.dart';
import 'package:upgrader/upgrader.dart';
import '../../../../../main.dart';
import '../../../../core/routes/app_router.gr.dart';


class SplashPage extends ConsumerStatefulWidget {
  const SplashPage({super.key});

  @override
  ConsumerState<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends ConsumerState<SplashPage> {
  String? selectedLanguage;
  bool onboarding = false;
  bool isNeedUpdate = false;
  bool isLoading = true;



  void triggetNotificaton() {
    AwesomeNotifications().isNotificationAllowed().then(
      (value) {
        if (!value) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );
  }

  void initState() {
    super.initState();
    triggetNotificaton();
    initUpdate();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      selectedLanguage = prefs.getString('selectedLanguage');
      await DynamicLinkHandlerService.initDynamicLinks();
      // ref.read(splashProvider.notifier).fetchSettings(
      //   goMain: () {
      //     context.replaceRoute(const MainRoute());
      //   },
      //   goLogin: () {
      //     context.replaceRoute(const MainRoute());
      //   },
      //   goToSelectLang: () {
      //     context.replaceRoute(SelectLangRoute(isRequired: true));
      //   },
      //   goToOnBoarding: () {
      //     context.replaceRoute(const MainRoute());
      //   },
      //   goToAddAddress: () {
      //     context.replaceRoute(AddAddressRoute(isRequired: true));
      //   },
      // );
      //
      // ref.read(splashProvider.notifier).getTranslations();
      // if (LocalStorage.instance.getUser() != null) {
      //   ref.read(splashProvider.notifier).getProfileDetails();
      // }
      //
      // if (LocalStorage.instance.getSelectedCurrency() == null) {
      //   ref.read(splashProvider.notifier).fetchCurrencies();
      // }
      // Future.delayed(const Duration(seconds:2 ),(){
      //   if (selectedLanguage == 'ar' || selectedLanguage == 'en')
      //
      //   {
      //     context.replaceRoute(const MainRoute());
      //   }
      //   else
      //   {
      //     context.replaceRoute(SelectLangRoute(isRequired: true));
      //   }
      //
      // },);

      Future.delayed(
        const Duration(seconds: 5),
        () {



          if (UserPhone != null) {
          isNeedUpdate
                  ?   showDialog(barrierDismissible: false, context: context, builder: (prefs) => const UpdatePopup())
                  :   context.replaceRoute(const MainRoute());
          } else {
          isNeedUpdate
                  ?                     showDialog(context: context, builder: (prefs) => const UpdatePopup())

                  :   context.replaceRoute(SelectLangRoute(isRequired: true));
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    GlobalContextService.context = context;


    return   Image.network(
   //AppAssets.pngOneSystemTomnaSplash,
      'http://37.34.242.173:9292/TheOneAPI/GeneralPhoto/splash_screen.gif',
      fit: BoxFit.fill,
    );
    
    // Scaffold(appBar: AppBar(elevation: 0,backgroundColor: Colors.white,),
    // body: isLoading ? const Center(child: CircularProgressIndicator()) :
     
    // ,);

      

  
  }
  
  Future<void> initUpdate() async {
    await fetchPlayStoreVersion();
    await checkIsActive();
    if(mounted){
    setState(() {
      isLoading = false; // Set loading to false after initialization
    }); 
    }
  }
  

  Future<void> fetchPlayStoreVersion() async {
    final upgrade = Upgrader();
    await Upgrader.clearSavedSettings(); // Clear cached settings
    await upgrade.initialize();
    final playStoreVersion = upgrade.currentAppStoreVersion;
    final currentVersion = upgrade.versionInfo?.installedVersion;
    print('$currentVersion $playStoreVersion');
    if (playStoreVersion != null && currentVersion != null) {
      if (_isVersionHigher(playStoreVersion, currentVersion.toString())) {
        isNeedUpdate = true;
      } else {
        isNeedUpdate = false;
      }
    } else {
      isNeedUpdate = false;
    }
  }

  Future<void> checkIsActive() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    onboarding = prefs.getBool('onboarding') ?? false;
  }
  bool _isVersionHigher(String playStoreVersion, String currentVersion) {
    final playStoreParts = playStoreVersion.split('.').map(int.parse).toList();
    final currentParts = currentVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < playStoreParts.length; i++) {
      // If currentVersion is shorter, assume trailing zeros
      final current = i < currentParts.length ? currentParts[i] : 0;
      if (playStoreParts[i] > current) {
        return true; // playStoreVersion is higher
      } else if (playStoreParts[i] < current) {
        return false; // currentVersion is higher
      }
    }
    return false; // Versions are the same
  }

}
