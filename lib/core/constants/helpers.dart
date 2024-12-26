import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:webview_flutter/webview_flutter.dart';

class UseFathom {
  WebView webViewAnalytics({
    required String route
  }) {
    // Temporary domain for html
    String initialUrlPath = (dotenv.env['API_URL']?.contains("api.timberlandresort.com") ?? false)
        ? 'https://timberland.xtendly.com/mobile-analytics$route'
        : 'https://management.timberlandresort.com/mobile-analytics$route';
    
    return WebView(
      initialUrl: initialUrlPath,
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) async {
        // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="CKWVTEIX" defer></script>');
        // await webViewController.runJavascript('<script src="https://cdn.usefathom.com/script.js" data-site="VTLWLMFB" defer></script>');
        
        // Perform custom script
        // Fathom Analytics Script
        await webViewController.runJavascript('''
          var script = document.createElement('script');
          script.src = 'https://cdn.usefathom.com/script.js';
          script.setAttribute('data-site', ${dotenv.env['FATHOM_TRACKING_ID'] ?? "VTLWLMFB"});
          script.defer = true;
          document.head.appendChild(script);
        ''');
        debugPrint('Executed javascript ${DateTime.now()} $initialUrlPath');
    });
  }
}