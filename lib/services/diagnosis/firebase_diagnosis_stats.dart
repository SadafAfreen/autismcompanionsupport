import 'package:autismcompanionsupport/services/diagnosis/diagnosis_exception.dart';
import 'package:autismcompanionsupport/services/diagnosis/user_diagnosis.dart';
import 'package:autismcompanionsupport/services/profile/profile_storage_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseDiagnosisStats {
  final _diagnosis = FirebaseFirestore.instance.collection('Test_000');

  Future<UserDiagnosis?> getDiagnosisResults({
    required String ownerUserId
  }) async {
    try {
      final documentSnapshot = await _diagnosis.doc("diagnosis").get();

      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        if (data != null && data[ownerUserIdFieldName] == ownerUserId) {
          return UserDiagnosis.fromDocumentSnapshot(documentSnapshot);
        }
      }
      return null;
    } catch (_) {
      throw CouldNotUploadDiagnosisDataException();
    }
  }

  Future<void> uploadDiagnosisData({
    required String ownerUserId,
    Map<String, dynamic>? diagnosisStats,
    Map<String, dynamic>? diagnosisResults,
  }) async {
    try {
      await _diagnosis.doc("diagnosis").set({
        ownerUserIdFieldName: ownerUserId,
        if (diagnosisStats != null) diagnosisFieldName: diagnosisStats,
        if (diagnosisResults != null) diagnosisResultsFieldName: diagnosisResults,
      }, SetOptions(merge: true));
    } catch (_) {
      throw CouldNotUploadAssessmentException();
    }
  }

  static final FirebaseDiagnosisStats _shared =
      FirebaseDiagnosisStats._sharedInstance();
  FirebaseDiagnosisStats._sharedInstance();
  factory FirebaseDiagnosisStats() => _shared;
}