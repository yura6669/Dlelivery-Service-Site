import 'package:edeliverysite/core/di/locator.dart';
import 'package:edeliverysite/e_delivery_app.dart';
import 'package:flutter/material.dart';

void main() {
  setupServiceLocator();
  runApp(const EDeliveryApp());
}
