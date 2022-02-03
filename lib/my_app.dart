import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'apps/repositories/photo_list_repository.dart';
import 'apps/screens/home/bloc/home_screen_bloc.dart';
import 'apps/screens/home/home_screen.dart';
import 'apps/screens/splash_screen.dart';
import 'general/app_config.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    var config = AppConfig.of(context);
    return MaterialApp(
      //title: 'Flutter Demo',
      //theme: config!.themeData,
      debugShowCheckedModeBanner: false,
      home: SplashScreen(baseUrl: config!.baseUrl),
    );
  }
}