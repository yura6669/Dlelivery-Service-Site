import 'package:delivery_service/modules/dialogs/menu_dialog.dart';
import 'package:delivery_service/modules/resorses/app_colors.dart';
import 'package:delivery_service/modules/resorses/measure_size.dart';
import 'package:delivery_service/modules/resorses/resorses.dart';
import 'package:delivery_service/modules/widgets/delivery_service_app_bar.dart';
import 'package:delivery_service/modules/widgets/delivery_service_bottom_bar.dart';
import 'package:delivery_service/modules/widgets/delivery_service_business_section.dart';
import 'package:delivery_service/modules/widgets/delivery_service_faq_section.dart';
import 'package:delivery_service/modules/widgets/delivery_service_services_section.dart';
import 'package:delivery_service/modules/widgets/delivery_service_simply_section.dart';
import 'package:delivery_service/modules/widgets/delivery_service_tariffs_section.dart';
import 'package:delivery_service/modules/widgets/order_form.dart';
import 'package:flutter/material.dart';

class DeliveryService extends StatefulWidget {
  const DeliveryService({super.key});

  @override
  State<DeliveryService> createState() => _DeliveryServiceState();
}

class _DeliveryServiceState extends State<DeliveryService> {
  late Size _formSize;

  @override
  void initState() {
    _formSize = const Size(0, 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                DeliveryServiceAppBar(onOpenMenu: _onOpenMenu),
                const DeliveryServiceSimplySection(),
                DeliveryServiceServicesSection(formHeight: _formSize.height),
                const DeliveryServiceTariffsSection(),
                const DeliveryServiceBusinessSection(),
                const DeliveryServiceFAQSection(),
                const DeliveryServiceBottomBar()
              ],
            ),
            if (!isMobile(context)) _buildForm(context),
          ],
        ),
      ),
    );
  }

  Widget _buildForm(BuildContext context) {
    double x = adaptiveWidth(context, 50) - (_formSize.width / 2);
    double y = (600 - _formSize.height * 0.5);
    return Transform(
      transform: Matrix4.translationValues(x, y, 0),
      child: MeasureSize(
        onChange: _onChangeSize,
        child: const OrderForm(),
      ),
    );
  }

  void _onChangeSize(Size size) {
    setState(() {
      _formSize = size;
    });
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
}
