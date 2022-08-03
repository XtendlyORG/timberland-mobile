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
  // TODO: implement props
  List<Object> get props => super.props..addAll([pageNum, updatedUser]);
}

class ProfileUpdated extends ProfileState {}
