import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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

  @override
  void initState() {
    timer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox.fromSize(
          size: MediaQuery.of(context).size,
          child: Image.asset(
            'assets/splash/splash_background.png',
            colorBlendMode: BlendMode.darken,
            color: Colors.black.withOpacity(.3),
            fit: BoxFit.cover,
          ),
        ),
        //AnnouncementSlider(announcements: announcements),
      ],
    );
  }
}
