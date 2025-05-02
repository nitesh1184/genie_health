part of 'bmi_cubit.dart';

abstract class BmiState extends Equatable {
  const BmiState();

  @override
  List<Object?> get props => [];
}

class BmiInitial extends BmiState {}

class BmiSaving extends BmiState {}

class BmiSaveSuccess extends BmiState {
  final BMIResponse responseData;

  const BmiSaveSuccess(this.responseData);

  @override
  List<Object> get props => [responseData];
}

class BmiSaveFailed extends BmiState {
  final String message;

  const BmiSaveFailed({required this.message});

  @override
  List<Object?> get props => [message];
}

class BmiLoading extends BmiState {}

class BmiLoadSuccess extends BmiState {
  final LabReportEntity bmiData;

  const BmiLoadSuccess(this.bmiData);

  @override
  List<Object> get props => [bmiData];

}

class BmiLoadFailed extends BmiState {
  final String message;

  const BmiLoadFailed({required this.message});

  @override
  List<Object?> get props => [message];
}