// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore: depend_on_referenced_packages

import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/core/utils/session.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
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
      final result = await repository.sendOtp(event.registerParameter);
      result.fold(
        (l) {
          emit(
            AuthError(
              errorMessage: l.message,
            ),
          );
        },
        (r) {
          emit(OtpSent(
            registerParameter: event.registerParameter,
            message: "OTP is sent to ${event.registerParameter.email}",
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
      Authenticated _state = (state as Authenticated);

      _state = _state.copyWith(firstTimeUser: false);

      emit(_state);
      emit(UserGuideFinished(
        message: 'User Guide Completed',
        user: _state.user,
      ));
    });

    on<LogoutEvent>((event, emit) {
      Session().logout();
      emit(const UnAuthenticated());
    });
  }
}
