import 'dart:convert';
import 'package:http/http.dart' as http;

class Records{
  final String uri = 'http://10.112.10.100:7031/api/records';
  Future<bool> updateRecords(deviceMac, rssi) async {
    Map temp = {
      "mac": deviceMac,
      "date_time": '2020-11-20',
      "date_long": '',
      "rssi": rssi.toString(),
      "area_id": "14",
      "bat":'',
    };
    try {
      final data = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode(<String, String>{
          'scanner_mac':'',
          'scanner_ip':'',
          'scanner_ssid':'',
          'records': temp.toString(),
        }),
      );
      print('dataSTATUS:${data.statusCode}');
      print('data:$data');
      if (data.statusCode == 200) {
        print('hello:$data');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}