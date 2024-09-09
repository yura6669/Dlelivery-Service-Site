import 'package:delivery_service/modules/resorses/app_colors.dart';
import 'package:delivery_service/modules/resorses/ink_wrapper.dart';
import 'package:delivery_service/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MenuDialog extends StatelessWidget {
  final VoidCallback onClose;
  const MenuDialog({required this.onClose, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      child: Container(
        color: AppColors.white,
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            _buildLogoAndClose(context),
            const SizedBox(height: 24),
            _buildPhone(context),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
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
        ),
      ),
    );
  }

  Widget _buildLogoAndClose(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          'assets/logo.png',
          width: isMobile(context) || is640(context) ? 36 : 48,
          height: isMobile(context) || is640(context) ? 36 : 48,
        ),
        IconButton(
          icon: const Icon(Icons.close, size: 36),
          onPressed: onClose,
        ),
      ],
    );
  }

  Widget _buildPhone(BuildContext context) {
    return InkWrapper(
      radius: 0,
      onTap: () => _launchPhone('+380637560067'),
      child: Text(
        '+38 063 756 00 67',
        style: customTextStyle(
          context,
          fontSize: is640(context) ? 14 : 16,
        ),
      ),
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
