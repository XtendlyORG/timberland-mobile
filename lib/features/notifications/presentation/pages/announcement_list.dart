import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:go_router/go_router.dart';
import 'package:timberland_biketrail/core/presentation/widgets/decorated_safe_area.dart';
import 'package:timberland_biketrail/core/presentation/widgets/state_indicators/state_indicators.dart';
import 'package:timberland_biketrail/core/router/router.dart';
import 'package:timberland_biketrail/features/booking/data/models/announcement_model.dart';
import 'package:timberland_biketrail/features/notifications/presentation/bloc/notifications_bloc.dart';
import 'package:timberland_biketrail/features/notifications/presentation/widgets/announcement_widget.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/presentation/widgets/timberland_scaffold.dart';

class AnnouncementListPage extends StatelessWidget {
  const AnnouncementListPage({
    Key? key,
    this.notifId
  }) : super(key: key);

  final String? notifId;

  @override
  Widget build(BuildContext context) {
    final notificationsBloc = BlocProvider.of<NotificationsBloc>(context);
    return Stack(
            children: [
              // UseFathom().webViewAnalytics(route: routeState.location),
              InAppWebView(
                initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse('https://timberland.xtendly.com/mobile-analytics/dev-mode/announcements-list'))),
                onWebViewCreated: (webViewController) async {
                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
                  // await webViewController.runJavascript('''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'CKWVTEIX');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');

                  // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
                  // await webViewController.evaluateJavascript(source:'''
                  //   var script = document.createElement('script');
                  //   script.src = 'https://cdn.usefathom.com/script.js';
                  //   script.setAttribute('data-site', 'VTLWLMFB');
                  //   script.defer = true;
                  //   document.head.appendChild(script);
                  // ''');
                  debugPrint('Executed javascript ${DateTime.now()} https://timberland.xtendly.com/mobile-analytics/dev-mode/announcements-list');
                }
              ),
              // WebView(
              //   initialUrl: 'https://timberland.xtendly.com/mobile-analytics/dev-mode/announcements-list',
              //   javascriptMode: JavascriptMode.unrestricted,
              //   onWebViewCreated: (WebViewController webViewController) async {
              //     // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
              //     // await webViewController.runJavascript('''
              //     //   var script = document.createElement('script');
              //     //   script.src = 'https://cdn.usefathom.com/script.js';
              //     //   script.setAttribute('data-site', 'CKWVTEIX');
              //     //   script.defer = true;
              //     //   document.head.appendChild(script);
              //     // ''');

              //     // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
              //     await webViewController.runJavascript('''
              //       var script = document.createElement('script');
              //       script.src = 'https://cdn.usefathom.com/script.js';
              //       script.setAttribute('data-site', 'VTLWLMFB');
              //       script.defer = true;
              //       document.head.appendChild(script);
              //     ''');
              //     debugPrint('Executed javascript ${DateTime.now()} https://timberland.xtendly.com/mobile-analytics/dev-mode/announcements-list');
              // }),
              Container(
                color: Colors.white,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
              ),
        BlocConsumer<NotificationsBloc, NotificationsState>(
          bloc: notificationsBloc..add(FetchLatestAnnouncement()),
          listener: (context, state) {
            if(state is AnnouncementRecieved){
              //
            }
          },
          builder: (context, state) {
            if(state is AnnouncementRecieved && state.announcementsList.isNotEmpty){
              
              SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
                if(notifId != null){
                  List<AnnouncementModel> templist = state.announcementsList.where((notif) => notif.id.toString() == notifId).toList();
                  AnnouncementModel? tempData = templist.isNotEmpty
                    ? templist.first
                    : null;
                  if(tempData != null){
                    context.pushNamed(
                      Routes.announcementsView.name,
                      extra: tempData // AnnouncementModel()
                    );
                  }else{
                    showError("Failed to view announcement");
                  }
                }
              });

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
                                const SizedBox(
                                  height: 150,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AutoSizeText(
                                      "No announcements to show",
                                      minFontSize: Theme.of(context).textTheme.titleSmall!.fontSize!,
                                      style: Theme.of(context).textTheme.titleSmall,
                                      textAlign: TextAlign.left,
                                    ),
                                  ],
                                ),
                              ],
                            )
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
          ),
      ],
    );
  }
}
