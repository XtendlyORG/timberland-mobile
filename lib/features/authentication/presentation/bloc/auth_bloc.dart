// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages

import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
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
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });

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
        Session().lockAuth(duration: const Duration(seconds: 60));
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
                parameter: event.loginParameter,
                message: 'Verify your email.',
              ),
            );
          } else {
            emit(AuthError(errorMessage: failure.message));
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

    on<SendOtpEvent>((event, emit) async {
      String email;
      Either result;
      if (event.parameter is RegisterParameter) {
        email = (event.parameter as RegisterParameter).email;
        emit(
          AuthLoading(
            loadingMessage: 'Sending OTP to $email.',
          ),
        );
        result = await repository.sendOtp(
          event.parameter,
          resending: event.resending,
        );
      } else if (event.parameter is String) {
        email = event.parameter;
        emit(
          AuthLoading(
            loadingMessage: 'Sending OTP to $email.',
          ),
        );
        result = await repository.forgotPassword(
          event.parameter,
          resending: event.resending,
        );
      } else {
        throw Exception(
          "Event Parameter is ${event.parameter.runtimeType}, and not a valid parameter",
        );
      }
      result.fold(
        (l) {
          emit(
            AuthError(
              errorMessage: l.message,
              parameter: event.parameter,
            ),
          );
        },
        (r) {
          log('otp sent as');
          emit(OtpSent(
            parameter: event.parameter,
            message: event.resending
                ? 'New OTP is sent to $email'
                : "OTP is sent to $email",
          ));
        },
      );
    });

    on<RegisterEvent>((event, emit) async {
      emit(
        const AuthLoading(loadingMessage: "Creating your timberland account."),
      );
      final result = await repository.register(event.registerParameter);
      result.fold(
        (failure) {
          emit(
            OtpSent(
              parameter: event.registerParameter,
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

    on<ForgotPasswordEvent>((event, emit) async {
      emit(const AuthLoading(loadingMessage: 'Sending OTP to your email'));

      final result = await repository.forgotPasswordEmailVerification(
        event.forgotPasswordParameter.email,
        event.forgotPasswordParameter.otp,
      );

      result.fold(
        (l) {
          emit(AuthError(
            errorMessage: l.message,
            parameter: event.forgotPasswordParameter.email,
          ));
        },
        (r) {
          emit(
            SettingNewPassword(
              email: event.forgotPasswordParameter.email,
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
      Authenticated _state = (state as Authenticated);

      _state = _state.copyWith(firstTimeUser: false);

      emit(_state);

      if (event.skipBooking) {
        emit(Authenticated(
          message: 'User Guide Completed',
          user: _state.user,
        ));
      } else {
        emit(UserGuideFinished(
          message: 'User Guide Completed',
          user: _state.user,
        ));
      }
    });

    on<LogoutEvent>((event, emit) {
      Session().logout();
      emit(const UnAuthenticated());
    });

    on<UpdateUser>((event, emit) {
      final _state = state as Authenticated;
      emit(
        const AuthLoading(loadingMessage: 'Updating profile'),
      );
      emit(
        _state.copyWith(
          message: 'Profile Updated',
          user: event.newUser,
        ),
      );
    });
  }
}
