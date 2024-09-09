import 'package:delivery_service/modules/dialogs/business_dialog.dart';
import 'package:delivery_service/modules/dialogs/menu_dialog.dart';
import 'package:delivery_service/modules/dialogs/order_dialog.dart';
import 'package:delivery_service/modules/resorses/app_colors.dart';
import 'package:delivery_service/modules/widgets/delivery_service_app_bar.dart';
import 'package:delivery_service/modules/widgets/delivery_service_bottom_bar.dart';
import 'package:delivery_service/modules/widgets/delivery_service_faq_section.dart';
import 'package:delivery_service/modules/widgets/delivery_service_form_section.dart';
import 'package:delivery_service/modules/widgets/delivery_service_promo_section.dart';
import 'package:delivery_service/modules/widgets/delivery_service_services_section.dart';
import 'package:delivery_service/modules/widgets/delivery_service_simply_section.dart';
import 'package:delivery_service/modules/widgets/delivery_service_tariffs_section.dart';
import 'package:flutter/material.dart';

class DeliveryService extends StatefulWidget {
  const DeliveryService({super.key});

  @override
  State<DeliveryService> createState() => _DeliveryServiceState();
}

class _DeliveryServiceState extends State<DeliveryService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            DeliveryServiceAppBar(onOpenMenu: _onOpenMenu),
            DeliveryServicePromoSection(
              onOrder: _onOrder,
              onForBusiness: _onForBusiness,
            ),
            const DeliveryServiceSimplySection(),
            const DeliveryServiceServicesSection(),
            const DeliveryServiceTariffsSection(),
            const DeliveryServiceFAQSection(),
            const DeliveryServiceFormSection(),
            const DeliveryServiceBottomBar()
          ],
        ),
      ),
    );
  }

  void _onOpenMenu() {
    showDialog(
      barrierColor: AppColors.white,
      barrierDismissible: false,
      context: context,
      builder: (context) => MenuDialog(
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _onOrder() {
    showDialog(
      barrierColor: AppColors.white,
      barrierDismissible: false,
      context: context,
      builder: (context) => OrderDialog(
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _onForBusiness() {
    showDialog(
      barrierColor: AppColors.white,
      barrierDismissible: false,
      context: context,
      builder: (context) => BusinessDialog(
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }
}
