import 'package:delivery_service/core/repositories/tariff_repository.dart';
import 'package:delivery_service/modules/dialogs/tariffs/bloc/tariffs_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setupServiceLocator() {
  locator.registerSingleton<TariffRepository>(ITariffRepository());

  locator.registerFactory(() {
    return TariffsBloc(
      tariffRepository: locator.get(),
    );
  });
}
