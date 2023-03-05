import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
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
            title: const Text(
              "About",
              style: TextStyle(
                fontWeight: FontWeight.w600,
              ),
            ),
            subtitle: const Text("About this app"),
          ),
          ListTile(
            onTap: () async {
              final date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1990),
                lastDate: DateTime(2030),
              );
              final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());

              print("$date $time");
            },
            title: const Text(
              "What Time?",
            ),
          ),
          ListTile(
            onTap: () async {
              final dateRange = await showDateRangePicker(
                context: context,
                firstDate: DateTime(1990),
                lastDate: DateTime(2030),
                builder: (context, child) {
                  return Theme(
                    data: ThemeData(appBarTheme: const AppBarTheme()),
                    child: child!,
                  );
                },
              );
              print(dateRange);
            },
            title: const Text("DateRange"),
          ),
        ],
      ),
    );
  }
}
