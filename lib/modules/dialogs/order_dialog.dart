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

class OrderDialog extends StatefulWidget {
  final VoidCallback onClose;
  const OrderDialog({required this.onClose, super.key});

  @override
  State<OrderDialog> createState() => _OrderDialogState();
}

class _OrderDialogState extends State<OrderDialog> {
  late GlobalKey<FormState> _formKey;

  late TextEditingController _fromNameController;
  late TextEditingController _fromNumberController;
  late TextEditingController _fromCityController;
  late TextEditingController _fromAddressController;
  late TextEditingController _fromNumberBuildingController;
  late TextEditingController _fromCommentController;

  late TextEditingController _toNameController;
  late TextEditingController _toNumberController;
  late TextEditingController _toCityController;
  late TextEditingController _toAddressController;
  late TextEditingController _toNumberBuildingController;
  late TextEditingController _toCommentController;

  late TermExecution _termExecution;
  late DateTime _scheduledDate;
  late TimeOfDay _scheduledFromTime;
  late TimeOfDay _scheduledToTime;

  late PackageType _packageType;
  late TextEditingController _commentForOtherPackageController;

  late PackageWeight _packageWeight;

  late bool _isCourierPays;
  late TextEditingController _costOrderController;

  late PaymentType _paymentType;

  late WhoPay _whoPay;

  late bool _isLoader;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();

    _fromNameController = TextEditingController();
    _fromNumberController = TextEditingController();
    _fromCityController = TextEditingController();
    _fromAddressController = TextEditingController();
    _fromNumberBuildingController = TextEditingController();
    _fromCommentController = TextEditingController();

    _toNameController = TextEditingController();
    _toNumberController = TextEditingController();
    _toCityController = TextEditingController();
    _toAddressController = TextEditingController();
    _toNumberBuildingController = TextEditingController();
    _toCommentController = TextEditingController();

    _termExecution = TermExecution.urdently;
    _scheduledDate =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    _scheduledFromTime = TimeOfDay.now();
    _scheduledToTime = TimeOfDay.now();

    _packageType = PackageType.food;
    _commentForOtherPackageController = TextEditingController();

    _packageWeight = PackageWeight.until1kg;

    _isCourierPays = false;

    _costOrderController = TextEditingController();

    _paymentType = PaymentType.cash;

    _whoPay = WhoPay.sender;

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

