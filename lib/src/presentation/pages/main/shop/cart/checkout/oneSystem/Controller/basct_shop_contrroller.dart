import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sundaymart/main.dart';
import 'package:sundaymart/src/presentation/pages/main/pickup/One%20System/riverpodOneSystem/notifierOneSystem.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/model/address_model.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/model/price_offer_post_model.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/details/market_info/riverpod/market_Info_oneSystem/market_info_notifier.dart';
import '../../../../../pickup/One System/DioOneSystem.dart';


class ListItemOrder extends ChangeNotifier {
  final Ref ref;
  ListItemOrder(this.ref) ;
    

  List<Map<String, dynamic>> basctList = [];


  List<Map<String, dynamic>> get orderList =>
      List.unmodifiable(basctList);



void addItem(Map<String, dynamic> newItem) {
  // Step 1: Remove any other type of the same product
  basctList.removeWhere((item) => item['ItemID'] == newItem['ItemID']);
  // Fluttertoast.showToast(msg: 'برجاء اختياره وحده واحده فقط لكل صنف',);
  // Step 2: Try to find and update existing item with same barcode
  bool found = false;
  for (var item in basctList) {
    if (item['BarCode'] == newItem['BarCode']) {
      item['Quantity'] = newItem['Quantity'];
      item['Y_Gift_Qty'] = newItem['Y_Gift_Qty'];
      getSum();
      found = true;
      if (item['Quantity'] <= 0) {
        basctList.remove(item);
      }
      break;
    }
  
  
  }

  // Step 3: If not found, add new item
  if (!found) {
    getSum();
    basctList.add(newItem);
  }
  clearCartData();
  saveCartData(basctList);
  notifyListeners();
}



void decreaseQuantity(dynamic targetItemID) {
    for (var item in basctList) {
      if (item['BarCode'] == targetItemID && item['Quantity'] > 0) {
        item['Quantity'] -= 1;
        // if ((item['Quantity'] - item['GiftQTY'] * item['Y_Gift_Qty']) % item['RequiredQTY'] == 0) {
        //   continue;
        // }
           if(item['GiftQTY']>0&&item['RequiredQTY']>0)
             {
               if ((item['Quantity'] - item['GiftQTY'] * item['Y_Gift_Qty'] + 1) % item['RequiredQTY'] == 0) {
                // item['Quantity'] -= item['GiftQTY'];
                 item['Quantity'] -= 1;
                 item['Y_Gift_Qty']--;
               }
             }



        if (item['Quantity'] <= 0) {
          basctList.remove(item);
        }
        break;

      }
    }
    clearCartData();
    saveCartData(basctList);
    notifyListeners();
    print('decreaseQuantit');
    print(basctList);
  }


  void deleteItem(int index) {
    if (index >= 0 && index < basctList.length) {

      dynamic itemIDToDelete = basctList[index]['BarCode'];
      basctList.removeWhere((item) => item['BarCode'] == itemIDToDelete);


     clearCartData();
     saveCartData(basctList);  notifyListeners();
      print('allllllllllllllli5050505050505050505050');
      print(basctList);
      print('allllllllllllllli5050505050505050505050');
      print( basctList);
    }
  }



Future<void> getPriceOffer({required PriceOfferPostModel priceOfferPostModel}) async {
   const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
    const publicKey = 'e0c9de1b2de26fe2';
  try {

    String encryptedData = encryptData(
      priceOfferPostModel.toJson(),
      privateKey,
      publicKey,
    );
    debugPrint( priceOfferPostModel.toJson().toString() );

    String jsonData = jsonEncode(encryptedData);

final res =   await DioHelperOneSystem.postData(url: 'api/SalesInvoice/PriceOffer',data:jsonData);
  final decryptedText2 = decrypt(res.data, privateKey, publicKey);
      debugPrint(decryptedText2);
  } on DioException catch (e) {
    
    debugPrint( decrypt( e.response?.data['Message'], privateKey, publicKey));
  }
}

num getQuantity( {required dynamic itemID}) {
    for (var item in basctList) {
      if (item['BarCode'] == itemID) {

        return item['Quantity'] ?? 1;

      }
    }
    return 0;
  }
num getYGiftQty( {required dynamic itemID}) {
    for (var item in basctList) {
      if (item['BarCode'] == itemID) {

        return item['Y_Gift_Qty'] ?? 1;

      }
    }
    return 0;
  }


  void clearItems() {
    basctList.clear();
        clearCartData();

    notifyListeners();
  }
  int counterSum=0;
  void getSum()
  {counterSum++;
  notifyListeners();
  }


  num calculateTotalQuantity() {
    num totalQuantity = 0;

    for (var item in basctList) { //item["StockQuantity"]
      num quantity = item["Quantity"];
      totalQuantity += quantity;
    }

    return totalQuantity;
  }

