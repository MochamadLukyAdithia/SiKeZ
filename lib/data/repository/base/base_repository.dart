import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class BaseRepository {
  final FirebaseFirestore firestore;

  BaseRepository({
    required this.firestore,
  });

  Future<Either<String, T>> sendRequest<T>(
    Future<T> Function() sendRequestFunction,
  ) async {
    try {
      final response = await sendRequestFunction();
      return Right(response);
    } on FirebaseException catch (firebaseError) {
      log("Firebase Exception: $firebaseError");
      return Left(firebaseError.message ?? 'Terdapat kesalahan server.');
    } catch (error) {
      log("Any Exception: $error");
      return const Left("Terjadi kesalahan.");
    }
  }
}
