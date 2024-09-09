import 'package:delivery_service/core/di/locator.dart';
import 'package:delivery_service/delivery_service_app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meta_seo/meta_seo.dart';

void main() {
  setupServiceLocator();
  if (kIsWeb) {
    MetaSEO().config();
  }
  runApp(const DeliveryServiceApp());
}
