import 'dart:convert';
import 'package:frontend/models/logs.dart';
import 'package:frontend/services/aws/aws.dart';
import 'package:frontend/services/logService.dart';
import 'package:http/http.dart' as http;

class EC2 {
  String? accessKey;
  String? secretAccessKey;
  String? region;
  Map<String, dynamic> client = {};

  EC2(String accessKey, String secretAccessKey, String region) {
    client['accessKey'] = accessKey;
    client['secretAccessKey'] = secretAccessKey;
    client['region'] = region;
    client['service'] = 'ec2';
  }

  Future<void> runInstance() async {
    try {
      final ec2 = await AWS.createHttpInfo(client);
      final response = ec2.send();
      LogService.write(Logs(message: await response));
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }
}
