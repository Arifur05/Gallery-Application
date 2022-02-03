import 'package:flutter/material.dart';

import 'my_app.dart';
import 'general/app_config.dart';


Future<void> main() async{
  final appConfig = AppConfig(child: const MyApp(),)..appTitle = 'Wallpaper Bucket'
    ..baseUrl='https://picsum.photos/v2/list?page'
    ..themeData= ThemeData.dark();
  runApp(appConfig);
}



