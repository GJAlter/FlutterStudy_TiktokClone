import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Settings"),
      ),
      body: ListView(
        children: [
          ListTile(
            // onTap: () => showAboutDialog(
            //   context: context,
            //   applicationVersion: "1.0",
            //   applicationLegalese: "이 앱은 클론 코딩 앱입니다.",
            // ),
            onTap: () => showLicensePage(
              context: context,
            ),
            title: Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: Text("About this app"),
          ),
          AboutListTile(),
        ],
      ),
    );
  }
}
