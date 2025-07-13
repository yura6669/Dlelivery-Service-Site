// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_adjacent_string_concatenation

import 'package:delivery_service/modules/dialogs/message_dialog.dart';
import 'package:delivery_service/modules/resorses/app_colors.dart';
import 'package:delivery_service/modules/resorses/ink_wrapper.dart';
import 'package:delivery_service/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';
import 'package:masked_text/masked_text.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';

class OrderForm extends StatefulWidget {
  const OrderForm({super.key});

  @override
  State<OrderForm> createState() => _OrderFormState();
}

class _OrderFormState extends State<OrderForm> {
  late GlobalKey<FormState> _formKey;
  late TextEditingController _fromAddressController;
  late TextEditingController _fromNumberController;
  late TextEditingController _toAddressController;
  late TextEditingController _toNumberController;

  late PackageType? _packageType;
  late TextEditingController _packageNumberController;
  late TextEditingController _otherController;
  late bool _isPaid;
  late TextEditingController _paidSumController;

  late DateTime? _orderTime;
  late PaymentType? _paymentType;
  late bool _paidRecipiend;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    _fromAddressController = TextEditingController();
    _fromNumberController = TextEditingController();
    _toAddressController = TextEditingController();
    _toNumberController = TextEditingController();

    _packageType = null;
    _packageNumberController = TextEditingController();
    _otherController = TextEditingController();
    _isPaid = false;
    _paidSumController = TextEditingController();

    _orderTime = null;
    _paymentType = null;
    _paidRecipiend = false;

    _fromNumberController.text = '+38 0';
    _fromNumberController.addListener(() {
      if (_fromNumberController.text.isEmpty) {
        _fromNumberController.text = '+38 0';
        _fromNumberController.selection = TextSelection.fromPosition(
          TextPosition(offset: _fromNumberController.text.length),
        );
      }
    });

