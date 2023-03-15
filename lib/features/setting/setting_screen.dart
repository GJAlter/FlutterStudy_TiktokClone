import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/common/widgets/setting/setting_config.dart';

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
          ValueListenableBuilder(
            valueListenable: videoConfig,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: value,
              onChanged: (value) {
                videoConfig.value = value;
              },
              activeColor: Theme.of(context).primaryColor,
              title: const Text("AutoMute"),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: darkModeConfig,
            builder: (context, value, child) => SwitchListTile.adaptive(
              value: value,
              onChanged: (value) {
                darkModeConfig.value = value;
              },
              activeColor: Theme.of(context).primaryColor,
              title: const Text("DarkMode"),
            ),
          ),
          const AboutListTile(),
          ListTile(
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
              if (!mounted) return;
              final time = await showTimePicker(context: context, initialTime: TimeOfDay.now());

              if (kDebugMode) {
                print("$date $time");
              }
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
              if (kDebugMode) {
                print(dateRange);
              }
            },
            title: const Text("DateRange"),
          ),
          CheckboxListTile(
            value: isNotifications,
            onChanged: onNotificationChanged,
            activeColor: Theme.of(context).primaryColor,
            title: const Text("Enable Notifications"),
          ),
          SwitchListTile.adaptive(
            value: isNotifications,
            onChanged: onNotificationChanged,
            activeColor: Theme.of(context).primaryColor,
            title: const Text("Enable Notifications"),
          ),
          ListTile(
            onTap: () {
              showCupertinoDialog(
                context: context,
                builder: (context) => CupertinoAlertDialog(
                  title: const Text("Are you sure?"),
                  content: const Text("Pls dont go"),
                  actions: [
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "No",
                      ),
                    ),
                    CupertinoDialogAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      isDestructiveAction: true,
                      child: const Text(
                        "Yes",
                      ),
                    )
                  ],
                ),
              );
            },
            title: const Text(
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
                  title: const Text("Are you sure?"),
                  content: const Text("Pls dont go"),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "No",
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        "Yes",
                      ),
                    )
                  ],
                ),
              );
            },
            title: const Text(
              "Log out(AOS)",
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          ListTile(
            onTap: () {
              showCupertinoModalPopup(
                context: context,
                builder: (context) => CupertinoActionSheet(
                  title: const Text("Are you sure?"),
                  message: const Text("Pls dont go"),
                  actions: [
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      isDefaultAction: true,
                      child: const Text("No"),
                    ),
                    CupertinoActionSheetAction(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      isDestructiveAction: true,
                      child: const Text("Yes"),
                    ),
                  ],
                ),
              );
            },
            title: const Text(
              "Log out(iOS Bottom)",
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
