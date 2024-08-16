import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/dependency_injection/notifs_dependency.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:timberland_biketrail/features/notifications/presentation/pages/announcement_page.dart';

import '../../../../core/router/routes.dart';

class AnnouncementPage2 extends StatefulWidget {
  const AnnouncementPage2({Key? key}) : super(key: key);

  @override
  _AnnouncementPage2State createState() => _AnnouncementPage2State();
}

class _AnnouncementPage2State extends State<AnnouncementPage2> {
  void timer() async {
    await Future.delayed(const Duration(seconds: 2));
    context.goNamed(Routes.home.name);
  }

  late NotificationsBloc notificationsBloc;

  @override
  void initState() {
    // timer();
    notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationsBloc, NotificationsState>(
      bloc: notificationsBloc..add(FetchLatestAnnouncement()),
      listener: (context, state) {
        if(state is AnnouncementRecieved){
          //
        }
      },
      builder: (context, state) {
        if(state is AnnouncementRecieved && state.announcementsList.isNotEmpty){
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox.fromSize(
                size: MediaQuery.of(context).size,
                child: Image.asset(
                  // 'assets/splash/announcement_background.png',
                  'assets/splash/splash_background.png',
                  colorBlendMode: BlendMode.darken,
                  color: Colors.black.withOpacity(.3),
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox.fromSize(
                size: MediaQuery.of(context).size,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: AnnouncementSlider(announcements: state.announcementsList),
                ),
              ),
            ],
          );
        }else if(state is AnnouncementRecieved && state.announcementsList.isEmpty){
          SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
            timer();
          });

          return Stack(
            alignment: Alignment.center,
            children: const [
              CircularProgressIndicator.adaptive()
            ],
          );
        }

        return Stack(
          alignment: Alignment.center,
          children: const [
            CircularProgressIndicator.adaptive()
          ],
        );
      }
    );
  }
}
