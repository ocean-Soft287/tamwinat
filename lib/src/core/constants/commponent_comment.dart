// (
// UserPhone==null)?SizedBox():Consumer(
// builder: (context, ref, child) {
// ref.watch(getAddressFromApiProvider);
// final listAddressUser = ref.watch(getAddressFromApiProvider);
// return TextButton(
// child: Column(
// crossAxisAlignment: CrossAxisAlignment.start,
// children: [
// Text(
// (appModel.activeLanguage.languageCode == 'ar')
// ? 'التوصيل الى '
//     : 'Delivery to ',
// style: GoogleFonts.cairo(
// fontWeight: FontWeight.w500,
// fontSize: 15.sp,
// color: AppColors.black,
// ),
// ),
// Row(
// children: [
// SizedBox(width: 10,),
// Transform.rotate(angle: 90 * 3.141592653589793238 / 60,child: Icon(Icons.arrow_forward_ios,color: Colors.black,)),
// Text(
// '${listAddressUser.dataAddressList[listAddressUser.SelectIndexAddress]["DistrictName2"] }',
// style: GoogleFonts.cairo(
// fontWeight: FontWeight.w500,
// fontSize: 15.sp,
// color: AppColors.black,
// ),
// )
// ],
// ),
// ],
// ),
// onPressed: (){
// showModalBottomSheet(
// context: context,
// builder: (BuildContext context) {
//
// return
// Container(
// padding: EdgeInsets.all(16.0),
// child: Column(
// mainAxisSize: MainAxisSize.min,
// children:[
// InkWell(
// onTap: () {
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) =>
// AddNewAddress()));
// },
// child: Row(
// mainAxisAlignment:
// MainAxisAlignment.spaceBetween,
// children: [
// Text(
// (appModel.activeLanguage
//     .languageCode ==
// 'ar')
// ? 'اضافه عنوان جديد'
//     : 'Enter Please Address',
// style: TextStyle(
// fontWeight: FontWeight.w500,
// fontSize: 16.sp,
// fontFamily: 'Monadi',
// color: AppColors.black,
// )),
// Container(
// width: 30,
// height: 30,
// decoration: BoxDecoration(
// shape: BoxShape.circle,
// color: Colors.white,
// border: Border.all(
// color: Colors.orange,
// width: 2.0,
// ),
// ),
// child: Icon(Icons.add,
// color: Colors.orange),
// ),
// ],
// ),
// ),
// SizedBox(height: 16),
//
// Flexible(
// child: ListView.builder(
// itemCount: listAddressUser
//     .dataAddressList.length,
// shrinkWrap: true,
// padding: EdgeInsets.zero,
// itemBuilder: (context, index) {
// final item = listAddressUser
//     .dataAddressList[index];
// return InkWell(
// onTap: (){
// listAddressUser.changeSelectIndex(index);
// Navigator.of(context).pop();
// },
// child: Column(
// children: [
// Container(
// child: Column(
// children: [
// Row(
// mainAxisAlignment:
// MainAxisAlignment
//     .spaceBetween,
// children: [
// Row(
// children: [
// Icon(
// Icons.location_on,
// color:
// Colors.orange,
// ),
// InkWell(
// onTap: () {
// print('Gamal');
// print(item);
// },
// child: Text(
// (appModel.activeLanguage
//     .languageCode ==
// 'ar')
// ? '${item["DistrictName2"]}'
//     : '${item["DistrictEName2"]}',
// style:
// TextStyle(
// fontWeight:
// FontWeight
//     .w500,
// fontSize:
// 16.sp,
// fontFamily:
// 'Monadi',
// color: AppColors
//     .black,
// )),
// ),
// ],
// ),
// ],
// ),
// item["MapCustomerAddress"] == null ? SizedBox.shrink() : Text(
// '${item["MapCustomerAddress"]}',
// maxLines: 2,
// style: TextStyle(
// fontSize: 11.sp,
// color:
// Colors.black,
// fontWeight:
// FontWeight
//     .bold,
// fontFamily:
// 'Monadi',
// ),
// textAlign: TextAlign
//     .center,
// ),
// 5.verticalSpace,
// Row(
// children: [
//
//
// Expanded(
// child: Text(
// '${item["CustomerAddress"]}',
// maxLines: 2,
// style: TextStyle(
// fontSize: 11.sp,
// color: Colors.black,
// fontWeight:
// FontWeight.bold,
// fontFamily: 'Monadi',
// ),
// ),
// ),
// if(listAddressUser.SelectIndexAddress==index) Container(
// width: 25,
// height: 25,
// decoration: BoxDecoration(
// color: Colors.orange,
// shape: BoxShape.circle,
// ),
// child: Center(
// child: Icon(
// Icons.check,
// color: Colors.white,
// size: 12,
// ),
// ),
// ),
// ],
// ),
// ],
// ),
// ),
// 10.verticalSpace,
// if(index!=listAddressUser.dataAddressList.length-1)Divider(),
// ],
// ),
// );
//
// }),
// ),
// ],
// ),
// );
// },
// );
//
// },
// );
// })
// ,