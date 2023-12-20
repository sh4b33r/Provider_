import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:provider/provider.dart';
import 'package:provider_app/model/model.dart';
import 'package:provider_app/view/splash/spalsh.dart';

import 'controller/controller_main.dart';
import 'view/theme/themes.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  if (!Hive.isAdapterRegistered(StudentModelAdapter().typeId)) {
    Hive.registerAdapter(StudentModelAdapter());
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => MyScreenController())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Student DataBase',
          theme: themeCustom,
          // home:   MyHomePage(title: 'Flutter Demo Home Page'),
          home: const SplashScreen(),
        ),
      ),
    );
  }
}
