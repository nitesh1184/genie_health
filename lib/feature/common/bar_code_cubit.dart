import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BarcodeCubit extends Cubit<String?> {
  BarcodeCubit() : super('');

  void setBarcode(String? barcode){
    save(barcode??'');
    emit(barcode??'');
  }
  void save(String args) async{
    final storage= await SharedPreferences.getInstance();
    storage.setString("uid", args);
  }
}