  double calculateTotalPrice() {
    double totalPrice = 0.0;

    for (var item in basctList) {
      num quantity;
      if(item['RequiredQTY']>0.0&&item['GiftQTY']>0.0&&item['Quantity']>=item['RequiredQTY'])
      {
        quantity = item['Quantity']-item['Y_Gift_Qty'];
      }
      else
      {
        quantity = item['Quantity'];
      }
      double price = item["Price"];
      totalPrice += quantity * price;
    }

    return totalPrice;
  }

// Save cart data
Future<void> saveCartData(List<Map<String, dynamic>> cartItems) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> cartJsonList =
      cartItems.map((item) => json.encode(item)).toList();
  await prefs.setStringList('cart_itemslist', cartJsonList);
notifyListeners();
}

// Load cart data
Future<void> loadCartData() async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? cartJsonList = prefs.getStringList('cart_itemslist');
  if (cartJsonList == null || cartJsonList.isEmpty) {
    return ;
  }
 basctList =  cartJsonList.map((str) => json.decode(str)).cast<Map<String, dynamic>>().toList(); 
 checkQuntityOFItem();
 notifyListeners();
}
Future<void>checkQuntityOFItem() async {
   for (int index= 0; index < basctList.length; index++) {
 final getcategorybyId  =  ref.read(getDataCategoryByIdFromApiProvider);
 getcategorybyId.categoryDateByIdList.clear();
 final item  = basctList[index];
final productId =  item  ["ItemID"];

   DioHelperOneSystem.getData(
            url:
                'api/Product/GetProductById?ProductId=$productId&CustomerPhone=$UserPhone')
        .then((value) {
     
      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
       debugPrint(decryptedText);
     

     final categoryDateByIdList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)

          .toList();

  if (categoryDateByIdList[0]["Product_Images"][0]['StockQty'] < 1.0) {
     basctList.remove(item);
   }else {
    debugPrint("YES ${categoryDateByIdList[0]["Product_Images"][0]['StockQty']}");
   }
    notifyListeners();

    }).catchError((error) {
    });
 
  // getcategorybyId.getCategoryById(productId:  
  // item  ["ItemID"]);
  // debugPrint(")))))))))))))))))))))");
  // debugPrint(item["ItemID"].toString());
 
 
 }

}




// Clear cart data
Future<void> clearCartData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('cart_itemslist');
}



}

final orderProviderList = ChangeNotifierProvider<ListItemOrder>((ref) {
  return ListItemOrder(ref);
});






























class ListItemOrderImage extends ChangeNotifier {
  final Ref ref;
  ListItemOrderImage(this. ref);
  List<Map<String, dynamic>> ListOrderImage = [];

  List<Map<String, dynamic>> get orderListImage =>
      List.unmodifiable(ListOrderImage);

  void addItem(Map<String, dynamic> newItem) {
    ListOrderImage.removeWhere((item) => item['ItemID'] == newItem['ItemID']);
    bool found = false;
    for (var item in ListOrderImage) {
      if (item['BarCode'] == newItem['BarCode']) {

        item['Quantity'] = newItem['Quantity'];
        item['Y_Gift_Qty']=newItem['Y_Gift_Qty'];
        found = true;
        if (item['Quantity'] <= 0) {
          ListOrderImage.remove(item);
        }
        break;
      }
    }


    if (!found) {
      ListOrderImage.add(newItem);
    }

    print('Aliiiiiii202020202020202');
    print(ListOrderImage);
    print('Aliiiiiii202020202020202ssssssssssssssssssssssssss');
    clearCartData();
    saveCartData(ListOrderImage);
    notifyListeners();
  
  
  }

  void deleteItem(int index) {
    if (index >= 0 && index < ListOrderImage.length) {

      dynamic itemIDToDelete = ListOrderImage[index]['BarCode'];
      ListOrderImage.removeWhere((item) => item['BarCode'] == itemIDToDelete);

      clearCartData();
      saveCartData(ListOrderImage);
      notifyListeners();
      print('allllllllllllllli');
      print(ListOrderImage);
      print('aliiiiiiiiiiiiiiiiiiii');
      print( ListOrderImage);
    }
  }


