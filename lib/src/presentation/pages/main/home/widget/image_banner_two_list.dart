import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/src/presentation/pages/main/home/on_system/controller/home_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/banaer_items_screen.dart';

class ImageBannerTwoList extends ConsumerStatefulWidget {
  int  currentPage;
   ImageBannerTwoList({super.key,required this.currentPage});

  @override
  ConsumerState<ImageBannerTwoList> createState() => _ImageBannerTwoListState();
}

class _ImageBannerTwoListState extends ConsumerState<ImageBannerTwoList> {
  @override
  Widget build(BuildContext context) {
    
    return Consumer(builder: (context, ref, child) {
            final getDataCategoryByParentId =
            ref.watch(getImageBanartwoApiProvider);
            return
              getDataCategoryByParentId.imageBanartwoList.isEmpty?const SizedBox():
              getDataCategoryByParentId.imageBanartwoList[0]["ShowGroup"]==0?const SizedBox():
              Container(
              height: 150.0.h,
              width: MediaQuery.of(context).size.width,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: CarouselSlider.builder(
                itemCount: getDataCategoryByParentId.imageBanartwoList.length,
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {
                        print(getDataCategoryByParentId.imageBanartwoList[index]);
                        if(getDataCategoryByParentId.imageBanartwoList[index]["ItemsCount"]>0)
                          {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => BannerItemsScreen(
                                    //  imageName: index + 11,
                                    imageName:
                                    '${getDataCategoryByParentId.imageBanartwoList[index]["ID"]}',
                                  )),
                            );
                          }

                      },
                      child:




                      Image.network(
                        width: MediaQuery.of(context).size.width,
                        '${getDataCategoryByParentId.imageBanartwoList[index]["ImagePath"]}',
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: MediaQuery.of(context).size.width /
                      MediaQuery.of(context).size.height,
                  onPageChanged: (index, reason) {
                    setState(() {
                    widget.  currentPage = index;
                    });
                  },
                ),
              ),
            );
          });
  


  }
}