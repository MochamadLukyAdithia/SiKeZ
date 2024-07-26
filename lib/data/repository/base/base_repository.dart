import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hmj_apps/core/network/connection_checker.dart';


abstract class BaseRepository {
  final Dio dio;
  final ConnectionChecker connectionChecker;

  BaseRepository(this.dio, this.connectionChecker);

  Future<Either<String, T>> sendRequest<T>(
    Future<T> Function() sendRequestFunction,
  ) async {
    try {
      final isConnectionAvailable =
          await connectionChecker.isConnectionAvailable();
      if (!isConnectionAvailable) {
        return const Left("Tidak ada jaringan internet.");
      }
      final response = await sendRequestFunction();
      return Right(response);
    } on DioException catch (e) {
      log("DIO ERROR: $e");
      if (e.response?.statusCode != null &&
          e.response?.data['message'] != null) {
        return Left(e.response!.data['message']);
      } else {
        return const Left("Terjadi kesalahan server.");
      }
    } catch (e) {
      log("ANY ERROR $e");
      return const Left("Terjadi kesalahan.");
    }
  }
}
