// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class UpdatingProfile extends ProfileState {
  final int pageNum;
  final UpdateProfileParams updatedUser;

  const UpdatingProfile({
    required this.pageNum,
    required this.updatedUser,
  });

  @override
  List<Object> get props => super.props..addAll([pageNum, updatedUser]);
}

class ProfileUpdateRequestSent extends ProfileState {
  final String loadingMessage;
  const ProfileUpdateRequestSent({
    required this.loadingMessage,
  });
  @override
  List<Object> get props => super.props..add(loadingMessage);
}

class ProfileUpdateError extends ProfileState {
  final String errorMessage;
  const ProfileUpdateError({
    required this.errorMessage,
  });
  @override
  List<Object> get props => super.props..add(errorMessage);
}

class ProfileUpdated extends ProfileState {
  final User user;
  const ProfileUpdated({
    required this.user,
  });
  @override
  List<Object> get props => super.props..add(user);
}
