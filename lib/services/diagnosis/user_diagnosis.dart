import 'package:autismcompanionsupport/services/profile/profile_storage_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserDiagnosis {
  final String documentId;
  final String ownerUserId;
  final Map<String, dynamic> diagnosisStats;
  final Map<String, dynamic> diagnosisResults;

  const UserDiagnosis({
    required this.documentId, 
    required this.ownerUserId, 
    required this.diagnosisStats,
    required this.diagnosisResults, 
  });

  UserDiagnosis.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) 
    : documentId = snapshot.id,
      ownerUserId = snapshot.data()?[ownerUserIdFieldName] ?? "",
      diagnosisStats = snapshot.data()?[diagnosisFieldName] ?? {},
      diagnosisResults = snapshot.data()?[diagnosisResultsFieldName] ?? {};
}