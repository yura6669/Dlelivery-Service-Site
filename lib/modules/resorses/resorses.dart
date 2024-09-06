// ignore_for_file: constant_identifier_names

import 'package:edeliverysite/modules/resorses/app_colors.dart';
import 'package:flutter/material.dart';

enum TermExecution { urdently, for2Hours, scheduled }

enum PackageType {
  food,
  clothes,
  autogoods,
  presents,
  flowers,
  documents,
  other
}

enum PackageWeight { until1kg, until5kg, until10kg, until20kg, more20kg }

enum PaymentType { cash, card }

enum WhoPay { sender, recipient }

enum DeliveriesEachWeek { until10, more50, more100, more500, more1000 }

String getTermExecution(TermExecution termExecution) {
  switch (termExecution) {
    case TermExecution.urdently:
      return 'Терміново';
    case TermExecution.for2Hours:
      return 'До 2 годин';
    case TermExecution.scheduled:
      return 'Запланувати';
  }
}

String getPackageType(PackageType packageType) {
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
    case PackageType.other:
      return 'Інше';
  }
}

String getPackageWeight(PackageWeight packageWeight) {
  switch (packageWeight) {
    case PackageWeight.until1kg:
      return 'До 1 кг';
    case PackageWeight.until5kg:
      return 'До 5 кг';
    case PackageWeight.until10kg:
      return 'До 10 кг';
    case PackageWeight.until20kg:
      return 'До 20 кг';
    case PackageWeight.more20kg:
      return 'Більше 20 кг';
  }
}

String getPaymentType(PaymentType paymentType) {
  switch (paymentType) {
    case PaymentType.cash:
      return 'Готівка';
    case PaymentType.card:
      return 'Картка';
  }
}

String getWhoPay(WhoPay whoPay) {
  switch (whoPay) {
    case WhoPay.sender:
      return 'Відправник';
    case WhoPay.recipient:
      return 'Одержувач';
  }
}

String getDeliveriesEachWeek(DeliveriesEachWeek deliveriesEachWeek) {
  switch (deliveriesEachWeek) {
    case DeliveriesEachWeek.until10:
      return 'Менше 10';
    case DeliveriesEachWeek.more50:
      return 'Більше 50';
    case DeliveriesEachWeek.more100:
      return 'Більше 100';
    case DeliveriesEachWeek.more500:
      return 'Більше 500';
    case DeliveriesEachWeek.more1000:
      return 'Більше 1000';
  }
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
