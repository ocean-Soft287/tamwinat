import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:sundaymart/main.dart';
import '../../../../../pickup/One System/DioOneSystem.dart';



class ListItemOrder extends ChangeNotifier {
  List<Map<String, dynamic>> basctList = [];

  List<Map<String, dynamic>> get orderList =>
      List.unmodifiable(basctList);

  void addItem(Map<String, dynamic> newItem) {
    bool found = false;
    for (var item in basctList) {
      if (item['BarCode'] == newItem['BarCode']) {

        item['Quantity'] = newItem['Quantity'];
        item['Y_Gift_Qty']=newItem['Y_Gift_Qty'];
        getSum();
        found = true;
        if (item['Quantity'] <= 0) {
          basctList.remove(item);
        }
        break;
      }
    }

    if (!found) {
      getSum();
      basctList.add(newItem);
    }

    notifyListeners();
    print('addItem');
    print(newItem);
    print('addItem All List');
    print(basctList);
  }

  void deleteItem(int index) {
    if (index >= 0 && index < basctList.length) {

      dynamic itemIDToDelete = basctList[index]['BarCode'];
      basctList.removeWhere((item) => item['BarCode'] == itemIDToDelete);


      notifyListeners();
      print('allllllllllllllli5050505050505050505050');
      print(basctList);
      print('allllllllllllllli5050505050505050505050');
      print( basctList);
    }
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

    notifyListeners();
    print('decreaseQuantit');
    print(basctList);
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
    notifyListeners();
  }
  int counterSum=0;
  void getSum()
  {counterSum++;
  notifyListeners();
  }

  num calculateTotalQuantity() {
    num totalQuantity = 0;

    for (var item in basctList) {
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

}

final orderProviderList = ChangeNotifierProvider<ListItemOrder>((ref) {
  return ListItemOrder();
});






























class ListItemOrderImage extends ChangeNotifier {
  List<Map<String, dynamic>> ListOrderImage = [];

  List<Map<String, dynamic>> get orderListImage =>
      List.unmodifiable(ListOrderImage);

  void addItem(Map<String, dynamic> newItem) {

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
    notifyListeners();
  }

  void deleteItem(int index) {
    if (index >= 0 && index < ListOrderImage.length) {

      dynamic itemIDToDelete = ListOrderImage[index]['BarCode'];
      ListOrderImage.removeWhere((item) => item['BarCode'] == itemIDToDelete);


      notifyListeners();
      print('allllllllllllllli');
      print(ListOrderImage);
      print('aliiiiiiiiiiiiiiiiiiii');
      print( ListOrderImage);
    }
  }


  void clearItems() {
    ListOrderImage.clear();
    notifyListeners();
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

    notifyListeners();
    print('Ahmeddddddddddd000000000000000000000000000000');
    print(ListOrderImage);
  }

}

final orderProviderListImage = ChangeNotifierProvider<ListItemOrderImage>((ref) {
  return ListItemOrderImage();
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
  void getAddresss(){

    DioHelperOneSystem.getData(url:'api/Customers/GetCustomerAddress?CustomerPhone=$UserPhone')
        .then((value){

      print('Address 111111111111111111dddddddddddddddddddddddddddddddd11111111111111111111111111111111111');
      print('Success');
      print('مشفرره');
      print(value.data);

      final encryptedText = value.data;
      const privateKey = 'c104780a25b4f80c037445dd1f6947e1';
      const publicKey = 'e0c9de1b2de26fe2';

      final decryptedText = decrypt(encryptedText, privateKey, publicKey);
      print('بعد التشفير');
      print(decryptedText);
      print('*************');



      dataAddressList =
          (json.decode(decryptedText) as List<dynamic>)
              .map((item) => item as Map<String, dynamic>)
              .toList();

      print('********************************************');
      print(dataAddressList);

      print(dataAddressList.length);
      print('ADDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDDD');
      notifyListeners();

    }).catchError((error){

      print('is Error == $error');
      print('000000000000000000000000000000000000000000000000000000');

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
