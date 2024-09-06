import 'package:edeliverysite/modules/dialogs/business_dialog.dart';
import 'package:edeliverysite/modules/dialogs/menu_dialog.dart';
import 'package:edeliverysite/modules/dialogs/order_dialog.dart';
import 'package:edeliverysite/modules/resorses/app_colors.dart';
import 'package:edeliverysite/modules/widgets/e_delivery_app_bar.dart';
import 'package:edeliverysite/modules/widgets/e_delivery_bottom_bar.dart';
import 'package:edeliverysite/modules/widgets/e_delivery_faq_section.dart';
import 'package:edeliverysite/modules/widgets/e_delivery_form_section.dart';
import 'package:edeliverysite/modules/widgets/e_delivery_promo_section.dart';
import 'package:edeliverysite/modules/widgets/e_delivery_services_section.dart';
import 'package:edeliverysite/modules/widgets/e_delivery_simply_section.dart';
import 'package:edeliverysite/modules/widgets/e_delivery_tariffs_section.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            EDeliveryAppBar(onOpenMenu: _onOpenMenu),
            EDeliveryPromoSection(
              onOrder: _onOrder,
              onForBusiness: _onForBusiness,
            ),
            const EDeliverySimplySection(),
            const EDeliveryServicesSection(),
            const EDeliveryTariffsSection(),
            const EDeliveryFAQSection(),
            const EDeliveryFormSection(),
            const EDeliveryBottomBar()
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
