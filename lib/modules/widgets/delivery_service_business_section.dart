import 'package:delivery_service/modules/resorses/app_colors.dart';
import 'package:delivery_service/modules/resorses/ink_wrapper.dart';
import 'package:delivery_service/modules/resorses/resorses.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryServiceBusinessSection extends StatelessWidget {
  const DeliveryServiceBusinessSection({super.key});

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
                            : 1488,
      ),
      child: Column(
        children: [
          _buildTitle(context),
          const SizedBox(height: 24),
          _buildSubTitle(context),
          const SizedBox(height: 32),
          _buildAdvantages(context),
          const SizedBox(height: 64),
          _buildBtn(context),
        ],
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Співпрацюйте з нами — надійна доставка для вашого бізнесу',
      textAlign: TextAlign.center,
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

  Widget _buildSubTitle(BuildContext context) {
    return SizedBox(
      width: isMobile(context) || is640(context) ? 400 : 600,
      child: Text(
        "Ми пропонуємо комплексні рішення доставки для інтернет-магазинів, ресторанів, квіткових салонів та інших бізнесів.\nЗв’яжіться з нами і ми обговоримо деталі співпраці.",
        textAlign: TextAlign.center,
        style: customTextStyle(
          context,
          fontSize: isMobile(context) || is640(context)
              ? 18
              : is768(context) || is1024(context)
                  ? 22
                  : 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildAdvantages(BuildContext context) {
    return isMobile(context)
        ? Column(
            spacing: 40,
            children: _items(context),
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: _items(context),
          );
  }

  List<Widget> _items(BuildContext context) {
    return [
      _buildItem(
        context,
        title: 'Оперативна доставка',
        img: 'assets/business-feature-1.png',
        description:
            'Швидко доставляємо замовлення вашим клієнтам — вчасно і без затримок.',
      ),
      _buildItem(
        context,
        title: 'Доставка "до дверей"',
        img: 'assets/business-feature-2.png',
        description:
            "Кур’єри доставляють прямо до клієнта, враховуючи особливі побажання.",
      ),
      _buildItem(
        context,
        title: 'Індивідуальні умови',
        img: 'assets/business-feature-3.png',
        description:
            'Пропонуємо гнучкі тарифні плани та рішення відповідно до потреб вашого бізнесу.',
      ),
    ];
  }

  Widget _buildItem(
    BuildContext context, {
    required String title,
    required String img,
    required String description,
  }) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: isMobile(context)
            ? adaptiveWidth(context, 100)
            : is640(context)
                ? (640 / 3) - 40
                : is768(context)
                    ? (768 / 3) - 40
                    : is1024(context)
                        ? (1024 / 3) - 40
                        : is1280(context)
                            ? 1282 / 3
                            : 1488 / 3,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 40,
        horizontal: 35,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.1),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildItemImage(context, img: img),
          const SizedBox(height: 37),
          _buildItemTitle(context, title: title),
          const SizedBox(height: 22),
          _buildItemDesctiption(context, description: description),
        ],
      ),
    );
  }

  Widget _buildItemImage(BuildContext context, {required String img}) {
    return Image.asset(
      img,
      width: 80,
      fit: BoxFit.cover,
    );
  }

  Widget _buildItemTitle(BuildContext context, {required String title}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: customTextStyle(
        context,
        fontSize: isMobile(context) || is640(context)
            ? 20
            : is768(context) || is1024(context)
                ? 24
                : 28,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildItemDesctiption(
    BuildContext context, {
    required String description,
  }) {
    return SizedBox(
      width: isMobile(context) || is640(context) ? 200 : 250,
      child: Text(
        description,
        textAlign: TextAlign.center,
        style: customTextStyle(
          context,
          fontSize: isMobile(context) || is640(context)
              ? 14
              : is768(context) || is1024(context)
                  ? 16
                  : 18,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBtn(BuildContext context) {
    return InkWrapper(
      radius: 0,
      onTap: _onCall,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          'Зв\'язатися з нами',
          style: customTextStyle(
            context,
            fontSize: 20,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }

  Future<void> _onCall() async {
    await launch('tel:0637560067');
  }
}
