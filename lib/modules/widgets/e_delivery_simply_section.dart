import 'package:edeliverysite/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';

class EDeliverySimplySection extends StatelessWidget {
  const EDeliverySimplySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      // height: 714,
      padding: EdgeInsets.symmetric(
        horizontal: isMobile(context) || is640(context) ? 20 : 24,
        vertical:
            isMobile(context) || is640(context) || is768(context) ? 80 : 192,
      ),
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/simply_life.png'),
          fit: BoxFit.cover,
          opacity: 0.3,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildTitle(context),
            const SizedBox(height: 24),
            _buildSubtitle(context),
          ],
        ),
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
        ),
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      'Наш надійний сервіс дозволяє легко отримувати товари',
      textAlign: TextAlign.center,
      style: customTextStyle(
        context,
        fontSize: isMobile(context) ||
                is640(context) ||
                is768(context) ||
                is1024(context)
            ? 24
            : 32,
        fontWeight: FontWeight.w600,
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
