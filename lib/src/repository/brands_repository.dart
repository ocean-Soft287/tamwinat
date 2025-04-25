import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class BrandsRepository {
  Future<ApiResult<BrandsPaginateResponse>> getBrandsPaginate({
    int? page,
    int? shopId,
    String? query,
  });
}