    _isLoader = false;
    super.initState();
  }

  @override
  void dispose() {
    _fromNameController.dispose();
    _fromNumberController.dispose();
    _fromAddressController.dispose();
    _fromNumberBuildingController.dispose();
    _fromCommentController.dispose();

    _toNameController.dispose();
    _toNumberController.dispose();
    _toAddressController.dispose();
    _toNumberBuildingController.dispose();
    _toCommentController.dispose();

    _commentForOtherPackageController.dispose();

    _costOrderController.dispose();
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
      'Оформлення замовлення',
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
          _buildSectionText('Звідки:'),
          const SizedBox(height: 12),
          _buildFromSectionFields(),
          const SizedBox(height: 24),
          _buildSectionText('Куди:'),
          const SizedBox(height: 12),
          _buildToSectionFields(),
          const SizedBox(height: 24),
          _buildSectionText('Термін виконання:'),
          const SizedBox(height: 12),
          _buildTermExecution(),
          const SizedBox(height: 24),
          _buildSectionText('Тип замовлення:'),
          const SizedBox(height: 12),
          _buildPackageType(),
          const SizedBox(height: 24),
          _buildSectionText('Вага замовлення:'),
          const SizedBox(height: 12),
          _buildPackageWeight(),
          const SizedBox(height: 24),
          _buildCourierPays(),
          const SizedBox(height: 24),
          _buildSectionText('Тип оплати:'),
          const SizedBox(height: 12),
          _buildPaymentType(),
          const SizedBox(height: 24),
          _buildSectionText('Хто оплачує:'),
          const SizedBox(height: 12),
          _buildWhoPay(),
          const SizedBox(height: 24),
          _buildCreateOrderBtn(),
        ],
      ),
    );
  }

  Widget _buildSectionText(String text) {
    return Text(
      text,
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

  Widget _buildFromSectionFields() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildField(
            label: "Ім'я",
            controller: _fromNameController,
            validator: _emptyValidator,
          ),
          const SizedBox(height: 12),
          _buildPhoneField(
            label: 'Номер телефону',
            controller: _fromNumberController,
            validator: _phoneValidator,
          ),
          const SizedBox(height: 12),
          _buildField(
            label: "Місто/Село",
            controller: _fromCityController,
            validator: _emptyValidator,
          ),
          const SizedBox(height: 12),
          if (!isMobile(context))
            Row(
              children: [
                _buildField(
                  label: 'Вулиця',
                  controller: _fromAddressController,
                  validator: _emptyValidator,
                  width: isMobile(context) || is640(context)
                      ? 640 - 286
                      : is768(context)
                          ? 768 - 286
                          : is1024(context)
                              ? 1024 - 286
                              : is1280(context)
                                  ? 1282 - 286
                                  : 1488 - 286,
                ),
                const SizedBox(width: 12),
                _buildField(
                  label: '№Буд./Кв.',
                  controller: _fromNumberBuildingController,
                  validator: _emptyValidator,
                  width: 200,
                ),
              ],
            ),
          if (isMobile(context))
            _buildField(
              label: 'Вулиця',
              controller: _fromAddressController,
              validator: _emptyValidator,
            ),
          if (isMobile(context)) const SizedBox(height: 12),
          if (isMobile(context))
            _buildField(
              label: '№Буд./Кв.',
              controller: _fromNumberBuildingController,
              validator: _emptyValidator,
            ),
          const SizedBox(height: 12),
          _buildField(
            label: 'Коментар',
            controller: _fromCommentController,
            validator: null,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildToSectionFields() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          _buildField(
            label: "Ім'я",
            controller: _toNameController,
            validator: _emptyValidator,
          ),
          const SizedBox(height: 12),
          _buildPhoneField(
            label: 'Номер телефону',
            controller: _toNumberController,
            validator: _phoneValidator,
          ),
          const SizedBox(height: 12),
          _buildField(
            label: "Місто/Село",
            controller: _toCityController,
            validator: _emptyValidator,
          ),
          const SizedBox(height: 12),
          if (!isMobile(context))
            Row(
              children: [
                _buildField(
                  label: 'Вулиця',
                  controller: _toAddressController,
                  validator: _emptyValidator,
                  width: isMobile(context) || is640(context)
                      ? 640 - 286
                      : is768(context)
                          ? 768 - 286
                          : is1024(context)
                              ? 1024 - 286
                              : is1280(context)
                                  ? 1282 - 286
                                  : 1488 - 286,
                ),
                const SizedBox(width: 12),
                _buildField(
                  label: '№Буд./Кв.',
                  controller: _toNumberBuildingController,
                  validator: _emptyValidator,
                  width: 200,
                ),
              ],
            ),
          if (isMobile(context))
            _buildField(
              label: 'Вулиця',
              controller: _toAddressController,
              validator: _emptyValidator,
            ),
          if (isMobile(context)) const SizedBox(height: 12),
          if (isMobile(context))
            _buildField(
              label: '№Буд./Кв.',
              controller: _toNumberBuildingController,
              validator: _emptyValidator,
            ),
          const SizedBox(height: 12),
          _buildField(
            label: 'Коментар',
            controller: _toCommentController,
            validator: null,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildTermExecution() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ...TermExecution.values.map(
                  (termExecution) => _buildTermExecutionItem(termExecution),
                ),
              ],
            ),
          ),
          if (_termExecution == TermExecution.scheduled)
            const SizedBox(height: 12),
          if (_termExecution == TermExecution.scheduled)
            _buildFieldsForTermExecution(),
        ],
      ),
    );
  }

  Widget _buildTermExecutionItem(TermExecution termExecution) {
    return InkWrapper(
      radius: 10,
      onTap: () => _changeTermExecution(termExecution),
      child: Container(
        width: isMobile(context) || is640(context)
            ? double.infinity
            : is1280(context)
                ? adaptiveWidth(context, 100) / 3.7
                : 308,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.07),
          border: Border.all(
            color: termExecution == _termExecution
                ? const Color(0xFF6366F1)
                : const Color.fromRGBO(0, 0, 0, 0.07),
            width: termExecution == _termExecution ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          getTermExecution(termExecution),
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

  Widget _buildFieldsForTermExecution() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildChooseDateField(),
        const SizedBox(height: 12),
        Row(
          children: [
            _buildFromTime(),
            const SizedBox(width: 12),
            _buildToTime(),
          ],
        ),
      ],
    );
  }

  Widget _buildChooseDateField() {
    final String day = _scheduledDate.day.toString().padLeft(2, '0');
    final month = _scheduledDate.month.toString().padLeft(2, '0');
    final year = _scheduledDate.year.toString().padLeft(2, '0');
    return InkWrapper(
      radius: 10,
      onTap: () => _showDatePicker(),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.07),
          border: Border.all(
            color: AppColors.black,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildLabel('День'),
            const SizedBox(height: 6),
            Text(
              '$day.$month.$year',
              style: customTextStyle(
                context,
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6366F1),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFromTime() {
    final String hour = _scheduledFromTime.hour.toString().padLeft(2, '0');
    final String minute = _scheduledFromTime.minute.toString().padLeft(2, '0');
    return Expanded(
      child: InkWrapper(
        radius: 10,
        onTap: () => _showFromTimePicker(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.07),
            border: Border.all(
              color: AppColors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Забрати в'),
              const SizedBox(height: 6),
              Text(
                '$hour:$minute',
                style: customTextStyle(
                  context,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6366F1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildToTime() {
    final String hour = _scheduledToTime.hour.toString().padLeft(2, '0');
    final String minute = _scheduledToTime.minute.toString().padLeft(2, '0');
    return Expanded(
      child: InkWrapper(
        radius: 10,
        onTap: () => _showToTimePicker(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: const Color.fromRGBO(0, 0, 0, 0.07),
            border: Border.all(
              color: AppColors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLabel('Доставити до'),
              const SizedBox(height: 6),
              Text(
                '$hour:$minute',
                style: customTextStyle(
                  context,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF6366F1),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPackageType() {
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
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                ...PackageType.values.map(
                  (packageType) => _buildPackageTypeItem(packageType),
                ),
              ],
            ),
          ),
          if (_packageType == PackageType.other) const SizedBox(height: 12),
          if (_packageType == PackageType.other)
            _buildField(
              label: 'Що веземо?',
              controller: _commentForOtherPackageController,
              validator: _emptyValidator,
            ),
        ],
      ),
    );
  }

  Widget _buildPackageTypeItem(PackageType packageType) {
    return InkWrapper(
      radius: 10,
      onTap: () => _changePackageType(packageType),
      child: Container(
        width: isMobile(context)
            ? double.infinity
            : is1280(context)
                ? adaptiveWidth(context, 100) / 9
                : 125,
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(0, 0, 0, 0.07),
          border: Border.all(
            color: packageType == _packageType
                ? const Color(0xFF6366F1)
                : const Color.fromRGBO(0, 0, 0, 0.07),
            width: packageType == _packageType ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          getPackageType(packageType),
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

  Widget _buildPackageWeight() {
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
            ...PackageWeight.values.map(
              (packageWeight) => _buildPackageWeightItem(packageWeight),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPackageWeightItem(PackageWeight packageWeight) {
    return InkWrapper(
      radius: 10,
      onTap: () => _changePackageWeight(packageWeight),
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
            color: packageWeight == _packageWeight
                ? const Color(0xFF6366F1)
                : const Color.fromRGBO(0, 0, 0, 0.07),
            width: packageWeight == _packageWeight ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          getPackageWeight(packageWeight),
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

  Widget _buildCourierPays() {
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
      child: isMobile(context)
          ? Column(
              children: [
                _buildSectionText('Оплата замовлення кур’єром:'),
                _buildSwitch(),
                if (_isCourierPays) const SizedBox(height: 12),
                if (_isCourierPays)
                  _buildField(
                    label: 'Введіть суму, яку повинен оплатити кур\'єр',
                    controller: _costOrderController,
                    validator: _sumValidator,
                    keyboardType: TextInputType.number,
                    width: double.infinity,
                    hint: '0',
                    isSuffix: true,
                  ),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSectionText('Оплата замовлення кур’єром:'),
                    _buildSwitch(),
                  ],
                ),
                if (_isCourierPays) const SizedBox(height: 12),
                if (_isCourierPays)
                  _buildField(
                    label: 'Введіть суму, яку повинен оплатити кур\'єр',
                    controller: _costOrderController,
                    validator: _sumValidator,
                    keyboardType: TextInputType.number,
                    width: double.infinity,
                    hint: '0',
                    isSuffix: true,
                  ),
              ],
            ),
    );
  }

  Widget _buildSwitch() {
    return Switch(
      value: _isCourierPays,
      onChanged: (value) => setState(() => _isCourierPays = value),
      activeColor: const Color(0xFF6366F1),
    );
  }

  Widget _buildPaymentType() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...PaymentType.values.map(
            (paymentType) => _buildPaymentTypeItem(paymentType),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentTypeItem(PaymentType paymentType) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: InkWrapper(
          radius: 10,
          onTap: () => _changePaymentType(paymentType),
          child: Container(
            width: double.infinity,
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
                color: paymentType == _paymentType
                    ? const Color(0xFF6366F1)
                    : const Color.fromRGBO(0, 0, 0, 0.07),
                width: paymentType == _paymentType ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              getPaymentType(paymentType),
              textAlign: TextAlign.center,
              style: customTextStyle(
                context,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWhoPay() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 6),
      decoration: BoxDecoration(
        border: Border.all(
          color: AppColors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ...WhoPay.values.map(
            (whoPay) => _buildWhoPayItem(whoPay),
          ),
        ],
      ),
    );
  }

  Widget _buildWhoPayItem(WhoPay whoPay) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        child: InkWrapper(
          radius: 10,
          onTap: () => _changeWhoPay(whoPay),
          child: Container(
            width: double.infinity,
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
                color: whoPay == _whoPay
                    ? const Color(0xFF6366F1)
                    : const Color.fromRGBO(0, 0, 0, 0.07),
                width: whoPay == _whoPay ? 2 : 1,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              getWhoPay(whoPay),
              textAlign: TextAlign.center,
              style: customTextStyle(
                context,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
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

  Widget _buildCreateOrderBtn() {
    return InkWrapper(
      radius: 0,
      onTap: _onCreate,
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
          'Замовити доставку',
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

  String? _sumValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Поле не може бути порожнім';
    }
    if (int.parse(value) <= 0) {
      return 'Сума повинна бути більше 0';
    }
    return null;
  }

  void _changeTermExecution(TermExecution termExecution) {
    setState(() {
      _termExecution = termExecution;
    });
  }

  Future<void> _showDatePicker() async {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
      helpText: 'Оберіть день',
      cancelText: 'Закрити',
      confirmText: 'Обрати',
      fieldHintText: 'День.Місяць.Рік',
      fieldLabelText: 'День',
      errorInvalidText: 'Оберіть правильну дату',
      errorFormatText: 'Оберіть правильну дату',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6366F1),
              onPrimary: Colors.black,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
            dialogBackgroundColor: Colors.green,
          ),
          child: child!,
        );
      },
    ).then((DateTime? selected) {
      if (selected != null && selected != _scheduledDate) {
        setState(
          () => _scheduledDate = DateTime(
            selected.year,
            selected.month,
            selected.day,
          ),
        );
      }
    });
  }

  Future<void> _showFromTimePicker() async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Оберіть час',
      cancelText: 'Закрити',
      confirmText: 'Обрати',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6366F1),
              onPrimary: Colors.black,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
            dialogBackgroundColor: Colors.green,
          ),
          child: child!,
        );
      },
    ).then((TimeOfDay? selected) {
      if (selected != null && selected != _scheduledFromTime) {
        setState(() => _scheduledFromTime = selected);
      }
    });
  }

  Future<void> _showToTimePicker() async {
    showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      helpText: 'Оберіть час',
      cancelText: 'Закрити',
      confirmText: 'Обрати',
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF6366F1),
              onPrimary: Colors.black,
              surface: AppColors.white,
              onSurface: AppColors.black,
            ),
            dialogBackgroundColor: Colors.green,
          ),
          child: child!,
        );
      },
    ).then((TimeOfDay? selected) {
      if (selected != null && selected != _scheduledToTime) {
        setState(() => _scheduledToTime = selected);
      }
    });
  }

  void _changePackageType(PackageType packageType) {
    setState(() {
      _packageType = packageType;
    });
  }

  void _changePackageWeight(PackageWeight packageWeight) {
    setState(() {
      _packageWeight = packageWeight;
    });
  }

  void _changePaymentType(PaymentType paymentType) {
    setState(() {
      _paymentType = paymentType;
    });
  }

  void _changeWhoPay(WhoPay whoPay) {
    setState(() {
      _whoPay = whoPay;
    });
  }

  Future<void> _onCreate() async {
    _isLoader = true;
    setState(() {});
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
      _isLoader = false;
      setState(() {});
      return;
    }
    if (_formKey.currentState!.validate()) {
      if (_termExecution == TermExecution.scheduled) {
        if (_scheduledDate.isBefore(DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day))) {
          _showMessage(
            title: 'Помилка',
            message: 'Оберіть коректну дату',
          );
          _isLoader = false;
          setState(() {});
          return;
        }
        if (_scheduledDate ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day) &&
                _scheduledFromTime.hour < DateTime.now().hour ||
            _scheduledDate ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day) &&
                _scheduledFromTime.minute < DateTime.now().minute) {
          _showMessage(
            title: 'Помилка',
            message: 'Оберіть коректний час',
          );
          _isLoader = false;
          setState(() {});
          return;
        }
        if (_scheduledDate ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day) &&
                _scheduledToTime.hour < DateTime.now().hour ||
            _scheduledDate ==
                    DateTime(DateTime.now().year, DateTime.now().month,
                        DateTime.now().day) &&
                _scheduledToTime.minute < DateTime.now().minute) {
          _showMessage(
            title: 'Помилка',
            message: 'Оберіть коректний час',
          );
          _isLoader = false;
          setState(() {});
          return;
        }
      }
      await _sendOrder();
      _isLoader = false;
      setState(() {});
      _showMessage(
        title: 'Успішно',
        message: 'Замовлення відправлено. Очікуйте дзвінка!.',
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

  Future<void> _sendOrder() async {
    final username = (await Telegram(TELEGRAM_BOT_API).getMe()).username;
    final TeleDart teledart = TeleDart(
      TELEGRAM_BOT_API,
      Event(username!),
    );
    const String line = '--------------------------------';
    final String fromComment = _fromCommentController.text.trim().isEmpty
        ? '-'
        : _fromCommentController.text.trim();
    final String toComment = _toCommentController.text.trim().isEmpty
        ? '-'
        : _toCommentController.text.trim();
    final String scheduleDate =
        '${_scheduledDate.day.toString().padLeft(2, '0')}.${_scheduledDate.month.toString().padLeft(2, '0')}.${_scheduledDate.year}';
    final String fromTime =
        '${_scheduledFromTime.hour.toString().padLeft(2, '0')}:${_scheduledFromTime.minute.toString().padLeft(2, '0')}';
    final String toTime =
        '${_scheduledToTime.hour.toString().padLeft(2, '0')}:${_scheduledToTime.minute.toString().padLeft(2, '0')}';
    final String termExecution = _termExecution != TermExecution.scheduled
        ? getTermExecution(_termExecution)
        : 'Заплановано на $scheduleDate з $fromTime до $toTime';
    final String pachageType = _packageType == PackageType.other
        ? _commentForOtherPackageController.text.trim()
        : getPackageType(_packageType);
    final String packageWeight = getPackageWeight(_packageWeight);
    final String courierPay = _isCourierPays
        ? 'Кур\'єр оплачує ${_costOrderController.text} грн'
        : 'Ні';
    final String message = "Нове замовлення\n" +
        "$line\n" +
        "Звідки\n" +
        "$line\n" +
        "Адреса: ${_fromCityController.text.trim()}, ${_fromAddressController.text.trim()}, ${_fromNumberBuildingController.text.trim()}\n" +
        "Клієнт: ${_fromNameController.text.trim()}, ${_fromNumberController.text.trim()}\n" +
        "Коментар: $fromComment\n" +
        "$line\n" +
        "Куди\n" +
        "$line\n" +
        "Адреса: ${_toCityController.text.trim()}, ${_toAddressController.text.trim()}, ${_toNumberBuildingController.text.trim()}\n" +
        "Клієнт: ${_toNameController.text.trim()}, ${_toNumberController.text.trim()}\n" +
        "Коментар: $toComment\n" +
        "$line\n" +
        "Термін виконання: $termExecution\n" +
        "Тип замовлення: $pachageType\n" +
        "Вага замовлення: $packageWeight\n" +
        "Оплата замовлення кур'єром: $courierPay\n" +
        "Тип оплати: ${getPaymentType(_paymentType)}\n" +
        "Хто оплачує: ${getWhoPay(_whoPay)}\n";
    await teledart.sendMessage(TELEGRAM_CHAT_ID, message);
  }
}
