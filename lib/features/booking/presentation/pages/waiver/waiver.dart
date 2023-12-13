// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';
import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_checkbox.dart';
import 'package:timberland_biketrail/core/presentation/widgets/custom_styled_text.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/presentation/widgets/widgets.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/pages/trail_rules.dart';
import 'package:timberland_biketrail/features/booking/domain/params/booking_request_params.dart';
import 'package:timberland_biketrail/features/booking/presentation/bloc/booking_bloc.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/waiver/pdf_repository.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/waiver/pdf_view_page.dart';
import 'package:timberland_biketrail/features/booking/presentation/pages/waiver/waiver_content.dart';

class BookingWaiver extends StatefulWidget {
  final BookingRequestParams bookingRequestParams;
  const BookingWaiver({
    Key? key,
    required this.bookingRequestParams,
  }) : super(key: key);

  @override
  State<BookingWaiver> createState() => _BookingWaiverState();
}

class _BookingWaiverState extends State<BookingWaiver> {
  bool waiverAccepted = false;
  bool codeOfResponsibilityAccepted = false;
  bool conditionsForEntryAccepted = false;
  @override
  Widget build(BuildContext context) {
    return DecoratedSafeArea(
      child: TimberlandScaffold(
        titleText: 'Waiver',
        extendBodyBehindAppbar: true,
        index: 2,
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: kVerticalPadding,
            vertical: kHorizontalPadding,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: TimberlandColor.linearGradient,
                ),
                child: ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      child: CustomStyledText(
                        text: waiverContent(
                          '${widget.bookingRequestParams.firstName} ${widget.bookingRequestParams.lastName}',
                        ),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: kVerticalPadding,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomCheckbox(
                          onChange: (val) async {
                            waiverAccepted = val;
                            if (val == true) {
                              const path = 'assets/privacy_policy/ChromaWebsite-PrivacyPolicy.pdf';
                              final file = await PDFRepository.loadAsset(path);

                              openPDF(context, file);
                            }
                          },
                          child: Text.rich(
                            TextSpan(
                              text: 'I agree to the ',
                              style: Theme.of(context).textTheme.labelLarge,
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      const path = 'assets/privacy_policy/ChromaWebsite-PrivacyPolicy.pdf';
                                      final file = await PDFRepository.loadAsset(path);

                                      openPDF(context, file);
                                    },
                                  text: 'Privacy Policy',
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ],
                            ),
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomCheckbox(
                          onChange: (val) async {
                            conditionsForEntryAccepted = val;
                            if (val == true) {
                              const path = 'assets/trail_map/CONDITIONSFORENTRY2023.10.09-FINAL.pdf';
                              final file = await PDFRepository.loadAsset(path);

                              openPDF(context, file);
                            }
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'I have read the ',
                              style: Theme.of(context).textTheme.labelLarge,
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      const path = 'assets/trail_map/CONDITIONSFORENTRY2023.10.09-FINAL.pdf';
                                      final file = await PDFRepository.loadAsset(path);

                                      openPDF(context, file);
                                    },
                                  text: "Conditions for Entry to TMBP",
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomCheckbox(
                          onChange: (val) async {
                            codeOfResponsibilityAccepted = val;
                            if (val == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const TrailRulesPage(
                                            canPop: true,
                                          )));
                            }
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'I have read, understood and agree to follow \nthe',
                              style: Theme.of(context).textTheme.labelLarge,
                              children: <TextSpan>[
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => const TrailRulesPage(
                                                    canPop: true,
                                                  )));
                                    },
                                  text: " Mountain Biker's Responsibility Code",
                                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                                        color: Theme.of(context).primaryColor,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: FilledTextButton(
                  onPressed: () {
                    if (waiverAccepted && codeOfResponsibilityAccepted && conditionsForEntryAccepted) {
                      BlocProvider.of<BookingBloc>(context).add(
                        SubmitBookingRequest(params: widget.bookingRequestParams),
                      );
                      return;
                    }
                    showToast('Must accept all terms and conditions.');
                  },
                  child: const Text("Submit"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void openPDF(BuildContext context, File file) => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PDFViewPage(file: file)),
      );
}
