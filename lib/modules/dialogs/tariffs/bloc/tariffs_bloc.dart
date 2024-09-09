import 'package:dio/dio.dart';
import 'package:delivery_service/core/models/tariff_model.dart';
import 'package:delivery_service/core/repositories/tariff_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tariffs_event.dart';
part 'tariffs_state.dart';

extension TariffsBlocX on TariffsBloc {
  void load() => add(_Load());
}

class TariffsBloc extends Bloc<TariffsEvent, TariffsState> {
  TariffsBloc({
    required this.tariffRepository,
  }) : super(_Initial()) {
    on<_Load>(_load);
  }

  final TariffRepository tariffRepository;

  Future<void> _load(_Load event, Emitter<TariffsState> emit) async {
    emit(_Loading());
    try {
      final List<TariffModel> tariffs = await tariffRepository.getTariffs();
      tariffs.sort((a, b) => a.name.compareTo(b.name));
      emit(_Loaded(tariffs));
    } on DioException {
      emit(_Error());
    } catch (e) {
      emit(_Error());
    }
  }
}
