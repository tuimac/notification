import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/models/config.dart';
import 'package:frontend/services/configService.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:local_auth/local_auth.dart';
import 'package:frontend/models/logs.dart';
import 'package:frontend/services/logService.dart';

class SystemConfig extends StatefulWidget {
  const SystemConfig({super.key});

  @override
  State<SystemConfig> createState() => _SystemConfigState();
}

class _SystemConfigState extends State<SystemConfig> {
  late Config config;

  @override
  void initState() {
    super.initState();
    ConfigService.getConfig().then((result) {
      setState(() {
        config = result;
      });
    });
  }

  Future<void> configBioauth() async {
    final LocalAuthentication auth = LocalAuthentication();
    try {
      await auth.getAvailableBiometrics().then((biometricTypes) {
        if (biometricTypes.isEmpty) {
          throw PlatformException(
              code: '400',
              message:
                  'Biometric authentication not implemented on this device.');
        }
      });
      await auth.isDeviceSupported().then((bool isSupported) {
        if (!isSupported) {
          throw PlatformException(
              code: '401',
              message:
                  'Biometric authentication not configured on this device.');
        }
      });
      await auth.canCheckBiometrics.then((bool canCheck) {
        if (!canCheck) {
          throw PlatformException(
              code: '402',
              message:
                  'Biometric authentication not configured on this device.');
        }
      });
      setState(() {
        config.bioauth = true;
      });
      await ConfigService.saveConfig(config);
    } on PlatformException catch (e) {
      LogService.write(Logs(message: e.toString()));
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size uiSize = MediaQuery.of(context).size;
    double uiHeight = uiSize.height;

    return Scaffold(
        appBar: AppBar(
            title: const Text('Settings'),
            backgroundColor: const Color.fromARGB(255, 56, 168, 224)),
        body: SizedBox(
            height: uiHeight,
            child: SingleChildScrollView(
                child: Column(children: [
              SwitchListTile(
                title: const Text('Biometrics Authentication',
                    style: TextStyle(color: Colors.white)),
                subtitle: const Text(
                    'Authentication by FaceID or Finger Print and so on.',
                    style: TextStyle(color: Colors.white, fontSize: 12)),
                value: config.bioauth,
                onChanged: (value) async {
                  await configBioauth();
                },
              )
            ]))));
  }
}
