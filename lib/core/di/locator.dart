import 'package:edeliverysite/core/repositories/tariff_repository.dart';
import 'package:edeliverysite/modules/dialogs/tariffs/bloc/tariffs_bloc.dart';
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
