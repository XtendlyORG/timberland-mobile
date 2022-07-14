// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/constants/constants.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_details/trail_detail_bottom.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_details/trail_detail_top.dart';

class TrailDetails extends StatelessWidget {
  const TrailDetails({
    Key? key,
    required this.trail,
  }) : super(key: key);

  final Trail trail;

  @override
  Widget build(BuildContext context) {
    return TimberlandScaffold(
      extendBodyBehindAppbar: true,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: TrailDetailTop(trail: trail),
          ),
          Column(
            children: [
              const SizedBox(
                height: 300 - kHorizontalPadding,
              ),
              TrailDetailBottom(trail: trail),
            ],
          ),
        ],
      ),
    );
  }
}
