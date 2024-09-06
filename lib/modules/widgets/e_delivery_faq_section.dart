import 'package:edeliverysite/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';

class EDeliveryFAQSection extends StatelessWidget {
  const EDeliveryFAQSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: isMobile(context) || is640(context) || is768(context) ? 64 : 128,
        bottom: isMobile(context) || is640(context) || is768(context) ? 32 : 48,
      ),
      constraints: BoxConstraints(
          maxWidth: isMobile(context)
              ? 639
              : is640(context)
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
          const SizedBox(height: 40),
          _buildFAQ(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text('Часті питання',
        style: customTextStyle(
          context,
          fontSize: isMobile(context) || is640(context)
              ? 30
              : is768(context) || is1024(context)
                  ? 35
                  : 48,
        ));
  }

  Widget _buildFAQ(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 20),
        _buildFAQItem(
          context,
          question: "Як зробити замовлення?",
          answer:
              "Ви можете оформити замовлення на нашому сайті, залишивши своє ім'я та номер телефону.",
        ),
        Divider(
          color: const Color(0xFF111827).withOpacity(0.2),
          thickness: 1,
        ),
        const SizedBox(height: 40),
        _buildFAQItem(
          context,
          question: "Які ваші години доставки?",
          answer: "Наші години доставки: з 09:00 до 21:00",
        ),
        Divider(
          color: const Color(0xFF111827).withOpacity(0.2),
          thickness: 1,
        ),
        const SizedBox(height: 40),
        _buildFAQItem(
          context,
          question: "Скільки коштує доставка?",
          answer:
              "Вартість доставки від 80 грн та залежить від відстані. Перегляньте детальні ціни на нашому веб-сайті в розділі Тарифи.",
        ),
        Divider(
          color: const Color(0xFF111827).withOpacity(0.2),
          thickness: 1,
        ),
        const SizedBox(height: 40),
        _buildFAQItem(
          context,
          question: "Які способи оплати ви приймаєте?",
          answer: "Ми приймаємо готівку та онлайн-платежі.",
        ),
      ],
    );
  }

  Widget _buildFAQItem(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return ExpansionTile(
      tilePadding: EdgeInsets.zero,
      childrenPadding: EdgeInsets.zero,
      expandedAlignment: Alignment.centerLeft,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(0),
      ),
      title: Text(
        question,
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
      children: [
        Text(
          answer,
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
        ),
      ],
    );
  }
}
