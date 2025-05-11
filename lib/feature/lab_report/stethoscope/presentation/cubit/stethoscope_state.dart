import 'package:equatable/equatable.dart';

import '../../../common/domain/entities/lab_report_parameter_entity.dart';
import '../../../common/domain/entities/screening_success_response_entity.dart';

abstract class StethoscopeState extends Equatable {
  const StethoscopeState();

  @override
  List<Object?> get props => [];
}

class StethoscopeInitial extends StethoscopeState {}

class StethoscopeSaving extends StethoscopeState {}

class StethoscopeSaveSuccess extends StethoscopeState {
  final ScreeningSuccessResponse responseData;

  const StethoscopeSaveSuccess(this.responseData);

  @override
  List<Object> get props => [responseData];
}

class StethoscopeSaveFailed extends StethoscopeState {
  final String message;

  const StethoscopeSaveFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class StethoscopeLoading extends StethoscopeState {}

class StethoscopeLoadSuccess extends StethoscopeState {
  final LabReportEntity stethoscopeData;
  final bool isChecked;

  const StethoscopeLoadSuccess(this.stethoscopeData,{required this.isChecked});

  @override
  List<Object> get props => [stethoscopeData, isChecked];

}

class StethoscopeLoadFailed extends StethoscopeState {
  final String message;

  const StethoscopeLoadFailed({required this.message});

  @override
  List<Object?> get props => [message];
}