// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:health_pro_hub/common/widgets/ui_action_alert_dialog.dart';
// import 'package:health_pro_hub/core/utils/app_assets.dart';
// import 'package:health_pro_hub/core/utils/app_string.dart';
// import 'package:permission_handler/permission_handler.dart';

// import '../services/tracking_service.dart';

// class AppPermissions {
//   static Future<void> requestLocationPermission(
//       {VoidCallback? onSuccess, VoidCallback? onError}) async {
//     try {
//       var status = await Permission.location.status;
//       if (status.isGranted) {
//         await TrackingService().startLocationUpdates();

//         onSuccess?.call();
//         return;
//       } else {
//         if (!status.isGranted) {
//           status = await Permission.location.request();
//           if (status.isGranted) {
//             onSuccess?.call();
//           } else if (status.isPermanentlyDenied) {
//             onError?.call();
//             _showPermissionDialog(
//               title: AppString.locationPermissionRequired,
//               message: AppString.pleaseEnableLocationPermission,
//             );
//           } else {
//             onError?.call();
//           }
//         }
//       }
//     } catch (e) {
//       // AppLogger.debug("Error Location permission: $e");
//     }
//   }

//   // Future<bool> checkStoragePermission() async {
//   //   return await Permission.storage.isGranted;
//   // }

//   static void _showPermissionDialog(
//       {required String title, required String message}) {
//     final context = Get.context;
//     if (context != null) {
//       UiActionAlertDialog.showPermissionDialog(
//         context,
//         title: title,
//         icon: AppAssets.logo,
//         message: message,
//         allowAccessBtn: () {
//           openAppSettings();
//         },
//         denyAccessBtn: () {
//           Get.back();
//         },
//       );
//     }
//   }

//   Future<bool> checkNotificationPermission() async {
//     return await Permission.notification.isGranted;
//   }
// }
