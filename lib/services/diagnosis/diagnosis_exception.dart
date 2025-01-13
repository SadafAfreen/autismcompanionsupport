class DiagnosisException implements Exception {
  const DiagnosisException();
}

class CouldNotUploadAssessmentException extends DiagnosisException {}

class CouldNotUploadDiagnosisDataException extends DiagnosisException {}