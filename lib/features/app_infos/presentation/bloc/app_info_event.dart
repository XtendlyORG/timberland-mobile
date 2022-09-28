// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'app_info_bloc.dart';

abstract class AppInfoEvent {
  const AppInfoEvent();
}

// class FetchTrailRulesEvent extends AppInfoEvent {
//   const FetchTrailRulesEvent();
// }

// class FetchFAQSEvent extends AppInfoEvent {
//   const FetchFAQSEvent();
// }

class SendInquiryEvent extends AppInfoEvent{
  final Inquiry inquiry;
  const SendInquiryEvent({
    required this.inquiry,
  });
}
