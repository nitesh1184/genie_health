import 'package:flutter_bloc/flutter_bloc.dart';

class BarcodeState {
  final String barcode;
  BarcodeState(this.barcode);
}

class BarcodeCubit extends Cubit<BarcodeState> {
  BarcodeCubit() : super(BarcodeState(""));

  void setBarcode(String code) {
    emit(BarcodeState(code));
  }
}