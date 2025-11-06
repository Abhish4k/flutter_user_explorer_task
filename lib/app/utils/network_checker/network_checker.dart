import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  static Future<bool> isOnline() async {
    final List<ConnectivityResult> connectivityResults = await Connectivity()
        .checkConnectivity();
    print('Connectivity Results: $connectivityResults');

    final bool isConnected =
        connectivityResults.contains(ConnectivityResult.mobile) ||
        connectivityResults.contains(ConnectivityResult.wifi);
    print('isConnected: $isConnected');
    return isConnected;
  }
}
