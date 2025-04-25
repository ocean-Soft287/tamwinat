import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class CatalogRepository {
  Future<ApiResult<BlogsPaginateResponse>> getBlogs(int page, String type);

  Future<ApiResult<CategoriesPaginateResponse>> getCategoriesPaginate({
    int? page,
    int? shopId,
    String? query,
  });

  Future<ApiResult<BrandsPaginateResponse>> getBrandsPaginate({
    int? page,
    int? shopId,
    String? query,
  });
}
