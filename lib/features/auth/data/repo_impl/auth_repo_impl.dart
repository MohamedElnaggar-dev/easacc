import 'package:dartz/dartz.dart';
import 'package:easacc_app/core/utils/error_handeling/custom_excption.dart';
import 'package:easacc_app/core/utils/error_handeling/failure.dart';
import 'package:easacc_app/features/auth/data/services/firebase_auth_service.dart';
import 'package:easacc_app/features/auth/domain/repo/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService _firebaseAuthService;

  AuthRepoImpl(this._firebaseAuthService);

  @override
  Future<Either<CustomFailure, Unit>> signInWithFacebook() async {
    try {
      await _firebaseAuthService.signInWithFacebook();
      return Right(unit);
    } on CustomException catch (e) {
      return Left(CustomFailure(errMessage: e.errMessage));
    }
  }

  @override
  Future<Either<CustomFailure, Unit>> signInWithGoogle() async {
    try {
      await _firebaseAuthService.signInWithGoogle();
      return Right(unit);
    } on CustomException catch (e) {
      return Left(CustomFailure(errMessage: e.errMessage));
    }
  }
}
