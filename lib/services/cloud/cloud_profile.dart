import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autismcompanionsupport/services/cloud/cloud_storage_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class CloudProfile {
  final String documentId;
  final String ownerUserId;
  final String name;
  final int age;
  final String gender;
  final int height;
  final int weight;
  final Map<String, String> history;
  final Map<String, String> habits;
  final String profileAvatar;

  const CloudProfile({
    required this.documentId,
    required this.ownerUserId,
    required this.name,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.history,
    required this.habits,
    required this.profileAvatar,
  });

  CloudProfile.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        name = snapshot.data()[nameFieldName] as String,
        age = snapshot.data()[ageFieldName] as int,
        gender = snapshot.data()[genderFieldName] as String,
        height = snapshot.data()[heightFieldName] as int,
        weight = snapshot.data()[weightFieldName] as int,
        history = snapshot.data()[historyFieldName] as Map<String, String>,
        habits = snapshot.data()[habitsFieldName] as Map<String, String>,
        profileAvatar = snapshot.data()[profileAvatarFieldName] as String;
}