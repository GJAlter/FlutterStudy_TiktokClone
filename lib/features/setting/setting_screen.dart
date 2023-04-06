import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tiktok_clone/common/widgets/setting/setting_config.dart';
import 'package:tiktok_clone/features/authentication/repositories/authentication_repo.dart';
import 'package:tiktok_clone/features/videos/view_models/palyback_config_vm.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListView(
        children: [
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).isMuted,
            onChanged: (value) => ref.watch(playbackConfigProvider.notifier).setMuted(value),
            activeColor: Theme.of(context).primaryColor,
            title: const Text("AutoMute"),
          ),
          SwitchListTile.adaptive(
            value: ref.watch(playbackConfigProvider).isAutoPlay,
            onChanged: (value) => ref.watch(playbackConfigProvider.notifier).setAutoPlay(value),
            activeColor: Theme.of(context).primaryColor,
            title: const Text("AutoPlay"),
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
            value: false,
            onChanged: (value) {},
            activeColor: Theme.of(context).primaryColor,
            title: const Text("Enable Notifications"),
          ),
          SwitchListTile.adaptive(
            value: false,
            onChanged: (value) {},
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
                  title: const Text("Are you sure?2"),
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
                        ref.read(authRepo).signOut();
                        context.go("/");
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
