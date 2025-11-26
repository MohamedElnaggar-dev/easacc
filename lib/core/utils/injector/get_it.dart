import 'package:easacc_app/features/auth/data/repo_impl/auth_repo_impl.dart';
import 'package:easacc_app/features/auth/data/services/firebase_auth_service.dart';
import 'package:easacc_app/features/auth/domain/repo/auth_repo.dart';
import 'package:easacc_app/features/auth/domain/usecase/sign_in_with_facebook_usecase.dart';
import 'package:easacc_app/features/auth/domain/usecase/sign_in_with_google_usecase.dart';
import 'package:easacc_app/features/auth/presentation/manger/signin_cubit/signin_cubit.dart';
import 'package:get_it/get_it.dart';

final injector = GetIt.instance;

Future<void> setupLocator() async {
  /// Services

  injector.registerLazySingleton<FirebaseAuthService>(
    () => FirebaseAuthService(),
  );

  ///  Repositories
  injector.registerLazySingleton<AuthRepo>(
    () => AuthRepoImpl(injector<FirebaseAuthService>()),
  );

  /// useCases
  injector.registerLazySingleton<SignInWithFacebookUseCase>(
    () => SignInWithFacebookUseCase(authRepo: injector<AuthRepo>()),
  );
  injector.registerLazySingleton<SignInWithGoogleUseCase>(
    () => SignInWithGoogleUseCase(authRepo: injector<AuthRepo>()),
  );

  /// Blocs / Cubits
  injector.registerFactory<SigninCubit>(
    () => SigninCubit(
      injector<SignInWithFacebookUseCase>(),
      injector<SignInWithGoogleUseCase>(),
    ),
  );
}