  void clearItems() {
    ListOrderImage.clear();
     clearCartData();
    notifyListeners();
  }


// Save cart data
Future<void> saveCartData(List<Map<String, dynamic>> cartItems) async {
  final prefs = await SharedPreferences.getInstance();
       List<String> cartJsonList =
      cartItems.map((item) => json.encode(item)).toList();
await prefs.setStringList('cart_items', cartJsonList);

notifyListeners();
}

// Load cart data
Future<void> loadCartData() async {
  final prefs = await SharedPreferences.getInstance();
  List<String>? cartJsonList = prefs.getStringList('cart_items');
  if (cartJsonList != null ) {
    
 ListOrderImage =  cartJsonList.map((str) => json.decode(str)).cast<Map<String, dynamic>>().toList(); 
 
  }
 checkQuntityOFItem();

 notifyListeners();

}
Future<void>checkQuntityOFItem() async {
   for (int index= 0; index < ListOrderImage.length; index++) {
 final getcategorybyId  =  ref.read(getDataCategoryByIdFromApiProvider);
 getcategorybyId.categoryDateByIdList.clear();
 final item  = orderListImage[index];
final productId =  item  ["ItemID"];

   DioHelperOneSystem.getData(
            url:
                'api/Product/GetProductById?ProductId=$productId&CustomerPhone=$UserPhone')
        .then((value) {
     
      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
       debugPrint(decryptedText);
     

     final categoryDateByIdList = (json.decode(decryptedText) as List<dynamic>)
          .map((item) => item as Map<String, dynamic>)

          .toList();

  if (categoryDateByIdList[0]["Product_Images"][0]['StockQty'] < 1.0) {
     ListOrderImage.remove(item);
   }else {
    debugPrint("YES ${categoryDateByIdList[0]["Product_Images"][0]['StockQty']}");
   }
    notifyListeners();

    }).catchError((error) {
    });
 
  // getcategorybyId.getCategoryById(productId:  
  // item  ["ItemID"]);
  // debugPrint(")))))))))))))))))))))");
  // debugPrint(item["ItemID"].toString());
 
 
 }

}

// Clear cart data
Future<void> clearCartData() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('cart_items');
 // await prefs.remove('phone');

}

  void decreaseQuantity(dynamic targetItemID) {
    for (var item in ListOrderImage) {
      if (item['BarCode'] == targetItemID && item['Quantity'] > 0) {
        item['Quantity'] -= 1;

        // if ((item['Quantity'] - item['GiftQTY'] * item['Y_Gift_Qty']) % item['RequiredQTY'] == 0) {
        //   continue;
        // }


        if(item['GiftQTY']>0&&item['RequiredQTY']>0)
        {
          if ((item['Quantity'] - item['GiftQTY'] * item['Y_Gift_Qty'] + 1) % item['RequiredQTY'] == 0) {
            item['Quantity'] -= item['GiftQTY'];
            item['Y_Gift_Qty']--;
          }
        }


        if (item['Quantity'] <= 0) {
          ListOrderImage.remove(item);
        }
        break;
      }
    }
    clearCartData();
    saveCartData(ListOrderImage);
    notifyListeners();
    print('Ahmeddddddddddd000000000000000000000000000000');
    print(ListOrderImage);
  }

}

final orderProviderListImage = ChangeNotifierProvider<ListItemOrderImage>((ref) {
  return ListItemOrderImage(ref);
});










//-------------------------------------------Get Addresss--------------------------


final getAddressFromApiProvider = ChangeNotifierProvider((ref) =>  GetDataAddressFromApi());
class GetDataAddressFromApi extends ChangeNotifier{

  GetDataAddressFromApi(){
    getAddresss();

  }
  dynamic decrypt(String encryptedText, String privateKey, String publicKey) {
    final keyObj = encrypt.Key.fromUtf8(privateKey);
    final ivObj = encrypt.IV.fromUtf8(publicKey);
    final encrypter = encrypt.Encrypter(
        encrypt.AES(keyObj, mode: encrypt.AESMode.cbc));

    try {
      final decrypted = encrypter.decrypt(
          encrypt.Encrypted.fromBase64(encryptedText), iv: ivObj);
      return decrypted;
    } catch (e) {
      print("Error decrypting data: $e");
      return 'Error....................';
    }
  }
  int SelectIndexAddress=0;
  List<Map<String, dynamic>> dataAddressList=[];
void passAddressToGuest({required AddressModel address}){
  dataAddressList = [address.toMap()];
  log(dataAddressList.toString());
notifyListeners();
}
  void getAddresss(){

    DioHelperOneSystem.getData(url:'api/Customers/GetCustomerAddress?CustomerPhone=$UserPhone') // $UserPhone (url:'api/Customers/GetCustomerAddress?CustomerPhone=94440596')  
        .then((value){

      print('Address 111111111111111111dddddddddddddddddddddddddddddddd11111111111111111111111111111111111');
      print('Success');
      print('مشفرره');
      print(value.data);

      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      log('بعد التشفير');
      log(decryptedText);
      log('*************');



      dataAddressList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();

      print('********************************************');
      log(dataAddressList.toString());

      log(dataAddressList.length.toString());
      print('ADDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
      notifyListeners();

    }).catchError((error){


    });

  }
  void changeSelectIndex(int index)
  {
    SelectIndexAddress=index;
    notifyListeners();
  }













  List<Map<String, dynamic>> categoryAllList=[];
  void getCategoryAll(){
    DioHelperOneSystem.getData(url:'api/Category')
        .then((value){
      print('CategoryAl');
      print('CategoryAl');
      print('Success');
      print('مشفرره');
      print(value.data);
      print('11111111111111111111111111111111111111111111111111111');
      final encryptedText = value.data;
      final privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      final publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');



      categoryAllList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();
      print(categoryAllList);

      notifyListeners();

    }).catchError((error){

      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');

    });

  }
}
