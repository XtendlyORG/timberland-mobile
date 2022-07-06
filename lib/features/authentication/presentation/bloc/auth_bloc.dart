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
          ),
        ),
      );
    });

    on<LoginEvent>((event, emit) {
      emit(
        Authenticated(
          user: User(
            age: 19,
            email: event.loginParameter.email,
            firstName: 'FirstName',
            lastName: 'LastName',
            id: 'test-uid',
          ),
        ),
      );
    });

    on<RegisterEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<GoogleAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<FacebookAuthEvent>((event, emit) {
      // TODO: implement event handler
    });
    on<LogoutEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
