
// import 'package:file_picker/file_picker.dart';
// import 'package:health_pro_hub/core/utils/app_string.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';

// import 'app_colors.dart';

// class AppPickers {
//   static final ImagePicker _imagePicker = ImagePicker();
//   static final FilePicker _filePicker = FilePicker.platform;

//   static Future<XFile?> pickImageFromCamera() async {
//     try {
//       final XFile? image = await _imagePicker.pickImage(
//         source: ImageSource.camera,
//         imageQuality: 80,
//       );
//       return image;
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<XFile?> pickImageFromGallery() async {
//     try {
//       final XFile? image = await _imagePicker.pickImage(
//         source: ImageSource.gallery,
//         imageQuality: 80,
//       );
//       return image;
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<List<XFile>?> pickMultipleImages() async {
//     try {
//       final List<XFile> images = await _imagePicker.pickMultiImage(
//         imageQuality: 80,
//       );
//       return images;
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<XFile?> pickDocument() async {
//     try {
//       final FilePickerResult? result = await _filePicker.pickFiles(
//         type: FileType.custom,
//         allowMultiple: false,
//         allowedExtensions: ['pdf'],
//         // withData: true,
//         dialogTitle: 'Select a document',
//       );
//       if (result != null &&
//           result.files.isNotEmpty &&
//           result.files.first.path != null) {
//         return XFile(result.files.first.path!);
//       }
//       return null;
//     } catch (e) {
//       print('File picking error: $e');
//       return null;
//     }
//   }

//   static Future<List<XFile>?> pickFromGoogleDrive() async {
//     try {
//       final result = await FilePicker.platform.pickFiles();

//       if (result != null && result.files.single.path != null) {
//         final filePath = result.files.single.path!;
//         print("Picked file from path: $filePath");
//         // Use the file as needed
//       } else {
//         print("User canceled the picker.");
//       }
//       return result?.files.map((e) => XFile(e.path!)).toList();
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<List<XFile>?> pickMultipleDocuments() async {
//     try {
//       final FilePickerResult? result = await _filePicker.pickFiles(
//         type: FileType.custom,
//         allowMultiple: true,
//         allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
//       );
//       return result?.xFiles;
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<XFile?> pickAudio() async {
//     try {
//       final FilePickerResult? result = await _filePicker.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['mp3', 'wav', 'm4a', 'aac'],
//       );
//       return result?.xFiles.first;
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<List<XFile>?> pickMultipleAudios() async {
//     try {
//       final FilePickerResult? result = await _filePicker.pickFiles(
//         type: FileType.custom,
//         allowMultiple: true,
//         allowedExtensions: ['mp3', 'wav', 'm4a', 'aac'],
//       );
//       return result?.xFiles;
//     } catch (e) {
//       return null;
//     }
//   }

//   static Future<void> pickAndCropImage(ImageSource source) async {
//     final XFile? pickedFile = await _imagePicker.pickImage(source: source);
//     if (pickedFile != null) {
//       final CroppedFile? croppedFile = await ImageCropper().cropImage(
//         sourcePath: pickedFile.path,
//         aspectRatio: const CropAspectRatio(ratioX: 1, ratioY: 1),
//         uiSettings: [
//           AndroidUiSettings(
//             toolbarTitle: AppString.profileCropTitle,
//             toolbarColor: AppColors.primary,
//             toolbarWidgetColor: AppColors.white,
//             lockAspectRatio: true,
//             cropStyle: CropStyle.circle,
//           ),
//           IOSUiSettings(
//             title: AppString.profileCropTitle,
//             aspectRatioLockEnabled: true,
//             cropStyle: CropStyle.circle,
//           ),
//         ],
//       );
//       if (croppedFile != null) {}
//     }
//   }
// }
