import 'package:dartz/dartz.dart';
import 'package:hmj_apps/core/network/enpoints.dart';
import 'package:hmj_apps/core/network/token_service.dart';
import 'package:hmj_apps/data/models/auth/user_model.dart';
import 'package:hmj_apps/data/repository/base/base_repository.dart';

class AuthRepository extends BaseRepository {
  final TokenService tokenService;

  AuthRepository(super.dio, super.connectionChecker, this.tokenService);

  Future<Either<String, TokenModel>> login(String email, String pass) async {
    return sendRequest<TokenModel>(() async {
      final response = await dio.post(AppEndpoints.login, data: {
        'email': email,
        'password': pass,
      });

      // final response = await dio.get(AppEndpoints.login);

      final token = TokenModel.fromJson(response.data);

      return token;
    });
  }
}
