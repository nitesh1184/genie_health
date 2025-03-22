import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/patient_detail_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/usecase/patient_detail_usecase.dart';

class PatientDetailCubit extends Cubit<PatientDataState> {
  final PatientDetailUseCase patientDetailUseCase;
  final SharedPreferences storage;

  PatientDetailCubit(this.patientDetailUseCase, this.storage)
      : super(PatientDataInitial());

  Future<void> getDetails() async {
    emit(PatientDataLoading());
    final patientId=storage.getString("uid");
    final result = await patientDetailUseCase(patientId??"");
    result.fold(
            (failure) => emit(PatientDataFailure(failure.message)),
            (data) => emit(PatientDataSuccess(data))

    );
  }
}