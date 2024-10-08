import 'package:delivery_service/modules/resorses/ink_wrapper.dart';
import 'package:delivery_service/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class DeliveryServiceAppBar extends StatelessWidget {
  final VoidCallback onOpenMenu;
  const DeliveryServiceAppBar({required this.onOpenMenu, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxWidth: isMobile(context) || is640(context)
            ? 640
            : is768(context)
                ? 768
                : is1024(context)
                    ? 1024
                    : is1280(context)
                        ? 1232
                        : 1488,
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Row(
            children: [
              _buildLogoAndText(context),
            ],
          ),
          const Spacer(),
          if (!isMobile(context)) _buildNumberAndSocials(context),
          if (isMobile(context)) _buildMenu(context),
        ],
      ),
    );
  }

  Widget _buildNumberAndSocials(BuildContext context) {
    return Row(
      children: [
        InkWrapper(
          radius: 0,
          onTap: () => _launchPhone('+380637560067'),
          child: Text(
            '+38 063 756 00 67',
            style: customTextStyle(
              context,
              fontSize: is640(context) ? 14 : 16,
            ),
          ),
        ),
        const SizedBox(width: 24),
        _buildSocialIcon(
          context,
          path: 'assets/facebook.png',
          onPressed: () => _launchURL('https://www.facebook.com/'),
        ),
        const SizedBox(width: 16),
        _buildSocialIcon(
          context,
          path: 'assets/instagram.png',
          onPressed: () => _launchURL('https://www.instagram.com/'),
        ),
      ],
    );
  }

  Widget _buildMenu(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.menu, size: 36),
      onPressed: onOpenMenu,
    );
  }

  Widget _buildLogoAndText(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          'assets/logo.png',
          width: isMobile(context) || is640(context) ? 36 : 48,
          height: isMobile(context) || is640(context) ? 36 : 48,
        ),
        if (!isMobile(context))
          Text(
            'Delivery Service',
            style: customTextStyle(
              context,
              fontSize: isMobile(context) || is640(context) || is768(context)
                  ? 23
                  : is1024(context) || is1280(context)
                      ? 29
                      : 30,
            ),
          ),
      ],
    );
  }

  Widget _buildSocialIcon(
    BuildContext context, {
    required String path,
    required VoidCallback onPressed,
  }) {
    return InkWrapper(
      radius: 100,
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 1),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset(
          path,
          width: is640(context) ? 16 : 24,
          height: is640(context) ? 16 : 24,
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    await launch(url);
  }

  Future<void> _launchPhone(String phone) async {
    await launch('tel:$phone');
  }
}
