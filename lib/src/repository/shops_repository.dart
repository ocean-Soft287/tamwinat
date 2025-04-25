import '../core/constants/constants.dart';
import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class ShopsRepository {
  Future<ApiResult<void>> createShop({
    required double tax,
    required double deliveryRange,
    required double latitude,
    required double longitude,
    required String phone,
    required String openTime,
    required String closeTime,
    required String name,
    required String description,
    required double minPrice,
    required String address,
    String? logoImage,
    String? backgroundImage,
  });

  Future<ApiResult<ShopsPaginateResponse>> getShopDeliveries(List<int> shopIds);

  Future<ApiResult<ShopsPaginateResponse>> getPickupShops();

  Future<ApiResult<ShopsPaginateResponse>> getNewShops();

  Future<ApiResult<ShopsPaginateResponse>> getWork247Shops();

  Future<ApiResult<ShopsPaginateResponse>> getNearbyShops({
    double? latitude,
    double? longitude,
  });

  Future<ApiResult<ShopsPaginateResponse>> getOpenNowShops();

  Future<ApiResult<ShopGroupsResponse>> getShopGroups({int? page});

  Future<ApiResult<ProductsPaginateResponse>> getBannerProducts(int? bannerId);

  Future<ApiResult<BannersPaginateResponse>> getBannersPaginate(
    BannerType bannerType, {
    int? page,
    int? shopId,
  });

  Future<ApiResult<SingleShopResponse>> getShopDetailsById({int? shopId});

  Future<ApiResult<ShopsPaginateResponse>> getFilteredShops({
    int? page,
    int? groupId,
    ShopDeliveryType? deliveryType,
  });

  Future<ApiResult<ShopsPaginateResponse>> searchShops({String? query});

  Future<ApiResult<ShopsPaginateResponse>> getShopsByIds(
    List<int> shopIds,
  );
}
