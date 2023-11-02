import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyD83bL6G9N1zJnKRPdA0cqINbg86Xko1Nc")
    GeneratedPluginRegistrant.register(with: self)
    if #available(iOS 10.0, *) {
    UNUserNotificationCenter.current().delegate = self
    }
    
    FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
    GeneratedPluginRegistrant.register(with: registry)
  }
    UNUserNotificationCenter.current().delegate = self
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
    
}
extension AppDelegate {
    
    override func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
      
        completionHandler([.alert, .sound])
    }
    

}

