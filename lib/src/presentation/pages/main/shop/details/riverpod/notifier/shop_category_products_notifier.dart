import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../../../core/utils/utils.dart';
import '../../../../../../../models/models.dart';
import '../../../../../../../repository/repository.dart';
import '../state/shop_category_products_state.dart';

class ShopCategoryProductsNotifier
    extends StateNotifier<ShopCategoryProductsState> {
  final ProductsRepository _productsRepository;
  final CartsRepository _cartsRepository;
  int _categoriesPage = 0;
  Timer? _timer;
  int? _activeProductIndex;
  int? _activeCategoryIndex;

  ShopCategoryProductsNotifier(this._productsRepository, this._cartsRepository)
      : super(const ShopCategoryProductsState()) {
    _activeProductIndex = null;
    _activeCategoryIndex = null;
  }

  void updateShopCategoryProducts({CartData? cartData}) {
    List<ShopCategoryData> shopCategories =
        List.from(state.shopCategoryProducts);
    for (int i = 0; i < shopCategories.length; i++) {
      List<ProductData>? products = shopCategories[i].products;
      if (products != null) {
        for (int j = 0; j < products.length; j++) {
          final int cartCount =
              AppHelpers.getProductCartCount(cartData, products[j]);
          products[j] = products[j]
              .copyWith(cartCount: cartCount, localCartCount: cartCount);
        }
      }

      shopCategories[i] = shopCategories[i].copyWith(products: products);
    }
    state = state.copyWith(shopCategoryProducts: shopCategories);
  }

  void decreaseProductCount({
    int? shopId,
    required int productIndex,
    required int categoryIndex,
  }) {
    final List<ShopCategoryData> shopCategories =
        List.from(state.shopCategoryProducts);
    final List<ProductData>? products = shopCategories[categoryIndex].products;
    if (products != null) {
      final List<ProductData> listOfProducts = List.from(products);
      final product = listOfProducts[productIndex];
      if ((product.localCartCount ?? 0) <= (product.minQty ?? 0)) {
        return;
      }
      final int localCartCount = product.localCartCount ?? 0;
      listOfProducts[productIndex] = product.copyWith(
        localCartCount: localCartCount - 1,
      );
      shopCategories[categoryIndex] =
          shopCategories[categoryIndex].copyWith(products: listOfProducts);
      state = state.copyWith(shopCategoryProducts: shopCategories);
      _timer?.cancel();
      _timer = Timer(
        const Duration(milliseconds: 4000),
        () {
          // listOfProducts[productIndex] =
          //     listOfProducts[productIndex].copyWith(isChoosing: false);
          shopCategories[categoryIndex] =
              shopCategories[categoryIndex].copyWith(products: listOfProducts);
          state = state.copyWith(shopCategoryProducts: shopCategories);
          _updateRemoteCart(
            productIndex: _activeProductIndex,
            categoryIndex: _activeCategoryIndex,
            shopId: shopId,
          );
          _activeProductIndex = null;
          _activeCategoryIndex = null;
        },
      );
    }
  }

  ProductData? _getActiveProduct({int? productIndex, int? categoryIndex}) {
    final List<ProductData>? products =
        state.shopCategoryProducts[categoryIndex!].products;
    if (products != null) {
      return products[productIndex!];
    }
    return null;
  }

  // void _updateLoadingProduct(
  //   bool value, {
  //   int? productIndex,
  //   int? categoryIndex,
  // }) {
  //   final List<ShopCategoryData> shopCategories =
  //       List.from(state.shopCategoryProducts);
  //   final List<ProductData>? products = shopCategories[categoryIndex!].products;
  //   if (products != null) {
  //     final List<ProductData> listOfProducts = List.from(products);
  //     listOfProducts[productIndex!] =
  //         listOfProducts[productIndex].copyWith(isLoading: value);
  //     shopCategories[categoryIndex] =
  //         shopCategories[categoryIndex].copyWith(products: listOfProducts);
  //     state = state.copyWith(shopCategoryProducts: shopCategories);
  //   }
  // }

  Future<void> _updateRemoteCart({
    int? shopId,
    int? productIndex,
    int? categoryIndex,
  }) async {
    if (productIndex == null || _activeCategoryIndex == null) {
      return;
    }
    final ProductData? product = _getActiveProduct(
      productIndex: productIndex,
      categoryIndex: categoryIndex,
    );
    if (product?.localCartCount == null || product?.localCartCount == 0) {
      return;
    }
    // _updateLoadingProduct(
    //   true,
    //   productIndex: productIndex,
    //   categoryIndex: categoryIndex,
    // );
    final response = await _cartsRepository.saveProductToCart(
      shopId: shopId,
      productId: product?.id,
      quantity: product?.localCartCount,
    );
    response.when(
      success: (data) {
        // _updateLoadingProduct(
        //   false,
        //   productIndex: productIndex,
        //   categoryIndex: categoryIndex,
        // );
      },
      failure: (failure) {
        debugPrint('==> save to cart failure: $failure');
        // _updateLoadingProduct(
        //   false,
        //   productIndex: productIndex,
        //   categoryIndex: categoryIndex,
        // );
      },
    );
  }

  void increaseProductCount({
    int? shopId,
    required int productIndex,
    required int categoryIndex,
  }) {
    final List<ShopCategoryData> shopCategories =
        List.from(state.shopCategoryProducts);
    final List<ProductData>? products = shopCategories[categoryIndex].products;
    if (products != null) {
      final List<ProductData> listOfProducts = List.from(products);
      final product = listOfProducts[productIndex];
      if ((product.localCartCount ?? 0) >= (product.maxQty ?? 0)) {
        return;
      }
      final int localCartCount = product.localCartCount ?? 0;
      listOfProducts[productIndex] = product.copyWith(
        localCartCount:
            localCartCount == 0 ? product.minQty : (localCartCount + 1),
      );
      shopCategories[categoryIndex] =
          shopCategories[categoryIndex].copyWith(products: listOfProducts);
      state = state.copyWith(shopCategoryProducts: shopCategories);
      _timer?.cancel();
      _activeProductIndex = productIndex;
      _activeCategoryIndex = categoryIndex;
      _timer = Timer(
        const Duration(milliseconds: 300),
        () {
          _updateRemoteCart(
            productIndex: _activeProductIndex,
            categoryIndex: _activeCategoryIndex,
            shopId: shopId,
          );
          _activeProductIndex = null;
          _activeCategoryIndex = null;
        },
      );
      // _timer = Timer(
      //   const Duration(milliseconds: 4000),
      //   () {
      //     // listOfProducts[productIndex] =
      //     //     listOfProducts[productIndex].copyWith(isChoosing: false);
      //     shopCategories[categoryIndex] =
      //         shopCategories[categoryIndex].copyWith(products: listOfProducts);
      //     state = state.copyWith(shopCategoryProducts: shopCategories);
      //     _updateRemoteCart(
      //       productIndex: _activeProductIndex,
      //       categoryIndex: _activeCategoryIndex,
      //       shopId: shopId,
      //     );
      //     _activeProductIndex = null;
      //     _activeCategoryIndex = null;
      //   },
      // );
    }
  }

  void updateChoosing({
    int? shopId,
    required int productIndex,
    required int categoryIndex,
  }) {
    List<ShopCategoryData> listOfCategories =
        List.from(state.shopCategoryProducts);
    _timer?.cancel();
    for (int i = 0; i < listOfCategories.length; i++) {
      List<ProductData>? listOfProducts = listOfCategories[i].products;
      if (listOfProducts == null) {
        continue;
      }
      // for (int j = 0; j < listOfProducts.length; j++) {
      //   listOfProducts[j] = listOfProducts[j].copyWith(isChoosing: false);
      // }
      listOfCategories[i] =
          listOfCategories[i].copyWith(products: listOfProducts);
    }
    List<ProductData>? listOfProducts =
        listOfCategories[categoryIndex].products;
    if (listOfProducts == null) {
      return;
    }
    // listOfProducts[productIndex] =
    //     listOfProducts[productIndex].copyWith(isChoosing: true);
    _updateRemoteCart(shopId: shopId);
    _activeProductIndex = productIndex;
    _activeCategoryIndex = categoryIndex;
    listOfCategories[categoryIndex] =
        listOfCategories[categoryIndex].copyWith(products: listOfProducts);
    _timer = Timer(
      const Duration(milliseconds: 4000),
      () {
        // listOfProducts[productIndex] =
        //     listOfProducts[productIndex].copyWith(isChoosing: false);
        listOfCategories[categoryIndex] =
            listOfCategories[categoryIndex].copyWith(products: listOfProducts);
        state = state.copyWith(shopCategoryProducts: listOfCategories);
        _updateRemoteCart(
          productIndex: _activeProductIndex,
          categoryIndex: _activeCategoryIndex,
          shopId: shopId,
        );
        _activeProductIndex = null;
        _activeCategoryIndex = null;
      },
    );
    state = state.copyWith(shopCategoryProducts: listOfCategories);
  }

  void likeOrUnlikeProduct({
    int? productId,
    int? shopId,
  }) {
    final List<LocalProductData> likedProducts =
        LocalStorage.instance.getLikedProductsList();
    bool alreadyLiked = false;
    int indexLiked = 0;
    for (int i = 0; i < likedProducts.length; i++) {
      if (likedProducts[i].productId == productId) {
        alreadyLiked = true;
        indexLiked = i;
      }
    }
    if (alreadyLiked) {
      likedProducts.removeAt(indexLiked);
      LocalStorage.instance
          .setLikedProductsList(likedProducts.toSet().toList());
    } else {
      likedProducts.insert(
        0,
        LocalProductData(productId: productId ?? 0, shopId: shopId),
      );
      final setList = likedProducts.toSet().toList();
      final subList = setList.length > 16 ? setList.sublist(0, 16) : setList;
      LocalStorage.instance.setLikedProductsList(subList);
    }
    state = state.copyWith();
  }

  Future<void> fetchShopCategories({int? shopId, CartData? cartData}) async {
    if (!state.hasMore) {
      return;
    }
    if (_categoriesPage == 0) {
      state = state.copyWith(isLoading: true);
      final response = await _productsRepository.getShopCategories(
        page: ++_categoriesPage,
        shopId: shopId,
      );
      response.when(
        success: (data) {
          final List<ShopCategoryData> shopCategories = data.data ?? [];
          for (int i = 0; i < shopCategories.length; i++) {
            final List<ProductData>? products = shopCategories[i].products;
            if (products != null) {
              final List<ProductData> listOfProducts = List.from(products);
              for (int j = 0; j < listOfProducts.length; j++) {
                final int cartCount = AppHelpers.getProductCartCount(
                  cartData,
                  listOfProducts[j],
                );
                if (cartCount != 0) {
                  listOfProducts[j] = listOfProducts[j].copyWith(
                    cartCount: cartCount,
                    localCartCount: cartCount,
                  );
                  shopCategories[i] =
                      shopCategories[i].copyWith(products: listOfProducts);
                  state = state.copyWith(shopCategoryProducts: shopCategories);
                }
              }
            }
          }
          state = state.copyWith(
            isLoading: false,
            shopCategoryProducts: shopCategories,
            hasMore: (data.data ?? []).length >= 5,
          );
        },
        failure: (failure) {
          _categoriesPage--;
          state = state.copyWith(isLoading: false, hasMore: false);
          debugPrint('==> get shop categories failure: $failure');
        },
      );
    } else {
      state = state.copyWith(isMoreLoading: true);
      final response = await _productsRepository.getShopCategories(
        page: ++_categoriesPage,
        shopId: shopId,
      );
      response.when(
        success: (data) {
          final List<ShopCategoryData> newList =
              List.from(state.shopCategoryProducts);
          newList.addAll(data.data ?? []);
          state = state.copyWith(
            isMoreLoading: false,
            shopCategoryProducts: newList,
            hasMore: (data.data ?? []).length >= 5,
          );
        },
        failure: (failure) {
          _categoriesPage--;
          state = state.copyWith(isMoreLoading: false);
          debugPrint('==> get shop categories failure: $failure');
        },
      );
    }
  }

  Future<void> updateShopCategories(
    BuildContext context, {
    int? shopId,
    CartData? cartData,
  }) async {
    _categoriesPage = 0;
    state = state.copyWith(hasMore: true);
    fetchShopCategories(shopId: shopId, cartData: cartData);
  }
}
