import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heath_genie/feature/Home/presentation/cubit/scanned_patient_list_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/common_use_case.dart';
import '../../domain/usecase/scanned_patient_list_usecase.dart';

class ScannedPatientListCubit extends Cubit<ScannedPatientListState> {
  final ScannedPatientListUseCase scannedPatientListUseCase;
  final SharedPreferences storage;

  ScannedPatientListCubit(this.scannedPatientListUseCase, this.storage)
      : super(ScannedPatientListInitial());

  Future<void> getDetails() async {
    emit(ScannedPatientListLoading());
    final result = await scannedPatientListUseCase(const NoParams());
    result.fold((failure) {
      if (failure is NoInternetFailure) {
        emit(ScannedPatientListDataFailure(failure.message)); // No internet
      } else {
        emit(ScannedPatientListDataFailure(failure.message)); // Generic error
      }
    }, (data) => emit(ScannedPatientListDataSuccess(data)));
  }
}