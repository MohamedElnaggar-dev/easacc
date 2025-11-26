import 'package:easacc_app/core/utils/error_handeling/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<CustomFailure, Unit>> signInWithGoogle();
  Future<Either<CustomFailure, Unit>> signInWithFacebook();
}
