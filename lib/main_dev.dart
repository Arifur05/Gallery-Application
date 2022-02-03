import 'package:flutter/material.dart';

import 'my_app.dart';
import 'general/app_config.dart';


Future<void> main() async{
final appConfig = AppConfig(child: MyApp(),)..appTitle = 'Wallpaper Bucket Development'
                            ..baseUrl='https://picsum.photos/v2/list?page'
..themeData= ThemeData.dark();
  runApp(appConfig);
}



