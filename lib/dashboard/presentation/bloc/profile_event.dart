// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final User user;
  const UpdateProfileEvent({
    required this.user,
  });
}

class NavigateToNextPage extends ProfileEvent {
  final User user;
  const NavigateToNextPage({
    required this.user,
  });
}

class SubmitUpdateRequestEvent extends ProfileEvent {}
