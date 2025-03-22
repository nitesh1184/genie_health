import 'package:flutter_bloc/flutter_bloc.dart';

class SpyroCubit extends Cubit<Map<String, bool>> {
  SpyroCubit() : super({'FEV1': false, 'FEV6': false});

  void recordFEV(String type) {
    emit({...state, type: true});
  }
}