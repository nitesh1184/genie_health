import 'package:equatable/equatable.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../../domain/entity/thermometer_entity.dart';

abstract class ThermometerState extends Equatable {
  const ThermometerState();

  @override
  List<Object?> get props => [];
}

class ThermometerInitial extends ThermometerState {}

class ThermometerSaving extends ThermometerState {}

class ThermometerSaveSuccess extends ThermometerState {
  final ScreeningSuccessResponse responseData;

  const ThermometerSaveSuccess(this.responseData);

  @override
  List<Object> get props => [responseData];
}

class ThermometerSaveFailed extends ThermometerState {
  final String message;

  const ThermometerSaveFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class ThermometerLoading extends ThermometerState {}

class ThermometerLoadSuccess extends ThermometerState {
  final ThermometerEntity thermometerData;

  const ThermometerLoadSuccess(this.thermometerData);

  @override
  List<Object> get props => [thermometerData];

}

class ThermometerLoadFailed extends ThermometerState {
  final String message;

  const ThermometerLoadFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class ThermometerUnitChanged extends ThermometerState {
  final bool isCelsius;

  const ThermometerUnitChanged({required this.isCelsius});

  @override
  List<Object?> get props => [isCelsius];
}