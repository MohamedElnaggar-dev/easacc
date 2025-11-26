import 'package:easacc_app/features/auth/domain/usecase/sign_in_with_facebook_usecase.dart';
import 'package:easacc_app/features/auth/domain/usecase/sign_in_with_google_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SigninState> {
  SigninCubit(this.signInWithFacebookUseCase, this.signInWithGoogleUseCase)
    : super(SigninInitial());
  final SignInWithFacebookUseCase signInWithFacebookUseCase;
  final SignInWithGoogleUseCase signInWithGoogleUseCase;

  Future<void> signInWithGoogle() async {
    emit(SigninLoading());
    final result = await signInWithGoogleUseCase();
    result.fold(
      (failure) => emit(SigninFailure(errorMessage: failure.errMessage)),
      (_) => emit(SigninSuccess()),
    );
  }

  Future<void> signInWithFacebook() async {
    emit(SigninLoading());
    final result = await signInWithFacebookUseCase();
    result.fold(
      (failure) => emit(SigninFailure(errorMessage: failure.errMessage)),
      (_) => emit(SigninSuccess()),
    );
  }
}
