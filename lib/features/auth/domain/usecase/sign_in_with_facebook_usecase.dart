import 'package:dartz/dartz.dart';
import 'package:easacc_app/core/utils/error_handeling/failure.dart';
import 'package:easacc_app/features/auth/domain/repo/auth_repo.dart';

class SignInWithFacebookUseCase {
  final AuthRepo authRepo;
  SignInWithFacebookUseCase({required this.authRepo});

  Future<Either<CustomFailure, Unit>> call() => authRepo.signInWithFacebook();
}
