// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:edeliverysite/modules/dialogs/message_dialog.dart';
import 'package:edeliverysite/modules/resorses/app_colors.dart';
import 'package:edeliverysite/modules/resorses/ink_wrapper.dart';
import 'package:edeliverysite/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masked_text/masked_text.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class EDeliveryFormSection extends StatefulWidget {
  const EDeliveryFormSection({super.key});

  @override
  State<EDeliveryFormSection> createState() => _EDeliveryFormSectionState();
}

class _EDeliveryFormSectionState extends State<EDeliveryFormSection> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _messageController;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
    _messageController = TextEditingController();

    _phoneController.text = '+38 0';
    _phoneController.addListener(() {
      if (_phoneController.text.isEmpty) {
        _phoneController.text = '+38 0';
        _phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: _phoneController.text.length),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,
        vertical:
            isMobile(context) || is640(context) || is768(context) ? 48 : 80,
      ),
      constraints: BoxConstraints(
          maxWidth: is768(context)
              ? 768
              : is1024(context)
                  ? 1024
                  : is1280(context)
                      ? 1282
                      : 1488),
      child: isMobile(context) || is640(context) || is768(context)
          ? _buildTabletAndMobileVersion()
          : _buildLaptopVersion(),
    );
  }

  Widget _buildTabletAndMobileVersion() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: _buildTitle(),
        ),
        const SizedBox(height: 28),
        _buildText(),
        const SizedBox(height: 40),
        _buildForm(),
      ],
    );
  }

  Widget _buildLaptopVersion() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildForm(),
        const SizedBox(width: 80),
        _buildMessage(),
      ],
    );
  }

  Widget _buildForm() {
    return Container(
      constraints: BoxConstraints(
          maxWidth: is768(context)
              ? 720
              : is1024(context)
                  ? 448
                  : is1280(context)
                      ? 576
                      : 704),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isMobile(context) || is640(context) || is768(context)
                ? _buildFieldsForTabletAndMobile()
                : _buildFieldsForLaptop(),
            const SizedBox(height: 16),
            _buildField(
              label: 'Повідомлення',
              controller: _messageController,
              validator: _emptyValidator,
              maxLines: 6,
              width: is768(context)
                  ? 720
                  : is1024(context)
                      ? 448
                      : is1280(context)
                          ? 576
                          : 704,
            ),
            const SizedBox(height: 32),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildFieldsForTabletAndMobile() {
    return Column(
      children: [
        _buildField(
          label: 'Ім\'я',
          controller: _nameController,
          validator: _emptyValidator,
          width: isMobile(context) || is640(context) || is768(context)
              ? 720
              : is1024(context)
                  ? 216
                  : is1280(context)
                      ? 280
                      : 344,
        ),
        const SizedBox(height: 16),
        _buildPhoneField(
          label: 'Номер телефону',
          controller: _phoneController,
          validator: _phoneValidator,
          width: isMobile(context) || is640(context) || is768(context)
              ? 720
              : is1024(context)
                  ? 216
                  : is1280(context)
                      ? 280
                      : 344,
        ),
      ],
    );
  }

  Widget _buildFieldsForLaptop() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildField(
          label: 'Ім\'я',
          controller: _nameController,
          validator: _emptyValidator,
          width: is1024(context)
              ? 216
              : is1280(context)
                  ? 280
                  : 344,
        ),
        _buildPhoneField(
          label: 'Номер телефону',
          controller: _phoneController,
          validator: _phoneValidator,
          width: is1024(context)
              ? 216
              : is1280(context)
                  ? 280
                  : 344,
        ),
      ],
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    required double width,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        SizedBox(
          width: width,
          child: TextFormField(
            controller: controller,
            maxLines: maxLines,
            validator: validator,
            keyboardType: keyboardType,
            cursorColor: const Color(0xFF111827),
            inputFormatters: [
              if (keyboardType == TextInputType.number)
                FilteringTextInputFormatter.digitsOnly,
            ],
            style: customTextStyle(
              context,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(0, 0, 0, 0.07),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.07),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF6366F1),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEF4444),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEF4444),
                ),
              ),
              errorStyle: customTextStyle(
                context,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    required double width,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        SizedBox(
          width: width,
          child: MaskedTextField(
            mask: '+38 0## ### ## ##',
            controller: controller,
            validator: validator,
            keyboardType: TextInputType.phone,
            cursorColor: AppColors.black,
            style: customTextStyle(
              context,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              fillColor: const Color.fromRGBO(0, 0, 0, 0.07),
              filled: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(0, 0, 0, 0.07),
                ),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFF6366F1),
                ),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEF4444),
                ),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xFFEF4444),
                ),
              ),
              errorStyle: customTextStyle(
                context,
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: AppColors.error,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: customTextStyle(
        context,
        fontSize: 16,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: InkWrapper(
        radius: 0,
        onTap: _onSubmit,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 16,
          ),
          color: const Color(0xFFFBC700),
          child: Text(
            'Замовити',
            textAlign: TextAlign.center,
            style: customTextStyle(
              context,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMessage() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTitle(),
          const SizedBox(height: 16),
          _buildText(),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    return Text(
      'Замовити',
      style: customTextStyle(
        context,
        fontSize: isMobile(context) || is640(context)
            ? 24
            : is768(context)
                ? 28
                : 32,
      ),
    );
  }

  Widget _buildText() {
    return Text(
      'Зв\'яжіться з нами за допомогою контактної форми. Ми раді допомогти вам із доставкою в Дрогобичі та за його межами.',
      style: customTextStyle(
        context,
        fontSize:
            isMobile(context) || is640(context) || is768(context) ? 16 : 18,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  String? _emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не може бути порожнім';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value!.isEmpty || value == '+38 0') {
      return 'Поле не може бути порожнім';
    }
    if (value.length < 17) {
      return 'Номер телефону повинен містити 9 цифр';
    }
    return null;
  }

  Future<void> _onSubmit() async {
    if (_formKey.currentState!.validate()) {
      final DateTime timeAfter9Evening = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        21,
        0,
      );
      final DateTime timeBefore9Morning = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        9,
        0,
      );
      if (DateTime.now().isAfter(timeAfter9Evening) ||
          DateTime.now().isBefore(timeBefore9Morning)) {
        _showMessage(
          title: 'Помилка',
          message: 'Замовлення можливе з 9:00 до 21:00',
        );
      } else {
        await _sendMessage();
      }
    } else {
      _showMessage(
        title: 'Помилка',
        message: 'Заповніть всі поля',
      );
    }
  }

  void _showMessage({
    required String title,
    required String message,
    VoidCallback? onClose,
  }) {
    showDialog(
      barrierColor: AppColors.black.withOpacity(0.5),
      barrierDismissible: false,
      context: context,
      builder: (context) => MessageDialog(
        title: title,
        message: message,
        onClose: onClose ?? () => Navigator.of(context).pop(),
      ),
    );
  }

  Future<void> _sendMessage() async {
    final username = (await Telegram(TELEGRAM_BOT_API).getMe()).username;
    final TeleDart teledart = TeleDart(
      TELEGRAM_BOT_API,
      Event(username!),
    );
    const String line = '--------------------------------';
    final String phone = _phoneController.text.trim().replaceAll(' ', '');
    final comment = _messageController.text.isNotEmpty
        ? _messageController.text.trim()
        : 'Не вказано';
    final String message = "Нове замовлення через форму\n" +
        "$line\n" +
        "Клієнт: ${_nameController.text}\n" +
        "Номер телефону: $phone\n" +
        "Коментар: $comment";
    await teledart.sendMessage(TELEGRAM_CHAT_ID, message);
    _showMessage(
      title: 'Успішно',
      message: 'Замовлення відправлено. Очікуйте дзвінка!.',
      onClose: () {
        Navigator.of(context).pop();
      },
    );
    _nameController.clear();
    _phoneController.clear();
    _messageController.clear();
  }
}
