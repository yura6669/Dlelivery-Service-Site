import 'package:dio/dio.dart';
import 'package:delivery_service/core/models/tariff_model.dart';

abstract class TariffRepository {
  Future<List<TariffModel>> getTariffs();
}

class ITariffRepository implements TariffRepository {
  @override
  Future<List<TariffModel>> getTariffs() async {
    final Dio dio = Dio();
    const String url = 'https://api.npoint.io/572a8bf3470464f366ad';
    final Response response = await dio.get(url);
    List<TariffModel> tariffs = [];
    Map<String, int> data = Map<String, int>.from(response.data['tariffs']);
    data.forEach((key, value) {
      tariffs.add(TariffModel(name: key, price: value.toString()));
    });
    return tariffs;
  }
}
