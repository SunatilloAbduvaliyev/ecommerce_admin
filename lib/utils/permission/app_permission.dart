import 'package:flutter/cupertino.dart';
import 'package:permission_handler/permission_handler.dart';

class AppPermissions {
  static getStoragePermission() async {
    PermissionStatus status = await Permission.accessMediaLocation.status;
    debugPrint("STORAGE STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.accessMediaLocation.request();
      debugPrint("STORAGE STATUS AFTER ASK:$status");
    }
  }

  static getAccessNotificationPolicyPermission() async {
    PermissionStatus status = await Permission.accessNotificationPolicy.status;
    debugPrint("Bluetooth STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.accessNotificationPolicy.request();
      debugPrint("Bluetooth STATUS AFTER ASK:$status");
    }
  }

  static getActivityRecognitionPermission() async {
    PermissionStatus status = await Permission.activityRecognition.status;
    debugPrint("Bluetooth STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.activityRecognition.request();
      debugPrint("Bluetooth STATUS AFTER ASK:$status");
    }
  }


  static getCameraPermission() async {
    PermissionStatus status = await Permission.camera.status;
    debugPrint("CAMERA STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.camera.request();
      debugPrint("CAMERA STATUS AFTER ASK:$status");
    }
  }

  static getLocationPermission() async {
    PermissionStatus status = await Permission.location.status;
    debugPrint("LOCATION STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.location.request();
      debugPrint("LOCATION STATUS AFTER ASK:$status");
    }
  }

  static getContactsPermission() async {
    PermissionStatus status = await Permission.contacts.status;
    debugPrint("CONTACT STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.contacts.request();
      debugPrint("CONTACT STATUS AFTER ASK:$status");
    }
  }

  static getCalendarFullAccessPermission() async {
    PermissionStatus status = await Permission.calendarFullAccess.status;
    debugPrint("audio STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.calendarFullAccess.request();
      debugPrint("audio STATUS AFTER ASK:$status");
    }
  }

  static getNotificationPermission() async {
    PermissionStatus status = await Permission.notification.status;
    debugPrint("notification STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.notification.request();
      debugPrint("notification STATUS AFTER ASK:$status");
    }
  }

  static getPhonePermission() async {
    PermissionStatus status = await Permission.phone.status;
    debugPrint("phone STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.phone.request();
      debugPrint("phone STATUS AFTER ASK:$status");
    }
  }

  static getSmsPermission() async {
    PermissionStatus status = await Permission.sms.status;
    debugPrint("sms STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.sms.request();
      debugPrint("phone STATUS AFTER ASK:$status");
    }
  }

  static getSpeechPermission() async {
    PermissionStatus status = await Permission.speech.status;
    debugPrint("speech STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status = await Permission.speech.request();
      debugPrint("speech STATUS AFTER ASK:$status");
    }
  }

  static getIgnoreBatteryOptimizationsPermission() async {
    PermissionStatus status =
    await Permission.ignoreBatteryOptimizations.status;
    debugPrint("speech STATUS:$status");
    if (status.isDenied) {
      PermissionStatus status =
      await Permission.ignoreBatteryOptimizations.request();
      debugPrint("ignoreBatteryOptimizations STATUS AFTER ASK:$status");
    }
  }
  static getSomePermissions() async {
    List<Permission> permissions = [
      Permission.notification,
      Permission.sms,
      Permission.speech,
      Permission.appTrackingTransparency,
      Permission.requestInstallPackages,
    ];
    Map<Permission, PermissionStatus> somePermissionsResults =
    await permissions.request();

    debugPrint(
        "NOTIFICATION STATUS AFTER ASK:${somePermissionsResults[Permission.notification]}");
    debugPrint(
        "SMS STATUS AFTER ASK:${somePermissionsResults[Permission.sms]}");
    debugPrint(
        " SPEECH AFTER ASK:${somePermissionsResults[Permission.speech]}");
  }
}