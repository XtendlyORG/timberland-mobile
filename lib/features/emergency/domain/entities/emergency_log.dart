// ignore_for_file: public_member_api_docs, sort_constructors_first
class EmergencyLog {
  final String memberID;
  final DateTime emergencyDate;
  final String firstName;
  final String lastName;
  final String emergencyContact;
  final String mobileNumber;
  final String? address;
  final String? bloodType;
  final DateTime? callStart;
  final DateTime? callEnd;
  final String? callStatus;
  EmergencyLog({
    required this.memberID,
    required this.emergencyDate,
    required this.firstName,
    required this.lastName,
    required this.emergencyContact,
    required this.mobileNumber,
    this.address,
    this.bloodType,
    this.callStart,
    this.callEnd,
    this.callStatus,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'member_id': double.parse(memberID),
      'emergency_date': dateToString(emergencyDate),
      'firstname': firstName,
      'lastname': lastName,
      'emergency_contact': emergencyContact,
      'mobile_number': mobileNumber,
      'address': address,
      'blood_type': bloodType,
      'call_start': callStart != null ? dateToTimeString(callStart!) : null,
      'call_end': callEnd != null ? dateToTimeString(callEnd!) : null,
      'call_status': callStatus,
    };
  }

  String dateToString(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  String dateToTimeString(DateTime date) {
    return '${date.hour}:${date.minute}:${date.second}';
  }
}
