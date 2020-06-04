import 'dart:async';
import 'package:flutter/material.dart';
import 'package:ledstripe_app/screens/ledstripe_screen.dart';

void main() {
  runZoned(() {
    runApp(
      new MaterialApp(
        title: 'LEDSTRIPE_APP',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primaryColor: Colors.blueGrey[600],
          backgroundColor: Colors.blueGrey[700],
          scaffoldBackgroundColor: Colors.blueGrey[700],
          accentColor: Colors.blueGrey[900],
          errorColor: Colors.redAccent,
        ),
        routes: {
          '/': (context) => LedStripeScreen(),
        },
        initialRoute: '/',
      ),
    );
  }, onError: (error) {
    print('[ERROR] $error');
  });
}
