import 'package:connectivity_plus/connectivity_plus.dart';

/// A utility class for network connectivity.
class NetworkUtil {
  /// Checks if the device is connected to the internet.
  ///
  /// Returns `true` if connected, `false` otherwise.
  static Future<bool> isConnected() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    } else {
      return false;
    }
  }
}
