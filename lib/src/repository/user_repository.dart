import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class UserRepository {
  Future<ApiResult<void>> deleteUser();

  Future<ApiResult<ProfileResponse>> updateGeneralInfo({
    required String firstName,
    String? lastName,
    String? birthdate,
    String? gender,
    String? phone,
    String? email,
  });

  Future<ApiResult<WalletHistoriesResponse>> getWalletHistories({int? page});

  Future<ApiResult<ProfileResponse>> updatePassword({
    String? password,
    String? passwordConfirmation,
  });

  Future<ApiResult<ProfileResponse>> updateProfileImage({
    String? firstName,
    String? imageUrl,
  });

  Future<ApiResult<ProfileResponse>> getProfileDetails();

  Future<ApiResult<AddressesResponse>> getUserAddresses();

  Future<ApiResult<void>> deleteAddress(int addressId);

  Future<ApiResult<SingleAddressResponse>> createAddress(
    LocalAddressData address,
  );

  Future<ApiResult<void>> updateFirebaseToken(String? token);
}
