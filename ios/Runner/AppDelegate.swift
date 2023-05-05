import UIKit
import Flutter
import CoreMotion

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private let motionManager = CMMotionManager()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(
         name: "gyroscope",
         binaryMessenger: controller.binaryMessenger
     )
     channel.setMethodCallHandler({(call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
        guard call.method == "getAngle"
         else {
             result(FlutterMethodNotImplemented)
             return
         }
         self.motionManager.startAccelerometerUpdates(to: .main) { accelerometerData, error in
             guard error == nil else { return }
             guard let accelerometerData = accelerometerData else { return }
             let x = accelerometerData.acceleration.x
             let y = accelerometerData.acceleration.y
             let radians = atan2(x, y)
             let degrees = radians * 180 / .pi
             channel.invokeMethod("gyroData", arguments:  ["gyroValue": degrees])
         }

      })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
