import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

import '../../../core/constants/constants.dart';
import '../../../models/models.dart';
import '../list_items/grid_product_item.dart';
import '../shimmers/grid_list_shimmer.dart';

class GridProductsBody extends StatelessWidget {
  final bool isLoading;
  final List<ProductData> products;
  final Function(int?) onLiked;
  final ScrollController? scrollController;
  final int? shopId;
  final Function(int) increase;
  final Function(int) decrease;
  final double? bottomPadding;

  const GridProductsBody({
    Key? key,
    required this.increase,
    required this.decrease,
    required this.onLiked,
    this.isLoading = false,
    this.products = const [],
    this.scrollController,
    this.shopId,
    this.bottomPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const GridListShimmer(
            isScrollable: true,
            onlyBottomPadding: 100,
            verticalPadding: 24,
          )
        : products.isEmpty
            ? Center(child: Lottie.asset(AppAssets.lottieNotFound))
            : GridView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: products.length,
                padding:
                    REdgeInsets.only(top: 24, bottom: bottomPadding ?? 100),
                controller: scrollController,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio:
                      Platform.isAndroid ? (188 / 310) : (180 / 312),
                  mainAxisSpacing: 8.r,
                  crossAxisSpacing: 8.r,
                  crossAxisCount: 2,
                ),
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return GridProductItem(
                    shopId: shopId,
                    product: products[index],
                    onLikePressed: () {
                      onLiked(products[index].id);
                    },
                    onIncrease: () {
                      increase(index);
                    },
                    onDecrease: () {
                      decrease(index);
                    },
                  );
                },
              );
  }
}
