import 'dart:convert';
import 'dart:io';

class AppHelperDevice {
  // DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  // Future<String> getDeviceId() async {
  //   String? deviceId = await PlatformDeviceId.getDeviceId;
  //   return deviceId ?? "";
  // }

  // Future<String> getEncodedDeviceId() async {
  //   final sink = Sha256().newHashSink();
  //   final deviceId = await getDeviceId();
  //   // ignore: no_leading_underscores_for_local_identifiers
  //   final _deviceIdBytes = utf8.encode(deviceId);

  //   sink.add(_deviceIdBytes);
  //   sink.close();

  //   final hash = await sink.hash();
  //   String hashString = base64Encode(hash.bytes);

  //   return hashString;
  // }

  // Future<void> getDeviceLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   await Geolocator.getCurrentPosition();
  // }

  // Future<AndroidDeviceInfo> getDeviceInformation() async {
  //   AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
  //   List<String> infos = [
  //     androidDeviceInfo.device,
  //     androidDeviceInfo.manufacturer,
  //     androidDeviceInfo.model,
  //     androidDeviceInfo.product,
  //     androidDeviceInfo.brand,
  //     androidDeviceInfo.serialNumber,
  //   ];

  //   AppUtils.logD('[DI] :: ${infos.join(', ')}');
  //   AppUtilsGlobal().deviceInfo.value = infos.join(', ');

  //   return androidDeviceInfo;
  // }

  // Future<String> getDeviceInformationName() async {
  //   AndroidDeviceInfo info = await getDeviceInformation();
  //   List infos = [
  //     info.id,
  //     info.brand,
  //     info.device,
  //     info.manufacturer,
  //     'physical ${info.isPhysicalDevice}',
  //   ];

  //   return infos.join(', ');
  // }

  // Future<String> getDeviceNetInformation() async {
  //   // List<NetworkInterface> nets = await NetworkInterface.list();
  //   List<Map<String, dynamic>> result = [];
  //   for (var net in await NetworkInterface.list()) {
  //     for (var addr in net.addresses) {
  //       AppUtils.logD(addr.address);
  //       result.add({
  //         'int': net.name,
  //         'ip': addr.address,
  //       });
  //     }
  //   }

  //   return jsonEncode(result);
  // }
}
