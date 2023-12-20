import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/controller/controller_main.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MyScreenController>().navigation(context);

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/loading-loading-forever.gif',
                height: 50,
                width: 50,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text("Loading.....")
            ],
          ),
        ],
      ),
    );
  }
}
