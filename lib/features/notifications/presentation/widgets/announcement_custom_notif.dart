import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:timberland_biketrail/core/themes/timberland_color.dart';

class TMBPModal {
  static void notificationModal({
    required BuildContext ctx,
    String? textTitle,
    String? textContent,
  }) async {

    Size size = MediaQuery.of(ctx).size;
    Timer tempTimer = Timer(const Duration(seconds: 5), () {});
    bool? dismissed = await showDialog(
      context: ctx,
      barrierColor: Colors.black54.withOpacity(0.5),
      barrierDismissible: true,
      builder: (BuildContext _) {

        void onClose() {
          if(_.mounted){
            Navigator.pop(_, true);
          }
        }

        tempTimer = Timer(const Duration(seconds: 3), () {
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
}