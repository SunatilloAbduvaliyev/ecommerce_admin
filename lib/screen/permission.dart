import 'package:flutter/material.dart';

import '../utils/permission/app_permission.dart';

class PermissionsScreen extends StatefulWidget {
  const PermissionsScreen({super.key});

  @override
  State<PermissionsScreen> createState() => _PermissionsScreenState();
}

class _PermissionsScreenState extends State<PermissionsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Permissions")),
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                AppPermissions.getCalendarFullAccessPermission();
              },
              child: const Text("Calendar FullAccess"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getIgnoreBatteryOptimizationsPermission();
              },
              child: const Text("Battery"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getPhonePermission();
              },
              child: const Text("Phone"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getSpeechPermission();
              },
              child: const Text("Speach"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getStoragePermission();
              },
              child: const Text("STORAGE"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getCameraPermission();
              },
              child: const Text("CAMERA"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getLocationPermission();
              },
              child: const Text("LOCATION"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getContactsPermission();
              },
              child: const Text("CONTACTS"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getActivityRecognitionPermission();
              },
              child: const Text("Activity Recognition"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getAccessNotificationPolicyPermission();
              },
              child: const Text("Access Notification Policy"),
            ),
            TextButton(
              onPressed: () {
                AppPermissions.getSomePermissions();
              },
              child: const Text("SOME PERMISSIONS"),
            ),
          ],
        ),
      ),
    );
  }
}