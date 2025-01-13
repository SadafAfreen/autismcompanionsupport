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
  final double height;
  final double weight;
  final bool isMute;
  final Map<String, dynamic> history;
  final Map<String, dynamic> habits;
  final String profileAvatar;
  final String bmiResult;

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
    required this.bmiResult,
  });

  UserProfile.fromSnapshot(QueryDocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()[ownerUserIdFieldName],
        name = snapshot.data()[nameFieldName] as String,
        age = snapshot.data()[ageFieldName] as int,
        gender = snapshot.data()[genderFieldName] as String,
        height = snapshot.data()[heightFieldName] as double,
        weight = snapshot.data()[weightFieldName] as double,
        isMute = snapshot.data()[isMuteFieldName] as bool,
        history = snapshot.data()[historyFieldName] as Map<String, dynamic>,
        habits = snapshot.data()[habitsFieldName] as Map<String, dynamic>,
        profileAvatar = snapshot.data()[profileAvatarFieldName] as String,
        bmiResult = snapshot.data()[bmiFieldName] as String;

  UserProfile.fromDocumentSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : documentId = snapshot.id,
        ownerUserId = snapshot.data()?[ownerUserIdFieldName] ?? "",
        name = snapshot.data()?[nameFieldName]?? "",
        age = snapshot.data()?[ageFieldName] ?? 0,
        gender = snapshot.data()?[genderFieldName] ?? "",
        height = snapshot.data()![heightFieldName] ?? 0,
        weight = snapshot.data()![weightFieldName] ?? 0,
        isMute = snapshot.data()![isMuteFieldName] ?? false,
        history = Map<String, dynamic>.from(snapshot.data()?[historyFieldName] ?? {}),
        habits = Map<String, dynamic>.from(snapshot.data()?[habitsFieldName] ?? {}),
        profileAvatar = snapshot.data()?[profileAvatarFieldName] ?? "",
        bmiResult = snapshot.data()?[bmiFieldName] ?? "";
}


