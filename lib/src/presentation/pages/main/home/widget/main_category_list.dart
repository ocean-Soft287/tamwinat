import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sundaymart/src/presentation/pages/main/home/on_system/controller/home_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/delivery_category_scondry.dart';
import 'package:sundaymart/src/riverpod/gh.dart';

class MainCategoryList extends StatelessWidget {
  const MainCategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
            builder: (context, ref, child) {
              final getMainCategory =
              ref.watch(getDataGetMainCategoryApiProvider);
              final appModel = ref.watch(appModelProvider);
              return  (getMainCategory.mainCategoryList.isEmpty)?const SizedBox():
                GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: getMainCategory.mainCategoryList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 0.0,
                  mainAxisSpacing: 0.0,
                ),
                itemBuilder: (context, index) {
                  final item = getMainCategory.mainCategoryList[index];

                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: InkWell(
                     onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DeliveryCategoryScondory(
                                  categoryId: item['CategoryId'],
                                  CategoryArName:
                                  (appModel.activeLanguage.languageCode ==
                                      'ar')
                                      ? item['CategoryArName']
                                      : item['CategoryEnName'])),
                        );
                        print( item['CategoryId']);


                      },
                      child: Column(
                        children: [
                          4.verticalSpace,
                          Expanded(
                            flex: 2,
                            child:
                            Image.network(
                              '${item['CategoryImage'] ?? ""}',
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) {
                                  return child;
                                }
                                return child;
                                // return const Center(
                                //   child: CircularProgressIndicator(color: Colors.orange,value: 1,),
                                // );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(Icons.error);
                              },
                            ),






                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Text(
                                (appModel.activeLanguage.languageCode == 'ar')
                                    ? '${item['CategoryArName']}'
                                    : '${item['CategoryEnName']}',
                                style: GoogleFonts.tajawal(
                                  fontSize:
                                  12.sp,
                                  fontWeight:
                                  FontWeight.bold,
                                ),


                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          );
  

  }
}