import 'package:dartz/dartz.dart';
import 'package:heath_genie/feature/Home/domain/entity/previously_scanned_patient.dart';
import 'package:heath_genie/feature/Home/domain/repository/scanned_patient_repository.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecases/common_use_case.dart';

class ScannedPatientListUseCase extends BaseUseCase<ScannedPatientEntity, NoParams> {

  final ScannedPatientListRepository scannedPatientListRepository;

  ScannedPatientListUseCase({required this.scannedPatientListRepository});

  @override
  Future<Either<Failure, ScannedPatientEntity>> call(NoParams params) async {
    return await scannedPatientListRepository.getScannedPatientList();
  }
}