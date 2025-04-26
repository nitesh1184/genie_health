import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/detail/presentation/cubit/patient_detail_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failure.dart';
import '../../domain/usecase/patient_detail_usecase.dart';

class PatientDetailCubit extends Cubit<PatientDataState> {
  final PatientDetailUseCase patientDetailUseCase;
  final SharedPreferences storage;
  bool isExpanded = true;

  PatientDetailCubit(this.patientDetailUseCase, this.storage)
    : super(PatientDataInitial());

  Future<void> getDetails() async {
    emit(PatientDataLoading());
    final patientId = storage.getString("uid");
    final result = await patientDetailUseCase(patientId ?? "");
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(PatientDataFailure(failure.message)); // No internet
      } else {
        emit(PatientDataFailure(failure.message)); // Generic error
      }
    }, (data) => emit(PatientDataSuccess(data)));
  }

  void toggleExpandCollapse() {
    isExpanded = !isExpanded;
    emit(PatientExpandCollapseChanged()); // <-- emit separate state
  }
}


