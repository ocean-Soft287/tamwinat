import 'package:auto_route/auto_route.dart';

import '../../presentation/pages/main/home/widget/saved_addresses.dart';
import '../../presentation/pages/pages.dart';

@CupertinoAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: [
    CupertinoRoute(path: '/', page: SplashPage),
    CupertinoRoute(path: '/select-lang', page: SelectLangPage),

    CupertinoRoute(
      path: '/main',
      page: MainPage,
      children: [
        CustomRoute(
          path: 'delivery',
          page: DeliveryPage,
          transitionsBuilder: TransitionsBuilders.slideRight,
        ),
        CustomRoute(
          path: 'Address',
          page: SavedAddresses,
          transitionsBuilder: TransitionsBuilders.slideRight,
        ),
        // CustomRoute(
        //   path: 'pickup',
        //   page: PickupPage,
        //   transitionsBuilder: TransitionsBuilders.slideLeft,
        // ),
      ],
    ),

    // CupertinoRoute(path: '/banner-details', page: BannerDetailsPage),

    CupertinoRoute(path: '/market-info', page: MarketInfoPage),

    // CupertinoRoute(path: '/brands', page: BrandsPage),
    // CupertinoRoute(path: '/brand-products', page: BrandProductsPage),
    // CupertinoRoute(path: '/recipe-categories', page: RecipeCategoriesPage),
    // CupertinoRoute(path: '/recipes', page: RecipesPage),
    // CupertinoRoute(path: '/recipes-details', page: RecipeDetailsPage),

    // CupertinoRoute(path: '/recipe-category', page: RecipeCategoryPage),
    // CupertinoRoute(path: '/more-recipe-category', page: MoreRecipeCategoryPage),

    CupertinoRoute(path: '/notifications', page: NotificationsPage),
    //  CupertinoRoute(path: '/detailProductDeepLink', page: RegisterScreen),
  ],
)
class $AppRouter {}
