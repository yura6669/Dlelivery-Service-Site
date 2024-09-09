import 'package:delivery_service/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';

class DeliveryServiceServicesSection extends StatelessWidget {
  const DeliveryServiceServicesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical:
            isMobile(context) || is640(context) || is768(context) ? 48 : 80,
      ),
      constraints: BoxConstraints(
          maxWidth: isMobile(context) || is640(context)
              ? 640
              : is768(context)
                  ? 768
                  : is1024(context)
                      ? 1024
                      : is1280(context)
                          ? 1282
                          : 1488),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(context),
          const SizedBox(height: 24),
          _buildGrid(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Наші послуги',
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

  Widget _buildGrid(BuildContext context) {
    return Wrap(
      spacing: 40,
      runSpacing: 40,
      children: [
        _buildItem(
          context,
          img: 'assets/service_1.png',
          title: "Швидка доставка",
        ),
        _buildItem(
          context,
          img: 'assets/service_2.png',
          title: "Запланована доставка",
        ),
        _buildItem(
          context,
          img: 'assets/service_3.png',
          title: "Доставка продуктів",
        ),
        _buildItem(
          context,
          img: 'assets/service_4.png',
          title: "Доставка документів",
        ),
        _buildItem(
          context,
          img: 'assets/service_5.png',
          title: "Доставка подарунків та квітів",
        ),
        _buildItem(
          context,
          img: 'assets/service_6.png',
          title: "Доставка інших товарів",
        ),
      ],
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required String img,
    required String title,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: isMobile(context)
              ? adaptiveWidth(context, 93.7)
              : is640(context)
                  ? 280
                  : is768(context)
                      ? 340
                      : is1024(context)
                          ? 298.66
                          : is1280(context)
                              ? 384
                              : 469,
          height: isMobile(context)
              ? adaptiveWidth(context, 93.7)
              : is640(context)
                  ? 280
                  : is768(context)
                      ? 340
                      : is1024(context)
                          ? 298.66
                          : is1280(context)
                              ? 384
                              : 469,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(img),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 24),
        SizedBox(
          width: isMobile(context)
              ? adaptiveWidth(context, 93.7)
              : is640(context)
                  ? 280
                  : is768(context)
                      ? 340
                      : is1024(context)
                          ? 298.66
                          : is1280(context)
                              ? 384
                              : 469,
          child: Text(
            title,
            style: customTextStyle(
              context,
              fontSize: isMobile(context) || is640(context)
                  ? 24
                  : is768(context) || is1024(context)
                      ? 28
                      : 32,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
