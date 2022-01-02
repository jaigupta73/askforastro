import 'dart:convert';
import 'dart:io';
import 'package:askforastro/custom_widget/textview.dart';
import 'package:askforastro/screens/home/models/agents_list_model.dart';
import 'package:askforastro/values/custom_colors.dart';
import 'package:askforastro/values/custom_dimensions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:jiffy/jiffy.dart';

Future<bool> isConnected() async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  } on SocketException catch (_) {
    return false;
  }
}

String getFormattedString(String mainString, String v1) {
  return mainString.replaceAll('%s1', v1);
}

String getFormattedMultipleString(String mainString, String v1,String v2, String v3) {
  return mainString.replaceAll('%s1', v1).replaceAll('%s2', v2).replaceAll('%s3', v3);
}

String getStringFromLocale(String tag) {
  return tag.tr;
}

void appLog(dynamic message) {
  if (kDebugMode) print(message);
}

String getLanguageNameFromCode(String code) {
  String value = '';
  switch (code) {
    case 'en':
      value = 'English';
      break;
  }
  return value;
}

bool nonNullNotEmpty(dynamic value) {
  if (value != null) {
    if (value is List || value is Map) return value.length > 0;
    if (value is String) return value.isNotEmpty;
    if (value is int || value is double) return value != 0;
  }
  return false;
}

String getSkilledName(List<Skills> skills) {
  var skillList = [];
  for (var element in skills) {
    skillList.add(element.name);
  }
  return skillList.isEmpty?'':skillList.join(', ');
}

// String getLanguageName(List<Languages> skills) {
//   var languageList = [];
//   for (var element in skills) {
//     languageList.add(element.name);
//   }
//   return languageList.isEmpty?'':languageList.join(', ');
// }

String getValidDate(DateTime dateTime)
{
  return Jiffy([dateTime.year, dateTime.month, dateTime.day]).format("do MMMM, yyyy");
}

Future<DateTime> selectDateTime(BuildContext context) async
{
  DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1970),
      lastDate: DateTime(2025),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme:   const ColorScheme.light(
              primary: colorPrimary,
              // header background color
              onPrimary: Colors.white,
              // header text color
              onSurface:
              Colors.black87, // body text color
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  primary: colorPrimary,
                  textStyle: commonTextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 14) // button text color
              ),
            ),
          ), // This will change to light theme.
          child: child!,
        );
      });

  return dateTime!;
}

bool nonNull(dynamic value) {
  return value != null;
}

TextStyle commonTextStyle(
    {Color color = Colors.black,
    double fontSize = text_12,
    TextDecoration decoration = TextDecoration.none,
    fontWeight = FontWeight.w500}) {
  return GoogleFonts.roboto(
      textStyle: TextStyle(
          color: color,
          fontWeight: fontWeight,
          fontSize: fontSize,
          letterSpacing: 0.4,
          decoration: decoration));
}

void showSnackbar(String msg) {
  GetSnackBar(
    duration: Duration(seconds: 5),
    dismissDirection: DismissDirection.horizontal,
    animationDuration: const Duration(milliseconds: 300),
    snackbarStatus: (status) {
      if (status == SnackbarStatus.OPENING ||
          status == SnackbarStatus.CLOSED) {}
      appLog("status ------> $status");
    },
    messageText:
        TextView(title: msg, textStyle: commonTextStyle(color: Colors.white)),
  ).show();
}

goToNextScreen(dynamic screenWidget, String routeName) {
  Navigator.of(Get.context!).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (BuildContext context) {
          return screenWidget;
        },
        settings: RouteSettings(name: routeName),
      ),
      (route) => false);
}
