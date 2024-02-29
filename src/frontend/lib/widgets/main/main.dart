import 'package:flutter/material.dart';
import 'package:frontend/services/aws/ec2.dart';
import 'package:frontend/widgets/main/subMenuDrawer.dart';

class MainWidget extends StatefulWidget {
  const MainWidget({super.key});

  @override
  State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: AppBar(title: const Text('My Utility')),
            body: SafeArea(
                maintainBottomViewPadding: true,
                child: Center(
                    child: Column(children: [
                  Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.02),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.black,
                            backgroundColor:
                                const Color.fromARGB(255, 87, 180, 90),
                          ),
                          onPressed: () {
                            EC2 ec2 = EC2('', '', '');
                            ec2.runInstance();
                          },
                          child: const Text('Press')))
                ]))),
            drawer: SubMenuDrawer()));
  }
}
