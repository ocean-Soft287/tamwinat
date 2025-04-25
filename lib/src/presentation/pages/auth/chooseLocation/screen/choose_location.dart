
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_places_autocomplete_widgets/address_autocomplete_widgets.dart';

import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sundaymart/src/core/constants/app_constants.dart';
import 'package:sundaymart/src/core/utils/dialog_helper.dart';
import 'package:sundaymart/src/core/utils/location_service.dart';
import 'package:sundaymart/src/models/data/local_location_data.dart';
import 'package:sundaymart/src/presentation/pages/auth/chooseLocation/controller/choose_location_riverpod.dart';
import 'package:sundaymart/src/riverpod/gh.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_webservice/places.dart';
// import 'package:google_maps/google_maps_places.dart';
// import 'package:google_api_headers/google_api_headers.dart';

class ChooseLocation extends ConsumerStatefulWidget {
  bool isArabic;
  ChooseLocation({super.key, required this.isArabic});

  @override
  _ChooseLocationState createState() => _ChooseLocationState();
}

class _ChooseLocationState extends ConsumerState<ChooseLocation> {
  static final CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(29.375839227234977, 47.97834745915194), zoom: 12);

  Set<Marker> _markers = {};
  GoogleMapController? googleMapController;
  LatLng currentLocation = initialCameraPosition.target;
  String? streetName;
  String? placeName;
  String? fullAddress;
  String? placeId;
  late bool _isArabic;
  final LocationService locationService =  LocationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _markers.add(Marker(
      position: LatLng(currentLocation.latitude, currentLocation.longitude),
      markerId: MarkerId("currentLocation"),
    ));
    _isArabic = widget.isArabic;
    // placemarkFromCoordinates(
    //   currentLocation.latitude,
    //   currentLocation.longitude,
    // ).then((placemarks) {
    //   streetName = placemarks[0].street;
    //   placeName = placemarks[0].name;
    //   fullAddress =
    //       "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].postalCode}, ${placemarks[0].country}";
    //   setState(() {});
    // });

    locationService.checkPermission().then((value) async {
      currentLocation = LatLng(value.latitude!, value.longitude!);
      // fullAddress = await locationService.fetchAddress(
      //   currentLocation.latitude,
      //   currentLocation.longitude,
      // );
      _animatedCamera(
        isGetCurrentLocation: true,
        locationData: LocationData.fromMap({
          'latitude': currentLocation.latitude,
          'longitude': currentLocation.longitude
        }),
      );
      DialogHelper.showDialogHelper(context);
      await getMyLocation()
          .whenComplete(() => DialogHelper.closeDialogHelper(context));
      // setState(() {});
    }).catchError((erro) {
//denied
      if (erro.toString().contains("deniedForever") || erro.toString().contains("denied")) {
       // Platform.isAndroid?   pre.openAppSettings(): debugPrint("not allowed to use this");

        showLocationPermissionDialog();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final appModel = ref.watch(appModelProvider);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          (appModel.activeLanguage.languageCode == 'ar')
              ? "تحديد عنوانك علي الخريطة"
              : "Locating your address on the map",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
              onPressed: () {
                _showSearchDialog();
              },
              icon: const Icon(Icons.search))
        ],
      ),
      bottomNavigationBar: Container(
        padding: REdgeInsets.symmetric(
          vertical: 15,
        ),
        decoration: BoxDecoration(
            borderRadius:
                BorderRadiusDirectional.vertical(top: Radius.circular(18)),
            color: Colors.blue[100]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            10.verticalSpace,
            Text(
              "Lati:${currentLocation.latitude} , Long:${currentLocation.longitude}",
              style: TextStyle(
                  color: Colors.blue[900],
                  fontFamily: "Cairo",
                  fontSize: 14.sp),
            ),
            10.verticalSpace,
            if (fullAddress != null)
              Text(
                "Full Address : $fullAddress ",
                textDirection: TextDirection.ltr,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.blue[900],
                    fontFamily: "Cairo",
                    fontSize: 14.sp),
              ),
            10.verticalSpace
            // 10.verticalSpace,
            // if (placeName != null)
            //   Text(
            //     "Place Name : $placeName ",
            //     textAlign: TextAlign.center,
            //     textDirection: TextDirection.ltr,
            //     style: TextStyle(
            //         color: Colors.blue[900],
            //         fontFamily: "Cairo",
            //         fontSize: 14.sp),
            //   ),
            // 10.verticalSpace,
            // if (streetName != null)
            //   Text(
            //     "Street Name : $streetName ",
            //     textAlign: TextAlign.center,
            //     style: TextStyle(
            //         color: Colors.blue[900],
            //         fontFamily: "Cairo",
            //         fontSize: 14.sp),
            //     textDirection: TextDirection.ltr,
            //   ),
            // 10.verticalSpace,
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            heroTag: "herotag1",
            child: Icon(Icons.done),
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                  return AlertDialog(    actionsAlignment: MainAxisAlignment.center,
                      title: Text(
                        (appModel.activeLanguage.languageCode == 'ar')
                            ? "العنوان المُحدد :"
                            : "Selected address:",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500),
                      ),
                      content: Text(
                        fullAddress.toString(),
                        textDirection: TextDirection.ltr,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "Cairo",
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400),
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              final locationController =
                                  ref.read(locationProvider);
                              locationController.setAdress(
                                  fullAddressValue: fullAddress ?? "",
                                  placeId: placeId ?? "");
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            },
                            child: Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? "تأكيد"
                                    : "Confirmation")),
                        10.horizontalSpace,
                        ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? "إلغاء"
                                    : "Cancel"))
                      ],
                    );
                  });
            },
          ),
          10.verticalSpace,
          FloatingActionButton(
            heroTag: "herotag2",
            child: Icon(Icons.gps_fixed),
            onPressed: () {

              getMyLocation();

            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              mapType: MapType.normal,
              onMapCreated: (value) {
                googleMapController = value;
              },
              // onCameraMove: (onCameraMove) {
              //   setState(() {
              //     currentLocation = onCameraMove.target;
              //     _markers.add(Marker(
              //       position: LatLng(
              //           currentLocation.latitude, currentLocation.longitude),
              //       markerId: MarkerId("currentLocation"),
              //     ));
              //     placemarkFromCoordinates(
              //             currentLocation.latitude, currentLocation.longitude)
              //         .then((placemarks) {
              //       streetName = placemarks[0].street;
              //       placeName = placemarks[0].name;
              //     });
              //   });
              // },
              markers: _markers,
              onTap: (langLat) async {
                print(langLat.latitude);
                print(langLat.longitude);
                _markers.add(Marker(
                  position: LatLng(langLat.latitude, langLat.longitude),
                  markerId: MarkerId("currentLocation"),
                ));
                currentLocation = LatLng(langLat.latitude, langLat.longitude);
/*
eturn {
              "address": model.results![0].formattedAddress ?? "",
              "placeId": model.results![0].placeId ?? "",
            };

*/
                Map<String, String>? data = await locationService.fetchAddress(
                  langLat.latitude,
                  langLat.longitude,
                );
                fullAddress = data != null ? data['address'] : "";
                placeId = data != null ? data['placeId'] : "";
                // List<Placemark> placemarks = await placemarkFromCoordinates(
                //     langLat.latitude, langLat.longitude);

                // print("*" * 50);

                // debugPrint(placemarks[0].toString());
                // print("*" * 50);
                // fullAddress =
                //     "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].postalCode}, ${placemarks[0].country}";

                // streetName = placemarks[0].street;
                // placeName = placemarks[0].name;
                debugPrint(
                    "Full Adress : $fullAddress  , \n PlaceId : $placeId");
                print("*" * 50);
                setState(() {});
              },
            ),
          )
        ],
      ),
    );
  }
  void showLocationPermissionDialog() {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(

          title: Text("Location Permission Required",
            

          ),
          content: Text("Please grant permission to access your device's location."),
          actions: <Widget>[
            ElevatedButton(
              child: Text("Open Settings"),
              onPressed: () {
                openAppSettings(); // Open app settings
              },
            ),
            ElevatedButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
               // requestLocationPermission(); // Request permission again
              },
            ),
          ],
        );
      },
    );
  }
  Future<void> getMyLocation() async {
    try {
      print("oK");
      Position locationData = await locationService.checkPermission();
      print("oK");
      _animatedCamera(
          locationData: LocationData.fromMap({
            'latitude': locationData.latitude,
            'longitude': locationData.longitude,
          }),
          isGetCurrentLocation: true);
    } catch (e) {
      print(e.toString());

      if (e.toString().contains("deniedForever") || e.toString().contains("denied")) {
        showSnackBarHelper(context,
            name: _isArabic
                ? "يرجى تفعيل الإذن للوصول إلى موقعك."
                : "Please enable permission to access your location.",
            isErro: true);

       // Platform.isAndroid?   pre.openAppSettings(): debugPrint("not allowed to use this");
        showLocationPermissionDialog();
       // await pre.openAppSettings(); // Apple can refuse it
      } else {
        print(e);
        showSnackBarHelper(context,
            name: _isArabic
                ? "يرجى تفعيل الإذن للوصول إلى موقعك."
                : "Please enable permission to access your location.",
            isErro: true);
        showLocationPermissionDialog();
      }
    }
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

  Future<void> _showSearchDialog() async {
    await AddressAutocompleteTextField(
        // context: context,
        // apiKey: AppConstants.googleMapApiKey,
        // mode: Mode.fullscreen,
        // // location: Location(latitude: 15, longitude: 15, timestamp: 52),
        // language: "ar",
        // // region: "eg",
        // offset: 0,
        // hint: "Type here...",
        // radius: 1000,
        // types: [],
        // strictbounds: false,
        // components: [Component(Component.country, "KW")]
        mapsApiKey: AppConstants.googleMapApiKey,
        onSuggestionClick: (p) {
          debugPrint("/" * 100);


          debugPrint("/" * 100);
          // _getLocationFromPlaceId(p!.placeId!, description: p.description!);

          LocalLocationData(
              latitude: p.lat,
              longitude: p.lng);
          //  LatLng(detail.result.geometry!.location.lat,
          //       detail.result.geometry!.location.lng)
          debugPrint("lat : ${p.lat}");
          debugPrint("lang : ${p.lng}");
          _animatedCamera(
              locationData: LocationData.fromMap({
                'latitude': p.lat,
                'longitude': p.lng
              }),
              description: p.formattedAddress,
              placeIdValue: placeId
          );
        },
        componentCountry: 'us',
        language: 'en-US'
    );


  }

  // Future<void> _getLocationFromPlaceId(String placeId,
  //     {required String description}) async {
  //
  //   // GoogleMapsPlaces _places = GoogleMapsPlaces(
  //   //   apiKey: AppConstants.googleMapApiKey,
  //   //   apiHeaders: await GoogleApiHeaders().getHeaders(),
  //   // );
  //
  //   // PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(placeId);
  //   // Place place = P
  //   LocalLocationData(
  //       latitude: detail.result.geometry!.location.lat,
  //       longitude: detail.result.geometry!.location.lng);
  //   //  LatLng(detail.result.geometry!.location.lat,
  //   //       detail.result.geometry!.location.lng)
  //   debugPrint("lat : ${detail.result.geometry!.location.lat}");
  //   debugPrint("lang : ${detail.result.geometry!.location.lng}");
  //   _animatedCamera(
  //       locationData: LocationData.fromMap({
  //         'latitude': detail.result.geometry!.location.lat,
  //         'longitude': detail.result.geometry!.location.lng
  //       }),
  //       description: description,
  //       placeIdValue: placeId);
  // }

  Future<void> _animatedCamera(
      {required LocationData locationData,
      String? description,
      String? placeIdValue,
      bool isGetCurrentLocation = false}) async {
    GoogleMapController controller = googleMapController!;
    CameraPosition _cameraPosition = CameraPosition(
        target: LatLng(locationData.latitude!, locationData.longitude!),
        zoom: isGetCurrentLocation ? 16 : 12);
    controller.animateCamera(
      CameraUpdate.newCameraPosition(_cameraPosition),
    );
    debugPrint(
        "latiude ${locationData.latitude}  ,  longtiude ${locationData.longitude}");
    currentLocation = LatLng(locationData.latitude!, locationData.longitude!);
    _markers.clear();

    if (description != null) {
      fullAddress = description;
      placeId = placeIdValue;
    } else {
      Map<String, String>? data = await locationService.fetchAddress(
        currentLocation.latitude,
        currentLocation.longitude,
      );
      fullAddress = data != null ? data['address'] : "";
      placeId = data != null ? data['placeId'] : "";
    }

    debugPrint('*' * 50);
    debugPrint("placeIdValue : $placeIdValue  , fullAdress : $fullAddress");
    debugPrint('*' * 50);
    // streetName = placemarks[0].street;
    // placeName = placemarks[0].thoroughfare ?? "";

    // fullAddress = description ??
    //     "${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].postalCode}, ${placemarks[0].country}";
    _markers.add(Marker(
      position: LatLng(currentLocation.latitude, currentLocation.longitude),
      markerId: MarkerId("currentLocation"),
    ));

    setState(() {});
  }
}
