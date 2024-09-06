import 'package:edeliverysite/modules/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class EDeliveryApp extends StatefulWidget {
  const EDeliveryApp({super.key});

  @override
  State<EDeliveryApp> createState() => _EDeliveryAppState();
}

class _EDeliveryAppState extends State<EDeliveryApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('uk', 'UA')],
      home: HomeScreen(),
    );
  }
}
