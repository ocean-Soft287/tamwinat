class AppConstants {
  AppConstants._();

  /// shared preferences keys
  static const String keyLangSelected = 'keyLangSelected';
  static const String keyToken = 'keyToken';
  static const String keyLanguageData = 'keyLanguageData';
  static const String keyGlobalSettings = 'keyGlobalSettings';
  static const String keyTranslations = 'keyTranslations';
  static const String keyAppThemeMode = 'keyAppThemeMode';
  static const String keyOnBoarded = 'keyOnBoarded';
  static const String keyLangLtr = 'keyLangLtr';
  static const String keyAddressSelected = 'keyAddressSelected';
  static const String keyIsGuest = 'keyIsGuest';
  static const String keyLocalAddresses = 'keyLocalAddresses';
  static const String keyUser = 'keyUser';
  static const String keySelectedCurrency = 'keySelectedCurrency';
  static const String keyLikedProducts = 'keyLikedProducts';
  static const String keyViewedProducts = 'keyViewedProducts';
  static const String keySavedStores = 'keySavedStores';
  static const String keyWallet = 'keyWallet';

  /// hero tags
  static const String tagHeroBannerImage = 'tagHeroBannerImage';
  static const String tagHeroMarketTitle = 'tagHeroMarketTitle';
  static const String tagHeroMarketLogo = 'tagHeroMarketLogo';
  static const String tagHeroRecipeImage = 'tagHeroRecipeImage';

  /// api urls
  static const String baseUrl = 'https://api.sundaymart.net';
  static const String imageBaseUrl = '$baseUrl/storage/images';
  static const String adminPageUrl = 'https://admin.sundaymart.net';
  static const String webUrl = 'https://sundaymart.net';
  static const String privacyPolicyUrl =
      'https://sundaymart.net/privacy-policy';

  static const String apilink="";
  // static const String demoWebUrl = 'https://sundaymart.netlify.app';

  /// location
  static const double demoLatitude = 41.304223;
  static const double demoLongitude = 69.2348277;
  static const double pinLoadingMin = 0.116666667;
  static const double pinLoadingMax = 0.611111111;

  static const String googleMapApiKey =
      "AIzaSyCoAZYMoMKh_-94ST2SKMDG8hGvdzDJxh0";
}

enum MessageOwner { you, partner }

enum BannerType { banner, look }

enum UploadType {
  extras,
  brands,
  categories,
  shopsLogo,
  shopsBack,
  products,
  reviews,
  users,
}

enum ShopDeliveryType { delivery, pickup }

enum OrderStatus {
  newOrders,
  accepted,
  ready,
  onAWay,
  delivered,
  canceled,
}

enum OrderItemWidgetStatus { completed, current, notYet }

enum ShopStatus { notRequested, newShop, edited, approved, rejected }
