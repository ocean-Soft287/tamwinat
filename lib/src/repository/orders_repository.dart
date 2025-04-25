import '../core/constants/constants.dart';
import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class OrdersRepository {
  Future<ApiResult<void>> cancelOrder({int? orderId});

  Future<ApiResult<SingleOrderResponse>> getOrderDetails({int? orderId});

  Future<ApiResult<OrdersPaginateResponse>> getOrders({
    required OrderStatus status,
    int? page,
  });

  Future<ApiResult<void>> createOrder({
    int? shopId,
    double? total,
    double? deliveryFee,
    String? coupon,
    int? addressId,
    double? totalDiscount,
    int? deliveryTypeId,
    double? tax,
    String? deliveryDate,
    String? deliveryTime,
    int? cartId,
  });
}
