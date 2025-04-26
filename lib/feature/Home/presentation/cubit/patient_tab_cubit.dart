import 'package:flutter_bloc/flutter_bloc.dart';

class PatientTabCubit extends Cubit<int> {
  PatientTabCubit() : super(0);

  void switchTab(int index) => emit(index);
}