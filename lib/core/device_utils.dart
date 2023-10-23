import 'package:package_info_plus/package_info_plus.dart';

class DeviceUtils {
  static String appName = '';
  static String packageName = '';
  static String version = '';
  static String buildNumber = '';

  void readVersion() async {
    await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      appName = packageInfo.appName;
      packageName = packageInfo.packageName;
      version = packageInfo.version;
      buildNumber = packageInfo.buildNumber;
    });
  }
}
