import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/dependency_injection/notifs_dependency.dart';
import 'package:timberland_biketrail/features/app_infos/presentation/widgets/faq_widget.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:timberland_biketrail/features/notifications/presentation/widgets/announcement_widget.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/timberland_scaffold.dart';

class AnnouncementListPage extends StatelessWidget {
  const AnnouncementListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
    return BlocConsumer<NotificationsBloc, NotificationsState>(
      bloc: notificationsBloc..add(FetchLatestAnnouncement()),
      listener: (context, state) {
        if(state is AnnouncementRecieved){
          //
        }
      },
      builder: (context, state) {
        if(state is AnnouncementRecieved && state.announcementsList.isNotEmpty){
          return DecoratedSafeArea(
            child: TimberlandScaffold(
              titleText: 'Announcement',
              extendBodyBehindAppbar: true,
              body: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox.fromSize(
                    size: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height - 200
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                      ),
                      child: RefreshIndicator(
                        onRefresh: () async {
                          notificationsBloc.add(FetchLatestAnnouncement());
                        },
                        child: ListView(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20
                          ),
                          children: [
                            ...state.announcementsList.map((e) => Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: AnnouncementWidget(
                                    data: e,
                                  ),
                                )),
                          ],
                        )
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }else if(state is AnnouncementRecieved && state.announcementsList.isEmpty){
          return DecoratedSafeArea(
            child: TimberlandScaffold(
              titleText: 'Announcement',
              extendBodyBehindAppbar: true,
              body: Column(
                children: [
                  const SizedBox(height: kVerticalPadding),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                        vertical: kVerticalPadding * 3,
                      ),
                      child: LiveList.options(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        options: const LiveOptions(
                          showItemInterval: Duration(milliseconds: 100),
                          visibleFraction: 0.05,
                        ),
                        shrinkWrap: true,
                        itemCount: state.announcementsList.length,
                        physics: const NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.zero,
                        itemBuilder: (context, index, animation) {
                          return FadeTransition(
                            opacity: Tween<double>(
                              begin: 0,
                              end: 1,
                            ).animate(animation),
                            child: SlideTransition(
                              position: Tween<Offset>(
                                begin: const Offset(-.5, 0),
                                end: Offset.zero,
                              ).animate(animation),
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: AnnouncementWidget(
                                  data: state.announcementsList[index],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return DecoratedSafeArea(
            child: TimberlandScaffold(
              titleText: 'Announcement',
              extendBodyBehindAppbar: true,
              body: Column(
                children: const [
                  SizedBox(height: kVerticalPadding),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: kHorizontalPadding,
                        vertical: kVerticalPadding * 3,
                      ),
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      );
  }
}
