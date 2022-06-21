// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:timberland_biketrail/features/authentication/domain/entities/user.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/login.dart';
import 'package:timberland_biketrail/features/authentication/domain/usecases/register.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(UnAuthenticated()) {
    on<AuthEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<LoginEvent>((event, emit) {
      // TODO: implement event handler
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
