//
//
//
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart' as loc;
// import 'package:geocoding/geocoding.dart';
//
// class MapScreen extends StatefulWidget {
//
//
//
//   MapScreen();
//
//
//
//
//
//
//   @override
//
//   _MapScreenState createState() => _MapScreenState();
// }
//
// class _MapScreenState extends State<MapScreen> {
//   GoogleMapController? mapControllerStudent;
//   Set<Marker> markersStudent = Set<Marker>();
//   LatLng? currentLocation;
//   List<Placemark>? placemarks;
//
//
//   @override
//   void initState() {
//     super.initState();
//     //getCurrentLocationStudent();
//     getCurrentLocationStudent();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white),onPressed: (){
//           Navigator.pop(context,placemarks![0]);
//         }),
//         backgroundColor: Colors.orange,
//
//         centerTitle: true,
//         elevation: 0.0,
//
//       ),
//       body:  Stack(
//         alignment: Alignment.bottomLeft,
//         children: [
//           GoogleMap(
//             onTap:(Lat) async {
//
//
//               //  List<Location> locations = await locationFromAddress("Gronausestraat 710, Enschede");
//               List<Placemark> placemarks = await placemarkFromCoordinates(29.158916, 48.089771);
//               print(Lat);
//
//               print(placemarks[0]);
//               print(currentLocation);
//
//
//             },
//             mapType: MapType.normal,
//             myLocationButtonEnabled: true,
//             zoomControlsEnabled: false,
//             myLocationEnabled: true,
//
//             onMapCreated: (GoogleMapController controller) {
//
//               mapControllerStudent = controller;
//               setState(() {
//
//                 markersStudent.add(
//                   Marker(
//
//                     markerId: MarkerId('currentLocation'),
//                     position: currentLocation ?? LatLng(0, 0),
//
//                     infoWindow: InfoWindow(
//                       title: 'Your Location Student',
//                     ),
//                   ),
//                 );
//                 // getLocationBus();
//               });
//             },
//
//             initialCameraPosition: CameraPosition(
//               target: LatLng(29.3759, 47.9774),
//               zoom: 10,
//
//             ),
//             markers: markersStudent,
//           ),
//
//           // IconButton(onPressed:(){
//           //   deleteDocument(documentId: widget.parameterValue);
//           //
//           // }, icon:Icon(Icons.delete,color:Color(0xff931A21 ),size: 50,) )
//
//
//         ],),
//
//
//       floatingActionButton:FloatingActionButton(
//         onPressed: (){
//           getCurrentLocationStudent();
//         },
//         child: Icon(Icons.my_location,color: Colors.orange,),
//       ),
//
//
//
//     );
//   }
//
//
//
//
//
//
//
//   Future<void> getCurrentLocationStudent() async {
//     loc.Location location = loc.Location();
//
//     await location.requestService();
//     await location.requestPermission();
//
//     loc.LocationData? currentLocation = await location.getLocation();
//
//     if (currentLocation != null) {
//       double latitude = currentLocation.latitude!;
//       double longitude = currentLocation.longitude!;
//
//       placemarks = await placemarkFromCoordinates(29.33053956279516, 48.02895995391093
//
//
//       );
//
//       print('gamal100000000000000000000000000000000000000000000000');
//       print(
//           "Name: ${placemarks![0].name},\n "
//               "street: ${placemarks![0].street},\n"
//               " isoCountryCod: ${placemarks![0].isoCountryCode}\n"
//               "administrativeArea: ${placemarks![0].administrativeArea}, \n"
//               "subAdministrativeArea: ${placemarks![0].subAdministrativeArea}, \n"
//               "Locality: ${placemarks![0].locality},\n"
//               " Country: ${placemarks![0].country}\n"
//               "subLocality: ${placemarks![0].subLocality},\n "
//               "thoroughfare: ${placemarks![0].thoroughfare},\n "
//               "subThoroughfare: ${placemarks![0].subThoroughfare},\n"
//
//
//
//       );
//       print('gamal100000000066666666666666666666666666666666666');
//       showModalBottomSheet(
//         context: context,
//         builder: (BuildContext context) {
//           return Container(
//             height: 150.h,
//             width:MediaQuery.of(context).size.width,
//             color: Colors.white,
//             child:
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text('عنوان التوصيل',style: TextStyle(
//                   fontWeight: FontWeight.w500,
//                   fontSize: 16.sp,
//                   fontFamily: 'Monadi',
//                   color: Colors.black,
//                 ),
//                   textAlign: TextAlign.start,
//                 ),
//                 13.verticalSpace,
//                 Text(
//                   " '${placemarks![0].subThoroughfare ?? ''} ${placemarks![0].thoroughfare ?? ''}, ${placemarks![0].subLocality ?? ''}, ${placemarks![0].locality ?? ''}, ${placemarks![0].administrativeArea ?? ''}, ${placemarks![0].country ?? ''}",
//                   style: TextStyle(fontSize: 13.sp,
//                     fontWeight: FontWeight.w500,
//                     fontFamily: 'Monadi',
//                     color: Colors.grey,
//                   ),
//                   textAlign: TextAlign.start,
//                 ),
//                 13.verticalSpace,
//                 // ElevatedButton(
//                 //   onPressed: () => Navigator.pop(context,placemarks![0]),
//                 //   child: Text('إغلاق'),
//                 // ),
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: GestureDetector(
//
//                     onTap: ()   => Navigator.pop(context,placemarks![0]),
//
//                     child: Container(
//                       width:MediaQuery.of(context).size.width,
//                       height: 50.h,
//                       decoration: BoxDecoration(
//                         color: Colors.orange,
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: const Center(
//                         child: Text(
//                           'استخدام هذا العنوان',
//                           style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       );
//
//
//
//
//
//
//
//
//
//
//     } else {
//       print("Unable to fetch current location.");
//     }
//   }
//
//
//
//
//
// }