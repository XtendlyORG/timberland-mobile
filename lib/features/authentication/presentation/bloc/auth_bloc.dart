// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages

import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/core/errors/failures.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/forgot_password.dart';
import 'package:timberland_biketrail/features/authentication/domain/params/params.dart';
import 'package:timberland_biketrail/features/authentication/domain/repositories/auth_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc({
    required this.repository,
  }) : super(const UnAuthenticated()) {
    on<FetchUserEvent>((event, emit) async {
      emit(
        const AuthLoading(loadingMessage: "Logging in to your account."),
      );
      emit(
        Authenticated(
          message: 'Logged In',
          user: Session().currentUser!,
        ),
      );
    });

    on<LockAuthEvent>((event, emit) {
      log(state.toString());
      if (Session().lockAuthUntil == null) {
        Session().lockAuth(duration: Duration(seconds: event.duration));
      }
      emit(
        AuthLocked(
          lockUntil: Session().lockAuthUntil!,
        ),
      );
    });

    on<UnlockAuthEvent>((event, emit) {
      Session().unlockAuth();
      emit(const UnAuthenticated(
        keepCurrentUser: true,
      ));
    });
    on<LoginEvent>((event, emit) async {
      emit(
        const AuthLoading(loadingMessage: "Logging in to your account."),
      );
      final result = await repository.login(event.loginParameter);
      result.fold(
        (failure) {
          if (failure is UnverifiedEmailFailure) {
            emit(
              OtpSent(
                parameter: RegisterParameter(
                  firstName: '',
                  lastName: '',
                  email: event.loginParameter.email,
                  mobileNumber: '',
                  password: event.loginParameter.password,
                ),
                message: 'Verify your email.',
              ),
            );
          } else {
            emit(AuthError(
              errorMessage: failure.message,
              penaltyDuration: failure.penaltyDuration,
            ));
          }
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
    on<ResendOTPEvent>((event, emit) async {
      final initState = state as OtpSent;
      final email = event.email;
      emit(
        AuthLoading(
          loadingMessage: 'Sending OTP to $email.',
        ),
      );
      final result = await repository.resendOtp(email);

      result.fold(
        (l) {
          emit(
            AuthError(
              errorMessage: l.message,
              parameter: event.parameter,
            ),
          );
          emit(initState);
        },
        (r) {
          emit(
            OtpResent(
              parameter: initState.parameter,
              message: "New OTP is sent to $email",
            ),
          );
        },
      );
    });

    on<RequestRegisterEvent>((event, emit) async {
      final email = event.parameter.email;
      emit(
        AuthLoading(
          loadingMessage: 'Sending OTP to $email.',
        ),
      );
      final result = await repository.requestRegister(
        event.parameter,
      );

      result.fold(
        (l) {
          emit(
            AuthError(
              errorMessage: l.message,
              parameter: event.parameter,
            ),
          );
          emit(OtpSent(
            hasError: true,
            parameter: event.parameter,
            message: "OTP is sent to $email",
          ));
        },
        (r) {
          emit(
            OtpSent(
              parameter: event.parameter,
              message: "OTP is sent to $email",
            ),
          );
        },
      );
    });

    on<VerifyRegisterEvent>((event, emit) async {
      emit(
        const AuthLoading(loadingMessage: "Creating your timberland account."),
      );
      final result = await repository.verifyOtp(
        event.parameter.email,
        event.otp,
      );
      result.fold(
        (failure) {
          emit(
            AuthError(
              errorMessage: failure.message,
              penaltyDuration: failure.penaltyDuration,
              parameter: event.parameter,
            ),
          );
          emit(
            OtpResent(
              parameter: event.parameter,
              message: failure.message,
            ),
          );
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

    on<VerifyForgotPasswordEvent>((event, emit) async {
      emit(const AuthLoading(loadingMessage: 'Validating OTP'));

      final result = await repository.verifyOtp(
        event.parameter,
        event.otp,
      );

      result.fold(
        (failure) {
          emit(
            AuthError(
              errorMessage: failure.message,
              penaltyDuration: failure.penaltyDuration,
              parameter: event.parameter,
            ),
          );
          emit(
            OtpResent(
              message: failure.message,
              parameter: event.parameter,
            ),
          );
        },
        (r) {
          emit(
            SettingNewPassword(
              email: event.parameter,
            ),
          );
        },
      );
    });

    on<ForgotPasswordEvent>((event, emit) async {
      final initState = state;
      final email = event.email;
      emit(
        AuthLoading(
          loadingMessage: 'Sending OTP to $email.',
        ),
      );
      final result = await repository.forgotPassword(
        email,
      );

      result.fold(
        (failure) {
          emit(
            AuthError(
              errorMessage: failure.message,
              penaltyDuration: failure.penaltyDuration,
              parameter: event.email,
            ),
          );
          emit(
            AuthError(
              errorMessage: failure.message,
              parameter: event.email,
            ),
          );
          emit(initState);
        },
        (r) {
          emit(
            OtpSent(
              parameter: event.email,
              message: "OTP is sent to $email",
            ),
          );
        },
      );
    });

    on<ResetPasswordEvent>((event, emit) async {
      emit(
        const AuthLoading(loadingMessage: 'Updating Password'),
      );
      final result = await repository.updatePassword(
        event.resetPasswordParameter.email,
        event.resetPasswordParameter.password,
      );

      result.fold(
        (l) {
          emit(AuthError(
            errorMessage: l.message,
            parameter: event.resetPasswordParameter,
          ));
        },
        (r) {
          emit(const PasswordUpdated());
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
      Authenticated initState = state as Authenticated;

      initState = initState.copyWith(firstTimeUser: false);

      if (event.skipBooking) {
        emit(Authenticated(
          message: 'User Guide Completed',
          user: initState.user,
        ));
      } else {
        emit(UserGuideFinished(
          message: 'User Guide Completed',
          user: initState.user,
        ));
      }
    });

    on<LogoutEvent>((event, emit) {
      Session().logout();
      emit(const UnAuthenticated());
    });

    on<UpdateUser>((event, emit) {
      final initState = state as Authenticated;
      emit(
        const AuthLoading(loadingMessage: 'Updating profile'),
      );
      emit(
        initState.copyWith(
          message: 'Profile Updated',
          user: event.newUser,
        ),
      );
    });

    on<DeleteAccountEvent>((event, emit) async {
      emit(
        const AuthLoading(
          loadingMessage: 'Deleting Account.',
        ),
      );

      final result = await repository.deleteProfile();

      result.fold(
        (failure) {
          emit(
            AuthError(
              errorMessage: failure.message,
              penaltyDuration: failure.penaltyDuration,
            ),
          );
        },
        (r) {
          emit(
            const AccountDeleted(),
          );
          Session().logout();
          emit(const UnAuthenticated());
        },
      );
    });
  }
}
