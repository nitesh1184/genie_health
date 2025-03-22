import 'package:equatable/equatable.dart';

abstract class BarcodeState extends Equatable {
  @override
  List<Object> get props => [];
}

class BarcodeInitial extends BarcodeState {}

class FetchBarcodeSuccess extends BarcodeState {
  final String code;

  FetchBarcodeSuccess(this.code);

  @override
  List<Object> get props => [code];
}

class BarcodeFailure extends BarcodeState {
  final String message;

  BarcodeFailure(this.message);

  @override
  List<Object> get props => [message];
}