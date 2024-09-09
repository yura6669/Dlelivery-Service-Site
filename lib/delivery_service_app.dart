import 'package:delivery_service/modules/delivery_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:meta_seo/meta_seo.dart';

class DeliveryServiceApp extends StatefulWidget {
  const DeliveryServiceApp({super.key});

  @override
  State<DeliveryServiceApp> createState() => _DeliveryServiceAppState();
}

class _DeliveryServiceAppState extends State<DeliveryServiceApp> {
  @override
  Widget build(BuildContext context) {
    if (kIsWeb) {
      MetaSEO meta = MetaSEO();
      meta.author(author: 'Delivery Service');
      meta.description(description: 'Служба доставки в Дрогобичі та районі');
      meta.keywords(
          keywords:
              'доставка, їжа, Дрогобич, доставка продуктів, доставка автозапчастин, доставка ліків, доставка квітів, доставка подарунків, доставка квітів');
    }
    return const MaterialApp(
      title: 'Delivery Service',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [Locale('uk', 'UA')],
      home: DeliveryService(),
    );
  }
}
