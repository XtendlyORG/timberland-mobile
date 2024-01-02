import UIKit
import Flutter

public class SwiftClearAppDataPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "your_channel_name", binaryMessenger: registrar.messenger())
        let instance = SwiftClearAppDataPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        if call.method == "clearAppData" {
            clearUserDefaults()
            result(nil)
        } else {
            result(FlutterMethodNotImplemented)
        }
    }

    private func clearUserDefaults() {
        if let bundleIdentifier = Bundle.main.bundleIdentifier {
            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
        }
    }
}

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      let flutterViewController: FlutterViewController = window?.rootViewController as! FlutterViewController
              let channel = FlutterMethodChannel(name: "your_channel_name", binaryMessenger: flutterViewController.binaryMessenger)
      SwiftClearAppDataPlugin.register(with: flutterViewController.registrar(forPlugin: "ClearAppDataPlugin")!)
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
