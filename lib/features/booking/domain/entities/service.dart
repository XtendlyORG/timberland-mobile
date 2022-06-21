// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Service extends Equatable {
  final String serviceId;
  final String serviceName;
  final double price;
  final int maxNumOfParticipants;
  const Service({
    required this.serviceId,
    required this.serviceName,
    required this.price,
    required this.maxNumOfParticipants,
  });
  @override
  List<Object?> get props => [
        serviceId,
        serviceName,
        price,
        maxNumOfParticipants,
      ];
}
