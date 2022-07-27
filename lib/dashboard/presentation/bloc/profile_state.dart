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
  final User user;
  const UpdatingProfile({
    required this.pageNum,
    required this.user,
  });

  @override
  // TODO: implement props
  List<Object> get props => super.props..addAll([pageNum, user]);
}

class ProfileUpdated extends ProfileState {}
