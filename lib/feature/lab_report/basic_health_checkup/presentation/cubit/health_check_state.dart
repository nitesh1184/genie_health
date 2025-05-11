import 'package:equatable/equatable.dart';

import '../../../common/domain/entities/lab_report_parameter_entity.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';
import '../../domain/entities/health_check.dart';

abstract class HealthCheckState extends Equatable {
  const HealthCheckState();

  @override
  List<Object?> get props => [];
}

class HealthCheckInitial extends HealthCheckState {}

class HealthCheckSaving extends HealthCheckState {}

class HealthCheckSaveSuccess extends HealthCheckState {
  final ScreeningSuccessResponse responseData;

  const HealthCheckSaveSuccess(this.responseData);

  @override
  List<Object> get props => [responseData];
}

class HealthCheckSaveFailed extends HealthCheckState {
  final String message;

  const HealthCheckSaveFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class HealthCheckLoading extends HealthCheckState {}

class HealthCheckLoadSuccess extends HealthCheckState {
  final HealthCheck report;

  const HealthCheckLoadSuccess(this.report);

  @override
  List<Object> get props => [report];

}

class HealthCheckLoadFailed extends HealthCheckState {
  final String message;

  const HealthCheckLoadFailed({required this.message});

  @override
  List<Object?> get props => [message];
}