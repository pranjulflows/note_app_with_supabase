
import 'package:flutter/material.dart';

class SimpleAppPage extends StatefulWidget {
  const SimpleAppPage({Key? key}) : super(key: key);

  @override
  State<SimpleAppPage> createState() => _SimpleAppPageState();
}

class _SimpleAppPageState extends State<SimpleAppPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
    );
  }
}