    _toNumberController.text = '+38 0';
    _toNumberController.addListener(() {
      if (_toNumberController.text.isEmpty) {
        _toNumberController.text = '+38 0';
        _toNumberController.selection = TextSelection.fromPosition(
          TextPosition(offset: _toNumberController.text.length),
        );
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? packagePlaceholder;
    if (_packageType == PackageType.medicine) {
      packagePlaceholder = 'Номер бронювання';
    }
    if (_packageType == PackageType.parcel) {
      packagePlaceholder = 'Номер декларації';
    }

    bool isShowOther = false;
    if (_packageType == PackageType.other) {
      isShowOther = true;
    }
    return Container(
      width: double.infinity,
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
      padding: const EdgeInsets.symmetric(
        vertical: 50,
        horizontal: 25,
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
      child: isMobile(context)
          ? _buildFormForMobile(
              packagePlaceholder: packagePlaceholder,
              isShowOther: isShowOther,
            )
          : _buildForm(
              packagePlaceholder: packagePlaceholder,
              isShowOther: isShowOther,
            ),
    );
  }

  Widget _buildForm({
    required String? packagePlaceholder,
    required bool isShowOther,
  }) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          Row(
            children: [
              _buildField(
                controller: _fromAddressController,
                placeholder: 'Звідки',
                icon: const Icon(Icons.location_on_sharp),
                validator: _validateAddress,
              ),
              const SizedBox(width: 30),
              _buildField(
                controller: _toAddressController,
                placeholder: 'Куди',
                icon: const Icon(Icons.location_on_sharp),
                validator: _validateAddress,
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              _buildField(
                controller: _fromNumberController,
                placeholder: 'Номер відправника',
                icon: const Icon(Icons.phone_sharp),
                validator: _validateNumber,
                inputType: TextInputType.phone,
                mask: '+38 0## ### ## ##',
              ),
              const SizedBox(width: 30),
              _buildField(
                controller: _toNumberController,
                placeholder: 'Номер отримувача',
                icon: const Icon(Icons.phone_sharp),
                validator: _validateNumber,
                inputType: TextInputType.phone,
                mask: '+38 0## ### ## ##',
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            children: [
              _buildchoosePackageType(),
              if (packagePlaceholder != null || isShowOther)
                const SizedBox(width: 30),
              if (packagePlaceholder != null)
                _buildField(
                  controller: _packageNumberController,
                  placeholder: packagePlaceholder,
                  icon: const Icon(Icons.numbers_sharp),
                  validator: _validatePackageNumber,
                  inputType: TextInputType.number,
                ),
              if (isShowOther)
                _buildField(
                  controller: _otherController,
                  placeholder: 'Що веземо?',
                  icon: const Icon(Icons.question_mark_sharp),
                  validator: _validateOther,
                ),
            ],
          ),
          if (_packageType != null && _isPaid) const SizedBox(height: 30),
          if (_packageType != null)
            Row(
              children: [
                _buildPaidSwitch(),
                if (_isPaid) const SizedBox(width: 30),
                if (_isPaid)
                  _buildField(
                    controller: _paidSumController,
                    placeholder: 'Ввести суму для оплати',
                    icon: const Icon(Icons.money_sharp),
                    validator: _validatePaidSum,
                    inputType: TextInputType.number,
                    isExpand: true,
                  ),
              ],
            ),
          const SizedBox(height: 30),
          Row(
            children: [
              _buildchoosePaymentType(),
              const SizedBox(width: 30),
              _buildchooseTime(),
            ],
          ),
          if (_paymentType != null) _buildWhoPaidSwitch(),
          const SizedBox(height: 50),
          _buildBtn(),
        ],
      ),
    );
  }

  Widget _buildFormForMobile({
    required String? packagePlaceholder,
    required bool isShowOther,
  }) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildField(
            controller: _fromAddressController,
            placeholder: 'Звідки',
            icon: const Icon(Icons.location_on_sharp),
            validator: _validateAddress,
            isForColumn: true,
          ),
          const SizedBox(height: 30),
          _buildField(
            controller: _fromNumberController,
            placeholder: 'Номер відправника',
            icon: const Icon(Icons.phone_sharp),
            validator: _validateNumber,
            inputType: TextInputType.phone,
            mask: '+38 0## ### ## ##',
            isForColumn: true,
          ),
          const SizedBox(height: 30),
          _buildField(
            controller: _toAddressController,
            placeholder: 'Куди',
            icon: const Icon(Icons.location_on_sharp),
            validator: _validateAddress,
            isForColumn: true,
          ),
          const SizedBox(height: 30),
          _buildField(
            controller: _toNumberController,
            placeholder: 'Номер отримувача',
            icon: const Icon(Icons.phone_sharp),
            validator: _validateNumber,
            inputType: TextInputType.phone,
            mask: '+38 0## ### ## ##',
            isForColumn: true,
          ),
          const SizedBox(height: 30),
          _buildchoosePackageType(isForColumn: true),
          if (packagePlaceholder != null || isShowOther)
            const SizedBox(height: 30),
          if (packagePlaceholder != null)
            _buildField(
              controller: _packageNumberController,
              placeholder: packagePlaceholder,
              icon: const Icon(Icons.numbers_sharp),
              validator: _validatePackageNumber,
              inputType: TextInputType.number,
              isForColumn: true,
            ),
          if (isShowOther)
            _buildField(
              controller: _otherController,
              placeholder: 'Що веземо?',
              icon: const Icon(Icons.question_mark_sharp),
              validator: _validateOther,
              isForColumn: true,
            ),
          if (_packageType != null)
            Column(
              children: [
                _buildPaidSwitch(),
                if (_isPaid) const SizedBox(height: 30),
                if (_isPaid)
                  _buildField(
                    controller: _paidSumController,
                    placeholder: 'Ввести суму для оплати',
                    icon: const Icon(Icons.money_sharp),
                    validator: _validatePaidSum,
                    inputType: TextInputType.number,
                    isExpand: true,
                    isForColumn: true,
                  ),
              ],
            ),
          const SizedBox(height: 30),
          _buildchoosePaymentType(isForColumn: true),
          if (_paymentType != null) _buildWhoPaidSwitch(),
          const SizedBox(height: 30),
          _buildchooseTime(isForColumn: true),
          const SizedBox(height: 50),
          _buildBtn(),
        ],
      ),
    );
  }

  Widget _buildField({
    required TextEditingController controller,
    required String placeholder,
    required Icon icon,
    required String? Function(String?) validator,
    TextInputType inputType = TextInputType.text,
    bool isExpand = false,
    bool isForColumn = false,
    String? mask,
  }) {
    return Expanded(
      flex: isForColumn
          ? 0
          : isExpand
              ? 2
              : 1,
      child: MaskedTextField(
        controller: controller,
        mask: mask,
        validator: validator,
        style: customTextStyle(
          context,
          fontSize: 20,
          color: AppColors.formTextColor,
        ),
        keyboardType: inputType,
        cursorColor: AppColors.formTextColor,
        decoration: InputDecoration(
          hintText: placeholder,
          prefixIcon: icon,
          prefixIconColor: AppColors.orange,
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 1,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            borderSide: BorderSide(
              color: AppColors.borderColor,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            borderSide: BorderSide(
              color: AppColors.orange,
              width: 1,
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            borderSide: BorderSide(
              color: AppColors.error,
              width: 1,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(3)),
            borderSide: BorderSide(
              color: AppColors.error,
              width: 1,
            ),
          ),
          filled: true,
          fillColor: AppColors.grey,
          errorStyle: customTextStyle(
            context,
            fontSize: 14,
            color: AppColors.error,
          ),
          hintStyle: customTextStyle(
            context,
            fontSize: 20,
            color: AppColors.formTextColor,
          ),
          errorMaxLines: 2,
        ),
      ),
    );
  }

  Widget _buildchoosePackageType({
    bool isForColumn = false,
  }) {
    return Expanded(
      flex: isForColumn ? 0 : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<PackageType>(
            isExpanded: true,
            value: _packageType,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.orange,
              size: 30,
            ),
            hint: Row(
              children: [
                const Icon(
                  Icons.shopping_bag_sharp,
                  color: AppColors.orange,
                ),
                const SizedBox(width: 10),
                Text(
                  getPackageType(null),
                  style: customTextStyle(
                    context,
                    fontSize: 20,
                    color: AppColors.formTextColor,
                  ),
                ),
              ],
            ),
            items: PackageType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                  getPackageType(type),
                  style: customTextStyle(
                    context,
                    fontSize: 20,
                    color: AppColors.formTextColor,
                  ),
                ),
              );
            }).toList(),
            onChanged: (PackageType? value) {
              setState(() {
                _packageType = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildchoosePaymentType({
    bool isForColumn = false,
  }) {
    return Expanded(
      flex: isForColumn ? 0 : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<PaymentType>(
            isExpanded: true,
            value: _paymentType,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.orange,
              size: 30,
            ),
            hint: Row(
              children: [
                const Icon(
                  Icons.payments_sharp,
                  color: AppColors.orange,
                ),
                const SizedBox(width: 10),
                Text(
                  getPaymentType(null),
                  style: customTextStyle(
                    context,
                    fontSize: 20,
                    color: AppColors.formTextColor,
                  ),
                ),
              ],
            ),
            items: PaymentType.values.map((type) {
              return DropdownMenuItem(
                value: type,
                child: Text(
                  getPaymentType(type),
                  style: customTextStyle(
                    context,
                    fontSize: 20,
                    color: AppColors.formTextColor,
                  ),
                ),
              );
            }).toList(),
            onChanged: (PaymentType? value) {
              setState(() {
                _paymentType = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildchooseTime({
    bool isForColumn = false,
  }) {
    final List<DateTime> slots = generateAvailableDateTimes();
    return Expanded(
      flex: isForColumn ? 0 : 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: AppColors.grey,
          borderRadius: BorderRadius.circular(3),
          border: Border.all(
            color: AppColors.borderColor,
            width: 1,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<DateTime>(
            isExpanded: true,
            value: _orderTime,
            icon: const Icon(
              Icons.arrow_drop_down,
              color: AppColors.orange,
              size: 30,
            ),
            hint: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: AppColors.orange,
                ),
                const SizedBox(width: 10),
                Text(
                  formatTime(null),
                  style: customTextStyle(
                    context,
                    fontSize: 20,
                    color: AppColors.formTextColor,
                  ),
                ),
              ],
            ),
            items: slots.map((slot) {
              return DropdownMenuItem(
                value: slot,
                child: Text(
                  formatTime(slot),
                  style: customTextStyle(
                    context,
                    fontSize: 20,
                    color: AppColors.formTextColor,
                  ),
                ),
              );
            }).toList(),
            onChanged: (DateTime? value) {
              setState(() {
                _orderTime = value;
              });
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPaidSwitch() {
    return Row(
      children: [
        Text(
          'Оплачено/Не оплачено',
          style: customTextStyle(
            context,
            fontSize: 20,
            color: AppColors.formTextColor,
          ),
        ),
        const SizedBox(width: 10),
        Switch(
          value: _isPaid,
          onChanged: (value) => setState(() => _isPaid = value),
          activeColor: AppColors.orange,
        ),
      ],
    );
  }

  Widget _buildWhoPaidSwitch() {
    return Row(
      children: [
        Text(
          'Відправник/Одержувач',
          style: customTextStyle(
            context,
            fontSize: 20,
            color: AppColors.formTextColor,
          ),
        ),
        const SizedBox(width: 10),
        Switch(
          value: _paidRecipiend,
          onChanged: (value) => setState(() => _paidRecipiend = value),
          activeColor: AppColors.orange,
        ),
      ],
    );
  }

  Widget _buildBtn() {
    return InkWrapper(
      radius: 0,
      onTap: _onCreate,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 70),
        decoration: BoxDecoration(
          color: AppColors.orange,
          borderRadius: BorderRadius.circular(3),
        ),
        child: Text(
          'Замовити доставку',
          style: customTextStyle(
            context,
            fontSize: 20,
            color: AppColors.black,
          ),
        ),
      ),
    );
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Заповніть адресу відправника';
    }
    return null;
  }

  String? _validateNumber(String? value) {
    if (value!.isEmpty || value == '+38 0') {
      return 'Поле не може бути пустим';
    }
    if (value.length < 17) {
      return 'Номер телефону повинен містити 9 цифр';
    }
    return null;
  }

  String? _validatePackageNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Заповніть інформацію для отримання товару';
    }
    return null;
  }

  String? _validateOther(String? value) {
    if (value == null || value.isEmpty) {
      return 'Опис товару не може бути пустим';
    }
    return null;
  }

  String? _validatePaidSum(String? value) {
    if (value == null || value.isEmpty) {
      return 'Заповніть суму для оплати';
    }
    if (double.tryParse(value) == null) {
      return 'Сума повинна бути числом';
    }
    if (double.parse(value) <= 0) {
      return 'Сума повинна бути більше нуля';
    }
    return null;
  }

  Future<void> _onCreate() async {
    if (_formKey.currentState!.validate()) {
      if (_packageType == null) {
        _showMessage(
          title: 'Помилка',
          message: 'Виберіть тип товару',
        );
        return;
      }
      if (_paymentType == null) {
        _showMessage(
          title: 'Помилка',
          message: 'Виберіть тип оплати',
        );
        return;
      }
      if (_orderTime == null) {
        _showMessage(
          title: 'Помилка',
          message: 'Виберіть час доставки',
        );
        return;
      }
      await _sendOrder();
      _showMessage(
        title: 'Успішно',
        message: 'Замовлення відправлено. Очікуйте дзвінка!.',
      );
    } else {
      _showMessage(
        title: 'Помилка',
        message: 'Заповніть всі поля',
      );
      return;
    }
  }

  void _showMessage({
    required String title,
    required String message,
  }) {
    showDialog(
      barrierColor: AppColors.black.withOpacity(0.5),
      barrierDismissible: false,
      context: context,
      builder: (context) => MessageDialog(
        title: title,
        message: message,
        onClose: () => Navigator.of(context).pop(),
      ),
    );
  }

  Future<void> _sendOrder() async {
    final username = (await Telegram(TELEGRAM_BOT_API).getMe()).username;
    final TeleDart teledart = TeleDart(
      TELEGRAM_BOT_API,
      Event(username!),
    );
    const String line = '--------------------------------';
    final String fromAddress = _fromAddressController.text.trim();
    final String fromNumber =
        _fromNumberController.text.trim().replaceAll(' ', '');
    final String toAddress = _toAddressController.text.trim();
    final String toNumber = _toNumberController.text.trim().replaceAll(' ', '');
    final String orderTime =
        '${_orderTime!.day.toString().padLeft(2, '0')}.${_orderTime!.month.toString().padLeft(2, '0')}.${_orderTime!.year} ${_orderTime!.hour.toString().padLeft(2, '0')}:${_orderTime!.minute.toString().padLeft(2, '0')}';
    String orderType = getPackageType(_packageType);
    if (_packageType == PackageType.other) {
      orderType = _otherController.text.trim();
    }
    String? orderNumber;
    if (_packageType == PackageType.medicine) {
      orderNumber = 'Номер бронювання: ${_packageNumberController.text.trim()}';
    }
    if (_packageType == PackageType.parcel) {
      orderNumber = 'Номер декларації: ${_packageNumberController.text.trim()}';
    }
    final String courierPaid = _isPaid
        ? 'Кур\'єр оплачує ${_paidSumController.text.trim()} грн'
        : 'Ні';

    final String paidType = getPaymentType(_paymentType);
    String whoPaid = 'Відправник';
    if (_paidRecipiend) {
      whoPaid = 'Отримувач';
    }
    final String message = "Нове замовлення\n" +
        "$line\n" +
        "Звідки\n" +
        "$line\n" +
        "Адреса: $fromAddress\n" +
        "Номер телефону: $fromNumber\n" +
        "$line\n" +
        "Куди\n" +
        "$line\n" +
        "Адреса: $toAddress\n" +
        "Номер телефону: $toNumber\n" +
        "$line\n" +
        "Час доставки: $orderTime\n" +
        "Тип замовлення: $orderType\n" +
        (orderNumber != null ? "$orderNumber\n" : "") +
        "Оплата замовлення кур'єром: $courierPaid\n" +
        "Тип оплати: $paidType\n" +
        "Хто оплачує: $whoPaid\n";
    await teledart.sendMessage(TELEGRAM_CHAT_ID, message);
    _resetForm();
  }

  void _resetForm() {
    _fromAddressController.clear();
    _fromNumberController.clear();
    _toAddressController.clear();
    _toNumberController.clear();
    _otherController.clear();
    _packageNumberController.clear();
    _paidSumController.clear();
    _packageType = null;
    _paymentType = null;
    _orderTime = null;
    _paidRecipiend = false;
    _isPaid = false;
    setState(() {});
  }
}
