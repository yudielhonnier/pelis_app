import 'dart:io';


import 'package:flutter/material.dart';
import 'package:pelis_pro/src/pages/film_detail_page.dart';
import 'src/pages/home_page.dart';

void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());

}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pelis Pro',
      routes: {
        '/':(BuildContext context)=>HomePage(),
        'detail':(BuildContext context)=>FilmDetailPage(),
      },
      initialRoute: '/',
    );
  }
}

//FOR NOT SECURES SERVICES
class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
