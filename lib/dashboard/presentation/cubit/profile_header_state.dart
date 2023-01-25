// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_header_cubit.dart';

abstract class ProfileHeaderState extends Equatable {
  const ProfileHeaderState();

  @override
  List<Object> get props => [];
}

class ProfileHeaderInitial extends ProfileHeaderState {}

class ProfileHeaderError extends ProfileHeaderState {}

class ProfileHeadersLoaded extends ProfileHeaderState {
  final List<String> profileHeaders;
  const ProfileHeadersLoaded({
    this.profileHeaders = const [],
  });

  @override
  List<Object> get props => super.props..addAll(profileHeaders);
}
