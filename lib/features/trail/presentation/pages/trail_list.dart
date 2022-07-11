import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timberland_biketrail/core/presentation/widgets/circular_icon_button.dart';
import 'package:timberland_biketrail/core/presentation/widgets/refreshable_scrollview.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/authentication/presentation/bloc/auth_bloc.dart';
import 'package:timberland_biketrail/features/trail/domain/usecases/fetch_trails.dart';
import 'package:timberland_biketrail/features/trail/presentation/bloc/trail_bloc.dart';
import 'package:timberland_biketrail/features/trail/presentation/widgets/trail_widget.dart';

class TrailList extends StatelessWidget {
  const TrailList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user =
        (BlocProvider.of<AuthBloc>(context).state as Authenticated).user;
    return RefreshableScrollView(
      onRefresh: () async {},
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: kToolbarHeight),
            child: AutoSizeText(
              'Trail List',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            alignment: Alignment.centerLeft,
            child: Text(
              "It's Time To Ride, ${user.firstName}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const TrailSearchBar(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.filter_alt_outlined,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Icon(
                    Icons.map_outlined,
                    color: Theme.of(context).disabledColor,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Flexible(
            // flex: FlexFit.loose,
            fit: FlexFit.loose,
            child: BlocBuilder<TrailBloc, TrailState>(
              builder: (context, state) {
                if (state is TrailInitial) {
                  BlocProvider.of<TrailBloc>(context).add(
                      FetchTrailsEvent(fetchTrailsParams: FetchTrailsParams()));
                }
                if (state is TrailsLoaded) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      // color: Colors.black,
                      gradient: LinearGradient(
                        colors: [
                          Theme.of(context).primaryColor.withOpacity(.05),
                          Colors.white.withOpacity(.04),
                          Colors.white.withOpacity(.8)
                        ],
                        stops: const [.6, .8, 1],
                      ),
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.trails.length,
                      padding: const EdgeInsets.all(15),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: TrailWidget(
                            trail: state.trails[index],
                          ),
                        );
                      },
                    ),
                  );
                }
                return const RepaintBoundary(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TrailSearchBar extends StatelessWidget {
  const TrailSearchBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final trailSearchCtrl = TextEditingController();
    return TextFormField(
      controller: trailSearchCtrl,
      validator: (val) {
        if (val == null || val.isEmpty) {
          return 'Field Cannot be empty';
        }
        return null;
      },
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        fillColor: TimberlandColor.primary.withOpacity(.05),
        hintText: 'Trail Name',
        prefixIcon: const Icon(
          Icons.search,
        ),
        prefixIconColor: Theme.of(context).disabledColor,
        suffixIcon: GestureDetector(
          onTap: () {},
          child: Stack(
            alignment: Alignment.center,
            children: const [
              Icon(Icons.circle),
              Icon(
                Icons.close,
                size: 16,
                color: TimberlandColor.text,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
