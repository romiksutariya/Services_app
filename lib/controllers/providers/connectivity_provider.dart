import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';

import '../../modals/connectivity_modal.dart';
class ConnectivityProvider extends ChangeNotifier {
  Connectivity connectivity = Connectivity();

  ConnectivityModal connectivityModal =
  ConnectivityModal(connectivityStatus: "waiting");

  void checkInternetConnectivity() {
    connectivityModal.connectivityStream = connectivity.onConnectivityChanged
        .listen((ConnectivityResult connectivityResult) {
      switch (connectivityResult) {
        case ConnectivityResult.wifi:
          connectivityModal.connectivityStatus = "wifi";
          notifyListeners();
          break;
        case ConnectivityResult.mobile:
          connectivityModal.connectivityStatus = "Mobile Data";
          notifyListeners();
          break;
        default:
          connectivityModal.connectivityStatus = "waiting";
          notifyListeners();
          break;
      }
    });
  }
}