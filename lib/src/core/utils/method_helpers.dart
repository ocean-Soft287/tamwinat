  import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/drawer/tamwnate_pro/manager/get_subscribtions_riverpod.dart';

double calculateTotalPrice(List<Map<String, dynamic>> items) {
    double total = 0.0;

    for (var item in items) {
      if (item.containsKey('Quantity') && item.containsKey('Price')) {
        num quantity;
        if (item['RequiredQTY'] > 0.0 &&
            item['GiftQTY'] > 0.0 &&
            item['Quantity'] >= item['RequiredQTY']) {
          quantity = item['Quantity'] - item['Y_Gift_Qty'];
        } else {
          quantity = item['Quantity'];
        }
        double price = item['Price'];

        total += quantity * price;
      }
    }

    return total;
  }
  double totalAddition({required List<Map<String, dynamic>> items,required GetSubscriptionProviderApi getSubscriptionDelivery }){
final totalPrice = calculateTotalPrice(items);
return (totalPrice >= 20)
               ? 0.0
               : double.parse(
                   (getSubscriptionDelivery
                               .subscriptionList
                               .isNotEmpty &&
                           getSubscriptionDelivery
                                       .subscriptionList[0]
                                   ['IsSubscribe'] ==
                               true)
                       ? '0.000' // إذا كان هناك اشتراك، رسوم التوصيل ستكون 0
                       :     DeliveryValue ?? '15.0' // إذا لم يكن هناك اشتراك، استخدم قيمة deleveryValue أو 5.000 كقيمة افتراضية
                   );
          

  }