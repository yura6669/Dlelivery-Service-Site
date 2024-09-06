import 'package:edeliverysite/modules/resorses/ink_wrapper.dart';
import 'package:edeliverysite/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';

class EDeliveryPromoSection extends StatelessWidget {
  final VoidCallback onOrder;
  final VoidCallback onForBusiness;
  const EDeliveryPromoSection(
      {required this.onOrder, required this.onForBusiness, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical:
            isMobile(context) || is640(context) || is768(context) ? 80 : 192,
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
      child: isMobile(context) || is640(context) || is768(context)
          ? _buildTabletAndMobileVersion(context)
          : _buildLaptopVersion(context),
    );
  }

  Widget _buildTabletAndMobileVersion(BuildContext context) {
    return Column(
      children: [
        _buildTitle(context),
        const SizedBox(height: 24),
        _buildSubtitle(context),
        const SizedBox(height: 24),
        if (is768(context)) _buildBtns(context),
        if (isMobile(context) || is640(context)) const SizedBox(height: 24),
        if (isMobile(context) || is640(context))
          _buildBtn(
            context,
            text: 'Замовити',
            btnColor: const Color(0xFFFBC700),
            isBorder: false,
            onPressed: onOrder,
          ),
        if (isMobile(context) || is640(context)) const SizedBox(height: 24),
        if (isMobile(context) || is640(context))
          _buildBtn(
            context,
            text: 'Для бізнесу',
            btnColor: Colors.transparent,
            isBorder: true,
            onPressed: onForBusiness,
          ),
        const SizedBox(height: 40),
        _buildImage(context),
      ],
    );
  }

  Widget _buildLaptopVersion(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: is1024(context)
              ? 448
              : is1280(context)
                  ? 576
                  : 704,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTitle(context),
              const SizedBox(height: 24),
              _buildSubtitle(context),
              const SizedBox(height: 32),
              _buildBtns(context),
            ],
          ),
        ),
        const Spacer(),
        _buildImage(context),
      ],
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      'Отримайте швидку доставку сьогодні',
      style: customTextStyle(
        context,
        fontSize: isMobile(context) || is640(context)
            ? 36
            : is768(context) || is1024(context)
                ? 46
                : 72,
      ),
    );
  }

  Widget _buildSubtitle(BuildContext context) {
    return Text(
      'Надійна служба доставки в Дрогобичі та Дрогобицькому районі. Ми гарантуємо, що ваші замовлення прибудуть швидко та безпечно.',
      style: customTextStyle(
        context,
        fontSize: isMobile(context) ||
                is640(context) ||
                is768(context) ||
                is1024(context)
            ? 18
            : 24,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildBtns(BuildContext context) {
    return Row(
      children: [
        _buildBtn(
          context,
          text: 'Замовити',
          btnColor: const Color(0xFFFBC700),
          isBorder: false,
          onPressed: onOrder,
        ),
        const SizedBox(width: 16),
        _buildBtn(
          context,
          text: 'Для бізнесу',
          btnColor: Colors.transparent,
          isBorder: true,
          onPressed: onForBusiness,
        ),
      ],
    );
  }

  Widget _buildBtn(
    BuildContext context, {
    required String text,
    required Color btnColor,
    required bool isBorder,
    required VoidCallback onPressed,
  }) {
    return InkWrapper(
      radius: 0,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        width: isMobile(context) || is640(context) ? double.infinity : null,
        decoration: BoxDecoration(
          color: btnColor,
          border: isBorder
              ? Border.all(
                  color: const Color(0xFF111827),
                  width: 1,
                )
              : null,
        ),
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: customTextStyle(
            context,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Container(
        height: isMobile(context) || is640(context)
            ? 600
            : is768(context)
                ? 720
                : is1024(context)
                    ? 448
                    : is1280(context)
                        ? 576
                        : 704,
        width: isMobile(context) || is640(context)
            ? 600
            : is768(context)
                ? 720
                : is1024(context)
                    ? 448
                    : is1280(context)
                        ? 576
                        : 704,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/promo.jpg'),
            fit: BoxFit.cover,
          ),
        ));
  }
}
