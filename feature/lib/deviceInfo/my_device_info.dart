// import 'package:device_info_plus/device_info_plus.dart';
import 'package:feature/deviceInfo/my_device_model.dart';


class MyDeviceInfo{
  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  Future<MyDeviceModel> getDeviceInfo() async{
    // AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return MyDeviceModel(sdkInt: 1);
  }
}