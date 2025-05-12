import 'package:equatable/equatable.dart';

import '../../../common/domain/entities/lab_report_parameter_entity.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';

abstract class PhlebotomyState extends Equatable {
  const PhlebotomyState();

  @override
  List<Object?> get props => [];
}

class PhlebotomyInitial extends PhlebotomyState {}

class PhlebotomySaving extends PhlebotomyState {}

class PhlebotomySaveSuccess extends PhlebotomyState {
  final ScreeningSuccessResponse responseData;

  const PhlebotomySaveSuccess(this.responseData);

  @override
  List<Object> get props => [responseData];
}

class PhlebotomySaveFailed extends PhlebotomyState {
  final String message;

  const PhlebotomySaveFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class PhlebotomyLoading extends PhlebotomyState {}

class PhlebotomyLoadSuccess extends PhlebotomyState {
  final LabReportEntity phlebotomyData;

  const PhlebotomyLoadSuccess(this.phlebotomyData);

  @override
  List<Object> get props => [phlebotomyData];

}

class PhlebotomyLoadFailed extends PhlebotomyState {
  final String message;

  const PhlebotomyLoadFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class CheckBoxValueChanged extends PhlebotomyState {
  final bool isChecked;

  const CheckBoxValueChanged({required this.isChecked});

  @override
  List<Object?> get props => [isChecked];
}