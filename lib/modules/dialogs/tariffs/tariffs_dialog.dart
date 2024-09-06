import 'package:edeliverysite/core/di/locator.dart';
import 'package:edeliverysite/core/models/tariff_model.dart';
import 'package:edeliverysite/modules/dialogs/message_dialog.dart';
import 'package:edeliverysite/modules/dialogs/tariffs/bloc/tariffs_bloc.dart';
import 'package:edeliverysite/modules/resorses/app_colors.dart';
import 'package:edeliverysite/modules/resorses/resorses.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TariffsDialog extends StatefulWidget {
  final VoidCallback onClose;
  const TariffsDialog({required this.onClose, super.key});

  @override
  State<TariffsDialog> createState() => _TariffsDialogState();
}

class _TariffsDialogState extends State<TariffsDialog> {
  late TariffsBloc _tariffsBloc;

  @override
  void initState() {
    _tariffsBloc = locator.get();
    _tariffsBloc.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      insetPadding: EdgeInsets.zero,
      child: Container(
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
                child: _buildTariffs(),
              ),
            ),
          ],
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
      'Тарифи',
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

  Widget _buildTariffs() {
    return BlocProvider(
      create: (context) => _tariffsBloc,
      child: BlocListener<TariffsBloc, TariffsState>(
        listener: (context, state) {
          if (state.isError) {
            showDialog(
              barrierColor: AppColors.black.withOpacity(0.5),
              barrierDismissible: false,
              context: context,
              builder: (context) => MessageDialog(
                title: 'Помилка',
                message: 'Виникла помилка. Спробуйте ще раз',
                btnText: 'Сробувати ще раз',
                onClose: () {
                  _tariffsBloc.load();
                  Navigator.of(context).pop();
                },
              ),
            );
          }
        },
        child: BlocBuilder<TariffsBloc, TariffsState>(
          builder: (context, state) {
            if (state.isLoaded) {
              return _buildTariffsList(state.tariffs);
            } else {
              return _buildLoader();
            }
          },
        ),
      ),
    );
  }

  Widget _buildTariffsList(List<TariffModel> tariffs) {
    return Column(
      children: tariffs
          .map(
            (tariff) => Column(
              children: [
                _buildTariff(tariff),
                const SizedBox(height: 24),
              ],
            ),
          )
          .toList(),
    );
  }

  Widget _buildTariff(TariffModel tariff) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFBC700),
        border: Border.all(
          color: AppColors.black,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: '${tariff.name} - ',
              style: customTextStyle(
                context,
                fontSize: 24,
                fontWeight: FontWeight.w600,
              ),
            ),
            TextSpan(
              text: '${tariff.price} грн',
              style: customTextStyle(
                context,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF6366F1),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoader() {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFBC700)),
      ),
    );
  }
}
