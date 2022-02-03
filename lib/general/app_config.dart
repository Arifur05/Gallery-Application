import 'package:flutter/material.dart';

enum Flavor { DEV, PRODUCTION }

class AppConfig extends InheritedWidget{
   String appTitle;
   String baseUrl;
  //String appIconLocation;
  late ThemeData themeData;

  AppConfig({
    this.appTitle = 'Wallpaper Bucket',
    this.baseUrl = '',
  required Widget child}) : super(child: child);


static AppConfig? of(BuildContext context) {
     return context.dependOnInheritedWidgetOfExactType<AppConfig>();
   }

   @override
   bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
