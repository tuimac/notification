import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:frontend/models/logs.dart';
import 'package:frontend/services/logService.dart';
import 'package:aws_signature_v4/aws_signature_v4.dart';

class AWS {
  static Map<String, dynamic> createHttpInfo(
      Map<String, dynamic> client, String queryParams) {
    try {
      // Fixed values
      const signer = AWSSigV4Signer();
      final endpoint = '${client['service']}.${client['region']}.amazonaws.com';
      const httpMethod = 'POST';
      const canonicalUri = '/';
      const canonicalQueryString = '';
      const canonicalHeaders = 'host;range;x-amz-date';
      const signedHeaders = 'host;content-type';

      // Datetime initialization
      final dateTime = DateTime.now().toUtc();
      final amzDate =
          '${DateTime.now().toUtc().toIso8601String().replaceAll('-', '').replaceAll(':', '').split('.')[0]}Z';
      final dateStamp =
          dateTime.toUtc().toIso8601String().replaceAll('-', '').split('T')[0];

      // Authorization header value
      final stringToSign =
          'AWS4-HMAC-SHA256\n$amzDate\n$dateStamp/${client['region']}/${client['service']}/aws4_request\n${_sha256('$httpMethod\n$canonicalUri\n$queryParams\n$endpoint\n$amzDate\n\n${_sha256(queryParams)}')}';
      final signature = _hmacSha256(
          stringToSign,
          _hmacSha256(
              'aws4_request',
              _hmacSha256(
                  client['service'],
                  _hmacSha256(
                      client['region'],
                      _hmacSha256(
                          dateStamp, 'AWS4${client['secretAccessKey']}')))));

      return {
        'headers': {
          'Authorization':
              'AWS4-HMAC-SHA256 Credential=${client['accessKey']}/$dateStamp/${client['region']}/${client['service']}/aws4_request, SignedHeaders=$signedHeaders, Signature=$signature',
          'Host': endpoint,
          'Content-Type': 'application/x-www-form-urlencoded; charset=utf-8',
          'X-Amz-Date': amzDate
        },
        'uri': Uri.parse('https://$endpoint/')
      };
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }

  static String _sha256(String data) {
    final bytes = utf8.encode(data);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static String _hmacSha256(String data, String key) {
    final secretKey = utf8.encode(key);
    final message = utf8.encode(data);
    final hmac = Hmac(sha256, secretKey);
    final digest = hmac.convert(message);
    return digest.toString();
  }
}
