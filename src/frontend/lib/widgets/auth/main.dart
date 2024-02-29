import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/logs.dart';
import 'package:frontend/services/configService.dart';
import 'package:frontend/services/logService.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:local_auth/local_auth.dart';

class Authentication extends StatefulWidget {
  const Authentication({super.key});

  @override
  State<Authentication> createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  final LocalAuthentication auth = LocalAuthentication();
  int bioAuthFailCount = 0;

  @override
  void initState() {
    super.initState();
  }

  Future<void> bioAuth(BuildContext context) async {
    try {
      auth.authenticate(
          localizedReason: 'Authenticate to show password list',
          options: const AuthenticationOptions(
            stickyAuth: false,
            biometricOnly: true,
          ),
          authMessages: [
            const AndroidAuthMessages(
              cancelButton: 'PIN auth',
            ),
            const IOSAuthMessages(
              cancelButton: 'PIN auth',
            ),
          ]).then((authState) {
        if (authState) {
          GoRouter.of(context).go('/main');
        }
      });
    } on PlatformException {
      LogService.write(Logs(message: 'Bio authentication PlatformException'));
    } catch (e) {
      LogService.write(Logs(message: e.toString()));
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    ConfigService.getConfig().then((config) {
      if (config.bioauth) {
        bioAuth(context);
      } else {
        GoRouter.of(context).go('/main');
      }
    });

    return Container();
  }
}
