// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:delivery_service/modules/dialogs/message_dialog.dart';
import 'package:delivery_service/modules/resorses/app_colors.dart';
import 'package:delivery_service/modules/resorses/ink_wrapper.dart';
import 'package:delivery_service/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masked_text/masked_text.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class BusinessDialog extends StatefulWidget {
  final VoidCallback onClose;
  const BusinessDialog({required this.onClose, super.key});

  @override
  State<BusinessDialog> createState() => _BusinessDialogState();
}

class _BusinessDialogState extends State<BusinessDialog> {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _phoneController;
  late TextEditingController _siteController;
  late TextEditingController _emailController;

  late DeliveriesEachWeek _deliveriesEachWeek;

  late TextEditingController _businessDirectionController;

  late bool _isLoader = false;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _surnameController = TextEditingController();
    _phoneController = TextEditingController();
    _siteController = TextEditingController();
    _emailController = TextEditingController();

    _deliveriesEachWeek = DeliveriesEachWeek.until10;

    _businessDirectionController = TextEditingController();

    _isLoader = false;

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
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _phoneController.dispose();
    _siteController.dispose();
    _emailController.dispose();
    _businessDirectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            color: AppColors.white,
            constraints: BoxConstraints(
              maxWidth: isMobile(context) || is640(context)
                  ? 640
                  : is768(context)
                      ? 768
                      : is1024(context)
                          ? 1024
                          : is1280(context)
                              ? 1282
                              : 1488,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                _buildLogoAndTitleAndClose(),
                if (isMobile(context)) const SizedBox(height: 24),
                if (isMobile(context)) _buildTitle(),
                const SizedBox(height: 24),
                Expanded(
                  child: SingleChildScrollView(
                    child: _buildForm(),
                  ),
                ),
              ],
            ),
          ),
          if (_isLoader) _buildLoader(),
        ],
      ),
    );
  }

  Widget _buildLoader() {
    return Container(
      color: AppColors.black.withOpacity(0.5),
      child: const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
        ),
      ),
    );
  }

  Widget _buildLogoAndTitleAndClose() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          width: isMobile(context) || is640(context) ? 36 : 48,
          height: isMobile(context) || is640(context) ? 36 : 48,
        ),
        if (!isMobile(context)) _buildTitle(),
        IconButton(
          icon: const Icon(Icons.close, size: 36),
          onPressed: widget.onClose,
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      'Доставляй швидше з Delivery Service',
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

  Widget _buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildField(
            label: "Ваше ім'я",
            controller: _nameController,
            validator: _emptyValidator,
          ),
          const SizedBox(height: 24),
          _buildField(
            label: "Ваше прізвище",
            controller: _surnameController,
            validator: _emptyValidator,
          ),
          const SizedBox(height: 24),
          _buildPhoneField(
            label: "Ваш номер телефону",
            controller: _phoneController,
            validator: _phoneValidator,
          ),
          const SizedBox(height: 24),
          _buildField(
            label: "Ваш сайт",
            controller: _siteController,
            validator: null,
          ),
          const SizedBox(height: 24),
          _buildField(
            label: "Ваш email",
            controller: _emailController,
            validator: _emailValidator,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 24),
          _buildLabel('Скільки доставок ви здійснюєте щотижня?'),
          _buildDeliveriesEachWeek(),
          const SizedBox(height: 24),
          _buildField(
            label: "Розкажіть детальніше про Ваш бізнес",
            controller: _businessDirectionController,
            validator: null,
            maxLines: 3,
          ),
          const SizedBox(height: 24),
          _buildBtn(),
        ],
      ),
    );
  }

  Widget _buildDeliveriesEachWeek() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          children: [
            ...DeliveriesEachWeek.values.map(
              (deliveryEachWeek) => _buildDeliveryEachItem(deliveryEachWeek),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDeliveryEachItem(DeliveriesEachWeek deliveryEachWeek) {
    return InkWrapper(
      radius: 10,
      onTap: () => _changDeliveryServiceEachWeek(deliveryEachWeek),
      child: Container(
        constraints: BoxConstraints(
          minWidth: isMobile(context)
              ? double.infinity
              : is1280(context)
                  ? adaptiveWidth(context, 100) / 6.25
                  : 180,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.07),
          border: Border.all(
            color: deliveryEachWeek == _deliveriesEachWeek
                ? const Color(0xFF6366F1)
                : const Color.fromRGBO(0, 0, 0, 0.07),
            width: deliveryEachWeek == _deliveriesEachWeek ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          getDeliveriesEachWeek(deliveryEachWeek),
          textAlign: TextAlign.center,
          style: customTextStyle(
            context,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    required String? Function(String?)? validator,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    double? width,
    String? hint,
    bool isSuffix = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        SizedBox(
          width: width ??
              (isMobile(context) || is640(context)
                  ? 640
                  : is768(context)
                      ? 768
                      : is1024(context)
                          ? 1024
                          : is1280(context)
                              ? 1282
                              : 1488),
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
              hintText: hint,
              hintStyle: customTextStyle(
                context,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              suffixText: isSuffix ? 'грн' : null,
              suffixStyle: customTextStyle(
                context,
                fontSize: 16,
                fontWeight: FontWeight.w600,
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
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildLabel(label),
        SizedBox(
          width: isMobile(context) || is640(context)
              ? 640
              : is768(context)
                  ? 768
                  : is1024(context)
                      ? 1024
                      : is1280(context)
                          ? 1282
                          : 1488,
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

  Widget _buildBtn() {
    return InkWrapper(
      radius: 0,
      onTap: _onSend,
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
          'Відправити',
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

  String? _emptyValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не може бути порожнім';
    }
    return null;
  }

  String? _phoneValidator(String? value) {
    if (value!.isEmpty || value == '+38 0') {
      return 'Поле не може бути пустим';
    }
    if (value.length < 17) {
      return 'Номер телефону повинен містити 9 цифр';
    }
    return null;
  }

  String? _emailValidator(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Введіть коректний email'
        : null;
  }

  void _changDeliveryServiceEachWeek(DeliveriesEachWeek deliveryEachWeek) {
    setState(() {
      _deliveriesEachWeek = deliveryEachWeek;
    });
  }

  Future<void> _onSend() async {
    _isLoader = true;
    setState(() {});
    if (_formKey.currentState!.validate()) {
      await _sendMessage();
      _isLoader = false;
      setState(() {});
      _showMessage(
        title: 'Успішно',
        message: 'Ваша заявка успішно відправлена. Очікуйте на дзвінок.',
        onClose: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      );
    } else {
      _showMessage(
        title: 'Помилка',
        message: 'Заповніть всі поля',
      );
      _isLoader = false;
      setState(() {});
    }
  }

  Future<void> _sendMessage() async {
    final username = (await Telegram(TELEGRAM_BOT_API).getMe()).username;
    final TeleDart teledart = TeleDart(
      TELEGRAM_BOT_API,
      Event(username!),
    );
    const String line = '--------------------------------';
    final String phone = _phoneController.text.trim().replaceAll(' ', '');
    final siteInfo = _siteController.text.isNotEmpty
        ? _siteController.text.trim()
        : 'Не вказано';
    final emailInfo = _emailController.text.isNotEmpty
        ? _emailController.text.trim()
        : 'Не вказано';
    final businessInfo = _businessDirectionController.text.isNotEmpty
        ? _businessDirectionController.text.trim()
        : 'Не вказано';
    final String message = "Потенційна співпраця\n" +
        "$line\n" +
        "Клієнт: ${_nameController.text} ${_surnameController.text}\n" +
        "Номер телефону: $phone\n" +
        "Сайт: $siteInfo\n" +
        "Пошта: $emailInfo\n" +
        "Кількість доставок на тиждень: ${getDeliveriesEachWeek(_deliveriesEachWeek)}\n" +
        "Детальніше про бізнес: $businessInfo\n";
    await teledart.sendMessage(TELEGRAM_CHAT_ID, message);
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
}
