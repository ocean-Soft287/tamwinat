  import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sundaymart/src/presentation/pages/main/home/on_system/controller/home_riverpod.dart';
import 'package:sundaymart/src/presentation/pages/main/home/widget/banaer_items_screen.dart';

// ignore: must_be_immutable
class ImageBannerOnList extends ConsumerStatefulWidget {
  int currentPage;
   ImageBannerOnList({super.key,required this.currentPage});

  @override
  ConsumerState<ImageBannerOnList> createState() => _ImageBannerOnListState();
}

class _ImageBannerOnListState extends ConsumerState<ImageBannerOnList> {
  @override
  Widget build(BuildContext context) {
       
    return Consumer(builder: (context, ref, child) {
            final getDataCategoryByParentId =
            ref.watch(getImageBanarOneApiProvider);
            return getDataCategoryByParentId.imageBanarOneList.isEmpty?const SizedBox():
              (getDataCategoryByParentId.imageBanarOneList[0]["ShowGroup"]==0)?const SizedBox():
              Container(
              height: 150.0.h,
              width: MediaQuery.of(context).size.width,
              decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: CarouselSlider.builder(
                itemCount: getDataCategoryByParentId.imageBanarOneList.length,
                itemBuilder: (context, index, realIndex) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: InkWell(
                      onTap: () {
                        debugPrint(getDataCategoryByParentId.imageBanarOneList[index].toString());


                        if(getDataCategoryByParentId.imageBanarOneList[index]["ItemsCount"]>0)
                        {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BannerItemsScreen(
                                  imageName:
                                  '${getDataCategoryByParentId.imageBanarOneList[index]["ID"]}',
                                )),
                          );
                        }

                      },
                      child:
                  CachedNetworkImage(
  imageUrl: '${getDataCategoryByParentId.imageBanarOneList[index]["ImagePath"] ?? ""}',
  width: MediaQuery.of(context).size.width,
  fit: BoxFit.fill,
  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
  errorWidget: (context, url, error) => Icon(Icons.error),
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