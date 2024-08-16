import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timberland_biketrail/core/router/routes.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';
import 'package:timberland_biketrail/features/notifications/presentation/pages/announcement_view.dart';

class TMBPModal {
  static void notificationModal({
    required BuildContext ctx,
    String? textTitle,
    String? textContent,
  }) async {

    // Issue on yexy Field Focus
    Size size = MediaQuery.of(ctx).size;
    Timer tempTimer = Timer(const Duration(seconds: 2), () {});
    bool? dismissed = await showDialog(
      context: ctx,
      barrierColor: Colors.black54.withOpacity(0.5),
      barrierDismissible: false,
      builder: (BuildContext _) {

        void onClose() {
          if(_.mounted){
            Navigator.pop(_, true);
          }
        }

        tempTimer = Timer(const Duration(seconds: 2), () {
          tempTimer.cancel();
          onClose();
        });

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {

            SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
              // onNotif();
            });

            return AlertDialog(
              alignment: Alignment.topCenter,
              surfaceTintColor: Colors.transparent,
              shadowColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(0),
              actionsAlignment: MainAxisAlignment.center,
              content: GestureDetector(
                onTap: (){
                  tempTimer.cancel();
                  Navigator.pop(_, true);

                  // Navigate to view
                  GetIt.instance<GoRouter>().pushNamed(Routes.announcementsList.name);

                  // View Notif
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (BuildContext context) {
                  //       return const AnnouncementViewPage(
                  //         title: "",
                  //         description: "",
                  //         imagePath: "",
                  //       );
                  //     },
                  //   ),
                  // );
                },
                child: Container(
                  //alignment: Alignment.topCenter,
                  constraints: BoxConstraints(minWidth: size.width - 48),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/logo-icon.png',
                            width: 36,
                            height: 36
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "Timberland",
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                color: Colors.black, // TimberlandColor.primary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ]
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textTitle ?? "You've received a notification.",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    color: TimberlandColor.primary,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                Text(
                                  textContent ?? "Tap to open...",
                                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontSize: 14,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Image.asset(
                            'assets/icons/checkout-icon.png',
                            width: 36,
                            height: 36
                          ),
                        ]
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );

    if (dismissed == null) {
      tempTimer.cancel();
    }
  }

  static void notificationToast({
    required BuildContext ctx,
    String? textTitle,
    String? textContent,
  }) async {

    Size size = MediaQuery.of(ctx).size;

    Widget toastBody = GestureDetector(
      onTap: () async {
        // Navigate to view
        // obtain shared preferences
        final prefs = await SharedPreferences.getInstance();
        final notifId = prefs.getString('firebase-notif-id') ?? '';
        await prefs.setString('firebase-notif-id', '');
        GetIt.instance<GoRouter>().pushNamed(
          Routes.announcementsList.name,
          extra: notifId
        );

        // View Notif
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) {
        //       return const AnnouncementViewPage(
        //         title: "",
        //         description: "",
        //         imagePath: "",
        //       );
        //     },
        //   ),
        // );
      },
      child: Container(
        //alignment: Alignment.topCenter,
        constraints: BoxConstraints(minWidth: size.width - 48),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
          border: Border.all(color: Colors.grey.withOpacity(0.5)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Semi-transparent gray
              blurRadius: 5.0,
              offset: const Offset(2.0, 5.0), // Shadow slightly down and to the right
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Image.asset('assets/icons/logo-icon.png', width: 36, height: 36),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Text(
                  "Timberland",
                  style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                      color: Colors.black, // TimberlandColor.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.left,
                ),
              ),
            ]),
            const SizedBox(
              height: 10,
            ),
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              Expanded(
                  child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    textTitle ?? "You've received a notification.",
                    style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                        color: TimberlandColor.primary,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    textContent ?? "Tap to open...",
                    style: Theme.of(ctx).textTheme.titleMedium?.copyWith(
                          fontSize: 14,
                        ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    textAlign: TextAlign.left,
                  ),
                ],
              )),
              const SizedBox(
                width: 20,
              ),
              Image.asset('assets/icons/checkout-icon.png',
                  width: 36, height: 36),
            ]),
          ],
        ),
      ),
    );
    
    FToast fToast = FToast();
    fToast.init(ctx);

    fToast.showToast(
      child: toastBody,
      //positionedToastBuilder: (context, child) => toast,
      gravity: ToastGravity.TOP,
      toastDuration: const Duration(seconds: 2),
    );
  }
}