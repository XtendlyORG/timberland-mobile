// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/inherited_widgets/inherited_trail.dart';
import 'package:timberland_biketrail/core/presentation/widgets/timberland_scaffold.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/difficulty.dart';
import 'package:timberland_biketrail/features/trail/domain/entities/trail.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_details/trail_detail_bottom.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_details/trail_detail_top.dart';

class TrailDetails extends StatelessWidget {
  const TrailDetails({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Trail? trail = InheritedTrail.of(context).trail;
    trail ??= const Trail(
      trailId: '',
      trailName: '',
      difficulty: Difficulties.advanced,
      description: '',
      distance: 1,
      routeType: '',
      featureImageUrl: '',
      mapImageUrl: '',
      unit: 'm',
    );
    return DecoratedSafeArea(
      child: TimberlandScaffold(
        extendBodyBehindAppbar: true,
        physics: const NeverScrollableScrollPhysics(),
        backButtonColor: Theme.of(context).colorScheme.background,
        body: SizedBox(
          height: MediaQuery.of(context).size.height - kToolbarHeight,
          child: Stack(
            children: const [
              Align(
                alignment: Alignment.topCenter,
                child: TrailDetailTop(),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: TrailDetailBottom(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
