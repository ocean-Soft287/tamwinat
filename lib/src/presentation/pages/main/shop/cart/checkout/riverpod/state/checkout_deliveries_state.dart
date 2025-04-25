import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../../../../../models/models.dart';

part 'checkout_deliveries_state.freezed.dart';

@freezed
class CheckoutDeliveriesState with _$CheckoutDeliveriesState {
  const factory CheckoutDeliveriesState({
    @Default(false) bool isLoading,
    @Default(false) bool isPickup,
    @Default([]) List<ShopDelivery> shopDeliveries,
    @Default(0) int selectedDeliveryTypeIndex,
    @Default(0) int selectedDeliveryAddressIndex,
    DateTime? deliveryDate,
    DateTime? deliveryTime,
    ShopData? shopData,
    DateTime? pickupDate,
  }) = _CheckoutDeliveriesState;

  const CheckoutDeliveriesState._();
}
