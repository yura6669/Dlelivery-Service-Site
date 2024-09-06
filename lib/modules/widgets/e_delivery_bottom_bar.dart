import 'package:edeliverysite/modules/resorses/ink_wrapper.dart';
import 'package:edeliverysite/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class EDeliveryBottomBar extends StatelessWidget {
  const EDeliveryBottomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: double.infinity,
          height: 212,
          color: const Color.fromRGBO(0, 0, 0, 0.07),
        ),
        Container(
          height: 212,
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
          padding: const EdgeInsets.symmetric(
            horizontal: 24,
          ),
          child: Row(
            children: [
              _buildLogoAndText(context),
              const Spacer(),
              if (!isMobile(context))
                _buildNumberAndSocialsWithoutMobile(context),
              if (isMobile(context)) _buildNumberAndSocialsWithMobile(context),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildNumberAndSocialsWithoutMobile(BuildContext context) {
    return Row(
      children: [
        InkWrapper(
          radius: 0,
          onTap: () => _launchPhone('+380637560067'),
          child: Text(
            '+38 067 673 34 60',
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

  Widget _buildNumberAndSocialsWithMobile(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWrapper(
          radius: 0,
          onTap: () => _launchPhone('+380637560067'),
          child: Text(
            '+38 063 756 00 67',
            style: customTextStyle(
              context,
              fontSize: isMobile(context) || is640(context) ? 14 : 16,
            ),
          ),
        ),
        const SizedBox(height: 24),
        Row(
          children: [
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
        ),
      ],
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
          width: isMobile(context) || is640(context) ? 16 : 24,
          height: isMobile(context) || is640(context) ? 16 : 24,
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
