// ignore_for_file: constant_identifier_names

import 'package:delivery_service/modules/resorses/app_colors.dart';
import 'package:flutter/material.dart';

enum PackageType {
  food,
  clothes,
  autogoods,
  presents,
  flowers,
  documents,
  medicine,
  parcel,
  other
}

enum PaymentType { cash, card }

String getPackageType(PackageType? packageType) {
  switch (packageType) {
    case PackageType.food:
      return 'Їжа';
    case PackageType.clothes:
      return 'Одяг';
    case PackageType.autogoods:
      return 'Автотовари';
    case PackageType.presents:
      return 'Подарунки';
    case PackageType.flowers:
      return 'Квіти';
    case PackageType.documents:
      return 'Документи';
    case PackageType.medicine:
      return 'Ліки';
    case PackageType.parcel:
      return 'Посилка';
    case PackageType.other:
      return 'Інше';
    default:
      return 'Оберіть тип товару';
  }
}

String getPaymentType(PaymentType? paymentType) {
  switch (paymentType) {
    case PaymentType.cash:
      return 'Готівкою';
    case PaymentType.card:
      return 'Карткою';
    default:
      return 'Оберіть спосіб оплати';
  }
}

List<DateTime> generateAvailableDateTimes() {
  DateTime date = DateTime.now();
  if (date.hour >= 20 && date.minute >= 45 && date.hour < 21) {
    date = DateTime(date.year, date.month, date.day + 1);
  }
  final today = DateTime(date.year, date.month, date.day);

  DateTime start = DateTime(today.year, today.month, today.day, 9, 0);
  final end = DateTime(today.year, today.month, today.day, 21, 0);

  List<DateTime> slots = [];
  while (start.isBefore(end) || start.isAtSameMomentAs(end)) {
    slots.add(start);
    start = start.add(const Duration(minutes: 15));
  }
  // Filter out times that are in the past
  slots = slots.where((slot) => slot.isAfter(date)).toList();
  // Ensure the first slot is at least 15 minutes from now
  if (slots.isNotEmpty &&
      slots.first.isBefore(date.add(const Duration(minutes: 15)))) {
    slots.removeAt(0);
  }

  return slots;
}

String formatTime(DateTime? dateTime) {
  if (dateTime == null) {
    return 'Оберіть час доставки';
  }
  final String day = dateTime.day.toString().padLeft(2, '0');
  final String month = dateTime.month.toString().padLeft(2, '0');
  final String year = dateTime.year.toString();
  final String hour = dateTime.hour.toString().padLeft(2, '0');
  final String minute = dateTime.minute.toString().padLeft(2, '0');

  if (isAfterClose()) {
    return '$day.$month.$year, $hour:$minute';
  }

  return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
}

bool isAfterClose() {
  DateTime date = DateTime.now();
  DateTime nexDay = DateTime(date.year, date.month, date.day + 1, 0, 0);
  if (date.hour >= 20 &&
      date.minute >= 45 &&
      date.hour < 21 &&
      nexDay.isAfter(date)) {
    return true;
  }
  return false;
}

bool is1280(BuildContext context) {
  return MediaQuery.of(context).size.width >= 1280 &&
      MediaQuery.of(context).size.width < 1536;
}

bool is1024(BuildContext context) {
  return MediaQuery.of(context).size.width >= 1024 &&
      MediaQuery.of(context).size.width < 1280;
}

bool is768(BuildContext context) {
  return MediaQuery.of(context).size.width >= 768 &&
      MediaQuery.of(context).size.width < 1024;
}

bool is640(BuildContext context) {
  return MediaQuery.of(context).size.width >= 640 &&
      MediaQuery.of(context).size.width < 768;
}

bool isMobile(BuildContext context) {
  return MediaQuery.of(context).size.width < 640;
}

double adaptiveHeight(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.height / 100) * percent;
}

double adaptiveWidth(BuildContext context, double percent) {
  return (MediaQuery.of(context).size.width / 100) * percent;
}

TextStyle customTextStyle(
  BuildContext context, {
  Color color = AppColors.black,
  required double fontSize,
  FontWeight fontWeight = FontWeight.bold,
  TextDecoration? decoration = TextDecoration.none,
  String fontFamily = 'AlegreyaSans',
}) {
  return TextStyle(
    color: color,
    fontFamily: fontFamily,
    fontSize: fontSize,
    fontWeight: fontWeight,
    decoration: decoration,
    decorationColor: color,
  );
}

const String TELEGRAM_BOT_API =
    '7524732961:AAHjwExAXlDbU3IMgfzCRfjrYD3k_4mkANA';
const String TELEGRAM_CHAT_ID = '-1002244581826';
