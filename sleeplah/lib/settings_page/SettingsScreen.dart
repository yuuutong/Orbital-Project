import 'package:flutter/material.dart';
import 'package:settings_ui/settings_ui.dart';

import '../profilePicCollection/collection.dart';

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
      appBar: AppBar(title: const Text("Settings")),
      body: SettingsList(
        sections: [
          SettingsSection(
            title: Text('Profile'),
            tiles: <SettingsTile>[
              SettingsTile.navigation(
                leading: Icon(Icons.account_circle),
                title: Text('Profile Picture'),
                // value: Text('English'),
                onPressed: (BuildContext context) {
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Collection()));
                },
              ),
              // SettingsTile.switchTile(
              //   onToggle: (value) {},
              //   initialValue: true,
              //   leading: Icon(Icons.format_paint),
              //   title: Text('Enable custom theme'),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
