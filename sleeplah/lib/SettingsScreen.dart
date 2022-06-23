import 'package:flutter/material.dart';
// try merging
class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings")
        ),
      body: const Center(
        child: Text('Welcome to the Settings!'),
      ),
    );
  }
}