import 'package:equatable/equatable.dart';

import '../../domain/entity/previously_scanned_patient.dart';

abstract class ScannedPatientListState extends Equatable {
  @override
  List<Object> get props => [];
}

class ScannedPatientListInitial extends ScannedPatientListState {}

class ScannedPatientListLoading extends ScannedPatientListState {}

class ScannedPatientListDataSuccess extends ScannedPatientListState {
  final List<ScannedPatientList> data;

  ScannedPatientListDataSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ScannedPatientListDataFailure extends ScannedPatientListState{
  final String message;

  ScannedPatientListDataFailure(this.message);

  @override
  List<Object> get props => [message];
}