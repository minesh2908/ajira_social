import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkUtil {
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
