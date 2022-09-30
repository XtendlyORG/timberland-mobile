// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'emergency_bloc.dart';

abstract class EmergencyState extends Equatable {
  const EmergencyState();
  
  @override
  List<Object> get props => [];
}

class EmergencyInitial extends EmergencyState {}


class EmergencyTokenFetched extends EmergencyState {
  final EmergencyConfigs configs;
  const EmergencyTokenFetched({
    required this.configs,
  });
}
