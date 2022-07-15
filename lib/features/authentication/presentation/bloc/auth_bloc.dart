// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/usecases.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FacebookAuth facebookAuth;
  final GoogleAuth googleAuth;
  final Login login;
  final Logout logout;
  final Register register;
  final ResetPassword resetPassword;
  final ForgotPassword forgotPassword;

  AuthBloc({
    required this.facebookAuth,
    required this.googleAuth,
    required this.login,
    required this.logout,
    required this.register,
    required this.resetPassword,
    required this.forgotPassword,
  }) : super(const UnAuthenticated()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<FetchUserEvent>((event, emit) {
      emit(
        Authenticated(
          user: User(
            age: 19,
            email: 'test_email',
            firstName: 'FirstName',
            lastName: 'LastName',
            id: event.uid,
            accessCode: "Test Access Code",
          ),
          message: 'Logged In',
        ),
      );
    });

    on<LoginEvent>((event, emit) async {
      emit(
        const AuthLoading(loadingMessage: "Logging in to your account."),
      );
      final result = await login(event.loginParameter);
      result.fold(
        (failure) {
          emit(AuthError(errorMessage: failure.message));
        },
        (user) {
          emit(
            Authenticated(
              user: user,
              message: 'Welcome back ${user.firstName}',
            ),
          );
        },
      );
    });

    on<SendOtpEvent>((event, emit) async {
      emit(
        AuthLoading(
          loadingMessage: 'Sending Otp to ${event.registerParameter.email}.',
        ),
      );
      await Future.delayed(
        const Duration(seconds: 1),
        () => emit(OtpSent(registerParameter: event.registerParameter)),
      );
    });

    on<RegisterEvent>((event, emit) async {
      emit(
        const AuthLoading(loadingMessage: "Creating your timberland account."),
      );
      final result = await register(event.registerParameter);
      result.fold(
        (failure) {
          emit(AuthError(errorMessage: failure.message));
        },
        (user) {
          emit(
            Authenticated(
              user: user,
              message: 'Welcome to Timberland, ${user.firstName}',
              firstTimeUser: true,
            ),
          );
        },
      );
    });

    on<GoogleAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FacebookAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FinishUserGuideEvent>((event, emit) {
      emit(
        Authenticated(
          message: "Finished Beginner's Guide",
          user: (state as Authenticated).user,
          firstTimeUser: false,
        ),
      );
    });

    on<LogoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
