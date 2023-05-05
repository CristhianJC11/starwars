
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RotationViewModel extends ChangeNotifier{

  static MethodChannel platform = const MethodChannel("gyroscope");

  double _angle = 0.0;
  double get angle => _angle;
  set angle(double value) {
    _angle = double.tryParse(value.toStringAsFixed(3))??_angle;
    notifyListeners();
  }

  void listenGyroscope(){
    platform.invokeMethod("getAngle");
    platform.setMethodCallHandler((call) async{
      switch (call.method) {
        case 'gyroData':
            angle =  call.arguments['gyroValue'] as double;
          break;
        default:
          throw PlatformException(
              code: 'Unimplemented',
              details: 'Method not implemented in the native platform');
      }

    });
  }

}