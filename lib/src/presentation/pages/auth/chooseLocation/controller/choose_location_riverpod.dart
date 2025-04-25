import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final locationProvider = ChangeNotifierProvider<LocationProvider>((ref) {
  return LocationProvider();
});

class LocationProvider extends ChangeNotifier {
  String? _isSelectedAdress;
  String? _placeId;
  bool get isSelectedAdress => (_isSelectedAdress != null);

  String get getAddress => _isSelectedAdress ?? "";

  String get getPlactId => _placeId ?? "";
  void setAdress({required String fullAddressValue, required String placeId}) {
    _isSelectedAdress = fullAddressValue;
    _placeId = placeId;
    notifyListeners();
  }

  void resetAdress() {
    _isSelectedAdress = null;
    _placeId = null;
  }

  void validateAdress(BuildContext context, {required isArabic}) {
    showSnackBarHelper(
      context,
      isErro: true,
      name: isArabic
          ? "يجب اختيار عنوان على الخريطة"
          : "An address must be selected on the map.",
    );
  }

  void showSnackBarHelper(BuildContext context,
      {required String name, required isErro}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor:
            isErro ? const Color(0xffcc0000) : Colors.deepPurpleAccent,
        content: Text(
          name,
        )));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    resetAdress();
    super.dispose();
  }
}
