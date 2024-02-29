class Logs {
  String? logline;
  String? message;

  Logs({this.message, this.logline});

  String getMessage() {
    return message!;
  }

  String createLog() {
    return '[${DateTime.now().toIso8601String()}] - $message\n';
  }
}
