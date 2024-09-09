import 'package:delivery_service/modules/resorses/app_colors.dart';
import 'package:delivery_service/modules/resorses/ink_wrapper.dart';
import 'package:delivery_service/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';

class MessageDialog extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onClose;
  final String? btnText;
  const MessageDialog({
    required this.title,
    required this.message,
    required this.onClose,
    this.btnText,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        color: AppColors.white,
        width: 640,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildTitle(context),
            const SizedBox(height: 24),
            _buildMessage(context),
            const SizedBox(height: 24),
            _buildCloseBtn(context),
          ],
        ),
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      title,
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

  Widget _buildMessage(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: customTextStyle(
        context,
        fontSize: isMobile(context) || is640(context)
            ? 24
            : is768(context) || is1024(context)
                ? 28
                : 32,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  _buildCloseBtn(BuildContext context) {
    return InkWrapper(
      radius: 0,
      onTap: onClose,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 12,
        ),
        width: double.infinity,
        decoration: const BoxDecoration(
          color: Color(0xFFFBC700),
        ),
        child: Text(
          btnText ?? 'Закрити',
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
}
