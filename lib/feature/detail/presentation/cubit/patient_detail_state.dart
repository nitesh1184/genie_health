import 'package:equatable/equatable.dart';

import '../../domain/entity/patient_model.dart';

abstract class PatientDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class PatientDataInitial extends PatientDataState {}

class PatientDataLoading extends PatientDataState {}

class PatientDataSuccess extends PatientDataState {
  final Patient data;
  final bool isExpanded;

  PatientDataSuccess(this.data, {this.isExpanded = true});

  PatientDataSuccess copyWith({bool? isExpanded}) {
    return PatientDataSuccess(
      data,
      isExpanded: isExpanded ?? this.isExpanded,
    );
  }

  @override
  List<Object> get props => [data, isExpanded];
}

class PatientVisibilityToggleState extends PatientDataState {
  final bool isExpanded;

  PatientVisibilityToggleState(this.isExpanded);

  @override
  List<Object> get props => [isExpanded];
}

class PatientDataFailure extends PatientDataState {
  final String message;

  PatientDataFailure(this.message);

  @override
  List<Object> get props => [message];
}

class PatientExpandCollapseChanged extends PatientDataState {}