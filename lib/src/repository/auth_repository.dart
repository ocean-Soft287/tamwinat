import '../core/handlers/handlers.dart';
import '../models/models.dart';

abstract class AuthRepository {
  Future<ApiResult<EnterPhoneResponse>> sendOtp({required String phone});

  Future<ApiResult<LoginResponse>> loginWithSocial({
    String? email,
    String? displayName,
    String? id,
  });

  Future<ApiResult<LoginResponse>> login({
    required String email,
    required String password,
  });
}
