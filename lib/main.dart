import 'package:discoverypage/screens/discovery_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DiscoveryPage(), // Replace DiscoveryPage with your actual home page
    );
  }
}
