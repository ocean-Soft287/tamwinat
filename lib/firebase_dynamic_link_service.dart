import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

import 'package:flutter/material.dart';

import 'package:sundaymart/src/core/routes/global_context_service.dart';

import 'package:sundaymart/src/presentation/pages/main/shop/details/banner_details/banner_details_page.dart';

class DynamicLinkHandlerService {
  static Future<String> createDynamicLink(
      {int? productId,
      String? categoryId,
      required String? name,
      String? imageUrl,
      String? description}) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://supplies.page.link',
      link: Uri.parse(
          'https://supplies.page.link/product?productId=$productId&categoryId=$categoryId'),
      androidParameters: AndroidParameters(

        packageName: 'com.tmwenat',
      ),
      iosParameters:
          IOSParameters(bundleId: 'com.apptamwe.app', appStoreId: "6479165814"),
      socialMetaTagParameters: SocialMetaTagParameters(
        description: description ?? name,
        imageUrl: Uri.parse(imageUrl ?? ""),
        title: name.toString(),
      ),
    );

    // final ShortDynamicLink dynamicUrl = await parameters.buildShortLink();

    print(parameters.link.toString());
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      parameters,
    );
    //  return dynamicLink.shortUrl.toString();
    return dynamicLink.shortUrl.toString();
  }

  static Future<void> initDynamicLinks() async {
    // Listen for Dynamic Links when the app is in the foreground and Terminated State
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      print("*" * 50);
      print(dynamicLinkData.link);
      print("*" * 50);
      _handleDynamicLink(dynamicLinkData);
    }).onError((error) {
      // Handle errors
      print("*" * 50);
      print(error);
      print("*" * 50);
    });

    // Retrieve the initial Dynamic Link when the app is launched
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      _handleDynamicLink(initialLink);
    }
  }

  static void _handleDynamicLink(
    PendingDynamicLinkData? data,
  ) {
    final Uri? deepLink = data?.link;
    print("*" * 50);
    print("Deep Link : $deepLink");
    print("Path : ${deepLink!.path}");
    print("*" * 50);
    // Navigator
    //     .pu(MaterialPageRoute(builder: ((context) => RegisterScreen())));
    if (deepLink != null) {
      final productId = deepLink.queryParameters['productId'];
      final categoryId = deepLink.queryParameters['categoryId'];
      if (productId != null) {
        // Handle the product detail with the extracted ID
        print('Product ID: $productId');
        print('Category ID: $categoryId');
        WidgetsBinding.instance!.addPostFrameCallback((_) {
          // // AppRouter().push(PageRouteInfo(_name, path: ))
          // Navigator.of(GlobalContextService.context!)
          //     .push(MaterialPageRoute(builder: (context) => MainPage()));
          Navigator.of(GlobalContextService.context!).push(MaterialPageRoute(
              builder: (context) => BannerDetailsPage(
                    productId: int.parse(productId),
                    name: "",
                    CategoryId: categoryId, // to get the simmlar product
                  )));
        });
      }
    }
  }
}
