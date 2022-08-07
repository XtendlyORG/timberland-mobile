// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateProfileEvent extends ProfileEvent {
  final UpdateProfileParams user;
  const UpdateProfileEvent({
    required this.user,
  });
}

class CancelUpdateRequest extends ProfileEvent {
  const CancelUpdateRequest();
}

class NavigateToNextPage extends ProfileEvent {
  final UpdateProfileParams updatedUser;

  const NavigateToNextPage({
    required this.updatedUser,
  });
}

class SubmitUpdateRequestEvent extends ProfileEvent {
  final UpdateProfileParams updateProfileParams;
  const SubmitUpdateRequestEvent({
    required this.updateProfileParams,
  });
  @override
  List<Object> get props => super.props..add(updateProfileParams);
}
