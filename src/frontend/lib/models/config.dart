class Config {
  Map<String, dynamic>? config;
  bool bioauth = false;
  Map<String, dynamic> awsCredential = {'accessKey': '', 'secretKey': ''};

  Config({required Map<String, dynamic> config});

  Map<String, dynamic> getConfig() {
    return {'bioauth': bioauth, 'awsCredential': awsCredential};
  }

  void setConfig() {
    bioauth = config!['bioauth'];
    awsCredential = config!['awsCredential'];
  }
}
