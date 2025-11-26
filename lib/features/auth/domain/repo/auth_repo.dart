import 'package:dartz/dartz.dart';
import 'package:easacc_app/core/utils/error_handler/failure.dart';

abstract class AuthRepo {
  Future<Either<CustomFailure, Unit>> signInWithGoogle();
  Future<Either<CustomFailure, Unit>> signInWithFacebook();
}
