// import 'package:flutter/material.dart';
//
// import '../../core/di/injection.dart';
// import '../../core/handlers/handlers.dart';
// import '../../core/utils/utils.dart';
// import '../../models/models.dart';
// import '../repository.dart';
//
// class BrandsRepositoryImpl implements BrandsRepository {
//   @override
//   Future<ApiResult<BrandsPaginateResponse>> getBrandsPaginate({
//     int? page,
//     int? shopId,
//     String? query,
//   }) async {
//     final data = {
//       if (page != null) 'page': page,
//       if (shopId != null) 'shop_id': shopId,
//       if (query != null) 'search': query,
//       'perPage': 14,
//       'lang': LocalStorage.instance.getLanguage()?.locale,
//     };
//     try {
//       final client = inject<HttpService>().client(requireAuth: false);
//       final response = await client.get(
//         '/api/v1/rest/brands/paginate',
//         queryParameters: data,
//       );
//       return ApiResult.success(
//         data: BrandsPaginateResponse.fromJson(response.data),
//       );
//     } catch (e) {
//       debugPrint('==> get brands paginate failure: $e');
//       return ApiResult.failure(error: NetworkExceptions.getDioException(e));
//     }
//   }
// }
