import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:frontend/models/logs.dart';
import 'package:frontend/services/logService.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';
import 'package:aws_common/aws_common.dart';
import 'package:http/http.dart' as http;

class AWS {
  static Future createHttpInfo(Map<String, dynamic> client) {
    try {
      return AWSSigV4Signer(
              credentialsProvider: AWSCredentialsProvider(AWSCredentials(
                  client['accessKey'], client['secretAccessKey'])))
          .sign(
              AWSHttpRequest(
                  method: AWSHttpMethod.post,
                  uri: Uri.https('ec2.amazonaws.com', '/'),
                  headers: const {
                    AWSHeaders.target: 'POST /',
                    AWSHeaders.contentType: 'application/x-amz-json-1.1',
                  },
                  body: json.encode({}).codeUnits),
              credentialScope: AWSCredentialScope(
                region: client['region'],
                service: AWSService.ec2,
              ));
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }
}
