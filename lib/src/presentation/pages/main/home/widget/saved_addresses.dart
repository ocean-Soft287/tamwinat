import 'package:auto_route/auto_route.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/Controller/add_address_riverpod.dart';
import '../../../../../riverpod/gh.dart';
import '../../../../components/app_bars/common_appbar.dart';
import '../../../../theme/app_colors.dart';
import '../../shop/cart/checkout/oneSystem/Controller/basct_shop_contrroller.dart';

import 'package:sundaymart/src/presentation/pages/main/shop/cart/checkout/oneSystem/widget/add_address.dart';
class SavedAddresses extends ConsumerStatefulWidget {
  const SavedAddresses({Key? key}) : super(key: key);

  @override
  _SavedAddressesState createState() => _SavedAddressesState();


}

class _SavedAddressesState extends ConsumerState<SavedAddresses> {
  @override
  void initState() {
    super.initState();
    ref.read(getAddressFromApiProvider.notifier).getAddresss();
  }
  Widget build(BuildContext context) {
    final lang = ref.watch(appModelProvider);
    final listAddressUser = ref.watch(getAddressFromApiProvider);
    final deleteAddress = ref.watch(addAddressProvider);
    return Scaffold(
      backgroundColor: AppColors.white.withOpacity(0.9),

      appBar: CommonAppBar(
          actions:[
            IconButton(
              splashRadius: 18.r,
              onPressed: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            AddNewAddress()
                    ));
              },
              padding: EdgeInsets.zero,
              icon: Icon(
               Icons.add,
                size: 32.r,
                color:Colors.orange,
              ),
            )
          ],
        title: (lang.activeLanguage.languageCode == 'ar')
            ? 'العناوين المحفوظه'
            : 'Saved Addresses',
        onLeadingPressed: ()=> Navigator.pop(context),
      ),
      body:
      Consumer(
          builder: (context, ref, child) {

            final addNewAddress = ref.watch(addAddressProvider);
          return
          ConditionalBuilder(
              condition:listAddressUser.dataAddressList.isNotEmpty ,
              builder: (context){
                return  ListView.builder(
                    itemCount: listAddressUser.dataAddressList.length,

                    itemBuilder:(context,index)
                    {
                      return
                        InkWell(
                          onTap: (){
                           // listAddressUser.getAddresss();
                         print(listAddressUser.dataAddressList.length);
                         print(listAddressUser.dataAddressList[0]);
                         print(listAddressUser.dataAddressList[1]);
                          print(listAddressUser.dataAddressList[2]);
                         print(listAddressUser.dataAddressList[3]);

                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 4),
                            child:  Container(
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(

                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5)
                              ),
                              height: 100.h,
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    (lang.activeLanguage.languageCode == 'ar')
                                        ? '${listAddressUser.dataAddressList[index]["DistrictName2"]}'
                                        : '${listAddressUser.dataAddressList[index]["DistrictName2"]}',
                                    style: GoogleFonts.tajawal(
                                      fontSize:
                                      12.sp,
                                      fontWeight:
                                      FontWeight.bold,
                                    ),),
                                  5.verticalSpace,
                                  Expanded(
                                    child: Text(
                                      '${listAddressUser.dataAddressList[index]["CustomerAddress"]}',
                                      maxLines: 2,
                                      style: TextStyle(
                                        fontSize: 11.sp,
                                        color: Colors.black,
                                        fontWeight:
                                        FontWeight.bold,
                                        fontFamily: 'Monadi',
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      InkWell(
                                        onTap: (){
                                          print(listAddressUser.dataAddressList[index]);
                                          Navigator.push(context, MaterialPageRoute(builder: (context){
                                            return  AddNewAddress(editAddress: listAddressUser.dataAddressList[index],);
                                          }));
                                        },
                                        child: Text(
                                          (lang.activeLanguage.languageCode == 'ar')
                                              ? 'تعديل'
                                              : 'Update',
                                          style: GoogleFonts.tajawal(
                                              fontSize:
                                              12.sp,
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.grey
                                          ),),
                                      ),
                                      5.horizontalSpace,
                                      InkWell(
                                        onTap: (){

                                          print(listAddressUser.dataAddressList[index]["MainAddress"]);
                                          print(listAddressUser.dataAddressList.length);

                                          if(listAddressUser.dataAddressList[index]["MainAddress"]==1)
                                            {
                                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                                backgroundColor: const Color(0xffcc0000),
                                                content: Text(
                                                  lang.activeLanguage.languageCode == 'ar'
                                                      ? 'لا يمكن حذف هذا العنوان لأنه العنوان الأساسي'
                                                      : 'This address cannot be deleted because it is the primary address',
                                                ),
                                              ));
                                            }
                                          else

                                            {
                                              deleteAddress.deleteAddress(addressILd:listAddressUser.dataAddressList[index]["AddressID"] , context: context, isArabic:  (lang.activeLanguage.languageCode == 'ar')?true:false);
                                              listAddressUser.getAddresss();
                                            }


                                        },
                                        child: Text(
                                          (lang.activeLanguage.languageCode == 'ar')
                                              ? 'حذف'
                                              : 'Delete',
                                          style: GoogleFonts.tajawal(
                                              fontSize:
                                              12.sp,
                                              fontWeight:
                                              FontWeight.bold,
                                              color: Colors.red
                                          ),),
                                      ),
                                    ],
                                  )
                                ],
                              ),

                            ),
                          ),
                        );
                    }

                );
              },
              fallback: (context){
                return Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const CircularProgressIndicator(color: Colors.orange,),
                      5.verticalSpace,
                      Text(
                        (lang.activeLanguage.languageCode == 'ar')
                            ? 'لا توجد عناوين محفوظه..'
                            :  'لا توجد عناوين محفوظه...',
                        style: GoogleFonts.tajawal(
                          fontSize:
                          12.sp,
                          fontWeight:
                          FontWeight.bold,
                        ),),
                    ],
                  ),
                );
              })
           ;

        }
      ),


    );
  }
}

