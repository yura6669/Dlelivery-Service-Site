import 'package:delivery_service/modules/resorses/app_colors.dart';
import 'package:delivery_service/modules/resorses/resorses.dart';
import 'package:delivery_service/modules/widgets/order_form.dart';
import 'package:flutter/material.dart';

class DeliveryServiceSimplySection extends StatelessWidget {
  const DeliveryServiceSimplySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        minHeight: isMobile(context) ? 300 : 500,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: isMobile(context) || is640(context) ? 20 : 24,
        vertical: isMobile(context) || is640(context) ? 24 : 32,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.black,
            AppColors.black,
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        image: DecorationImage(
          image: AssetImage('assets/simply_life.png'),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: Column(
        children: [
          _buildTitle(context),
          const SizedBox(height: 24),
          _buildSubtitle(context),
          if (isMobile(context)) const SizedBox(height: 24),
          if (isMobile(context)) const OrderForm(),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return SizedBox(
      width: 650,
      child: Text(
        'Спростіть своє життя',
        textAlign: TextAlign.center,
        style: customTextStyle(
          context,
          fontSize: isMobile(context) || is640(context)
              ? 36
              : is768(context) || is1024(context)
                  ? 46
                  : 72,
          color: AppColors.orange,
        ),
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      'Наш надійний сервіс дозволяє легко доставляти та отримувати товари по Дрогобичу та району',
      textAlign: TextAlign.center,
      style: customTextStyle(
        context,
        fontSize: isMobile(context) ||
                is640(context) ||
                is768(context) ||
                is1024(context)
            ? 24
            : 32,
        fontWeight: FontWeight.w900,
        color: AppColors.white,
      ),
    );
  }
}

class CustomBezierClipper extends CustomClipper<Path> {
  @override
  getClip(Size size) {
    Path path = Path();
    path.moveTo(0, size.height);
    path.lineTo(size.height, size.width / 3);
    path.lineTo(size.width / 1.5, size.height);
    path.lineTo(size.width, size.width / 3);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}
