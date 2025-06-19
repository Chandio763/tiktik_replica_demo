// import 'package:url_launcher/url_launcher.dart';

// Future<void> shareDemoTextToNumber({
//   String phoneNumber = '+1 (888) 555-1212',
//   String message = 'Hi! This is a demo message from Health Pro app.',
// }) async {
//   final encodedMessage = Uri.encodeComponent(message);

//   final Uri smsUri = Uri.parse('sms:$phoneNumber?body=$encodedMessage');

//   if (await canLaunchUrl(smsUri)) {
//     await launchUrl(smsUri);
//   } else {
//     throw Exception('Could not launch SMS app to send demo text');
//   }
// }

// String formatAccountNumber(String account) {
//   return '${account.substring(0, 4)}${account.substring(4).replaceAll(RegExp(r'\d'), '*')}';
// }

// Future<void> launchURL(String url) async {
//   final Uri uri = Uri.parse(url);

//   if (await canLaunchUrl(uri)) {
//     await launchUrl(uri, mode: LaunchMode.externalApplication);
//   } else {
//     throw Exception('Could not launch website: $url');
//   }
// }

// String formatDateToSimpleFormat(String timestamp) {
//   final date = DateTime.parse(timestamp);
//   final day = date.day.toString().padLeft(2, '0');
//   final month = date.month.toString().padLeft(2, '0');
//   return '$day-$month-${date.year}';
// }

// sanitizeJson(Map input) {
//   return input.removeWhere((key, value) => value == null);
// }
