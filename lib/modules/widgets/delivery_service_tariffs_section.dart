import 'package:delivery_service/modules/dialogs/tariffs/tariffs_dialog.dart';
import 'package:delivery_service/modules/resorses/app_colors.dart';
import 'package:delivery_service/modules/resorses/ink_wrapper.dart';
import 'package:delivery_service/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';

class DeliveryServiceTariffsSection extends StatelessWidget {
  const DeliveryServiceTariffsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(
        top: 48,
        bottom: 48,
        left: 24,
        right: 24,
      ),
      color: const Color(0xFFFBC700),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildTitle(context),
          const SizedBox(height: 16),
          _buildSubtitle(context),
          const SizedBox(height: 16),
          _buildBtn(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Тарифи',
      style: customTextStyle(
        context,
        fontSize: isMobile(context) || is640(context)
            ? 30
            : is768(context) || is1024(context)
                ? 35
                : 48,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      'Перегляньте наші тарифи по місту та області',
      style: customTextStyle(
        context,
        fontSize: isMobile(context) ||
                is640(context) ||
                is768(context) ||
                is1024(context)
            ? 16
            : 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildBtn(BuildContext context) {
    return InkWrapper(
      radius: 0,
      onTap: () => _showTariffs(context),
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 12,
          horizontal: 24,
        ),
        color: const Color(0xFF161513),
        child: Text(
          'Переглянути тарифи',
          style: customTextStyle(
            context,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  void _showTariffs(BuildContext context) {
    showDialog(
      barrierColor: AppColors.white,
      barrierDismissible: false,
      context: context,
      builder: (context) => TariffsDialog(
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }
}

class TariffsClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(0, 111 + 48);
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
