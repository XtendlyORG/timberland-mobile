import 'package:webview_flutter/webview_flutter.dart';

class useFathom {
  // Future<WebViewController> getWebviewController() async {
  //   WebViewController controller = WebViewController();

  //             controller = WebViewController()
  //               ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //               ..setBackgroundColor(const Color(0x00000000))
  //               ..addJavaScriptChannel("myChannel", onMessageReceived: (JavaScriptMessage message) {
  //                 setMessage(message.message);
  //               })
  //               ..setNavigationDelegate(
  //                 NavigationDelegate(
  //                   onProgress: (int progress) {
  //                     // Update loading bar.
  //                   },
  //                   onPageStarted: (String url) {},
  //                   onPageFinished: (String url) {
  //                     injectJavascript(controller);
  //                   },
  //                   onWebResourceError: (WebResourceError error) {},
  //                   onNavigationRequest: (NavigationRequest request) {
  //                     if (request.url.startsWith('https://www.youtube.com/')) {
  //                       return NavigationDecision.prevent;
  //                     }
  //                     return NavigationDecision.navigate;
  //                   },
  //                 ),
  //               )
  //               ..loadRequest(Uri.parse('https://prosperna.com/support/'));
  // }
}