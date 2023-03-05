import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isNotifications = false;

  void onNotificationChanged(bool? value) {
    if (value == null) return;
    setState(() {
      isNotifications = value;
    });
  }

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
          CheckboxListTile(
            value: isNotifications,
            onChanged: onNotificationChanged,
            activeColor: Theme.of(context).primaryColor,
            title: Text("Enable Notifications"),
          ),
          SwitchListTile.adaptive(
            value: isNotifications,
            onChanged: onNotificationChanged,
            activeColor: Theme.of(context).primaryColor,
            title: Text("Enable Notifications"),
          ),
          ListTile(
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: Text("Are you sure?"),
                  content: Text("Pls dont go"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "No",
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      isDestructiveAction: true,
                      child: Text(
                        "Yes",
                      ),
                    )
                  ],
                ),
              );
            },
            title: Text(
              "Log out(iOS)",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Are you sure?"),
                  content: Text("Pls dont go"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "No",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Yes",
                      ),
                    )
                  ],
                ),
              );
            },
            title: Text(
              "Log out(AOS)",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
