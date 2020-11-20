import 'package:flutter/foundation.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'counter.dart';
import 'package:flutter_background/http/records.dart';

class BlueToothService {
  factory BlueToothService.instance() => _instance;

  BlueToothService._internal();

  static final _instance = BlueToothService._internal();

  final _counter = Counter();

  final FlutterBlue flutterBlue = FlutterBlue.instance;
  final List<String> devicesList = new List<String>();
  final Records record = new Records();
  ValueListenable<int> get count => _counter.count;

  void startCountingBlue() {
    Stream.periodic(Duration(seconds: 1)).listen((_) {
      blue();
      print('Counter incremented: ${_counter.count.value}');
    });
  }
  void blue() async {
    flutterBlue.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        String mac = result.device.id.toString();
        int rssi = result.rssi;
        print('$mac');
        record.updateRecords(mac, rssi).then((value) => _addDeviceToList(mac));
        _addDeviceToList(mac);
      }
    });
    flutterBlue.startScan();
  }
  _addDeviceToList(final String device) {
    if (!devicesList.contains(device)) {
      devicesList.add(device);
    }
  }
}