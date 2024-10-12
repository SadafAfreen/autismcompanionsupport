import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:autismcompanionsupport/services/profile/profile_storage_constants.dart';
import 'package:flutter/foundation.dart';

@immutable
class UserProfile {
  final String documentId;
  final String ownerUserId;
  final String name;
  final int age;
  final String gender;
  final int height;
  final int weight;
  final bool isMute;
  final Map<String, String> history;
  final Map<String, String> habits;
  final String profileAvatar;

  const UserProfile({
    required this.documentId,
    required this.ownerUserId,
    required this.name,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
    required this.isMute,
    required this.history,
    required this.habits,
    required this.profileAvatar,
  });

  UserProfile.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        name = snapshot.data()[nameFieldName] as String,
        age = snapshot.data()[ageFieldName] as int,
        gender = snapshot.data()[genderFieldName] as String,
        height = snapshot.data()[heightFieldName] as int,
        weight = snapshot.data()[weightFieldName] as int,
        isMute = snapshot.data()[isMuteFieldName] as bool,
        history = snapshot.data()[historyFieldName] as Map<String, String>,
        habits = snapshot.data()[habitsFieldName] as Map<String, String>,
        profileAvatar = snapshot.data()[profileAvatarFieldName] as String;

  UserProfile.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()?[ownerUserIdFieldName] ?? "",
        name = snapshot.data()?[nameFieldName]?? "",
        age = snapshot.data()?[ageFieldName] ?? 0,
        gender = snapshot.data()?[genderFieldName] ?? "",
        height = snapshot.data()![heightFieldName] ?? 0,
        weight = snapshot.data()![weightFieldName] ?? 0,
        isMute = snapshot.data()![isMuteFieldName] ?? false,
        history = Map<String, String>.from(snapshot.data()?[historyFieldName] ?? {}),
        habits = Map<String, String>.from(snapshot.data()?[habitsFieldName] ?? {}),
        profileAvatar = snapshot.data()?[profileAvatarFieldName] ?? "";
}


