import 'package:equatable/equatable.dart';

class TariffModel extends Equatable {
  final String name;
  final String price;

  const TariffModel({
    required this.name,
    required this.price,
  });

  @override
  List<Object?> get props => [name, price];
}
