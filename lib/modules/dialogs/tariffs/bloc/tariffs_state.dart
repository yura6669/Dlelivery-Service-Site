part of 'tariffs_bloc.dart';

extension TariffsStateX on TariffsState {
  bool get isInitial => this is _Initial;
  bool get isLoading => this is _Loading;
  bool get isLoaded => this is _Loaded;
  bool get isError => this is _Error;

  List<TariffModel> get tariffs => (this as _Loaded).tariffs;
}

class TariffsState {}

class _Initial extends TariffsState {
  _Initial();
}

class _Loading extends TariffsState {
  _Loading();
}

class _Loaded extends TariffsState {
  final List<TariffModel> tariffs;

  _Loaded(this.tariffs);
}

class _Error extends TariffsState {
  _Error();
}
