import 'package:autismcompanionsupport/services/profile/user_profile.dart';
import 'package:autismcompanionsupport/services/profile/profile_storage_constants.dart';
import 'package:autismcompanionsupport/services/profile/profile_storage_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProfileStorage {
  final profile = FirebaseFirestore.instance.collection('Test_000');

  Future<UserProfile?> getProfile({
    required String ownerUserId
  }) async {
    try {
      return await profile.doc("profile")
        .get()
        .then((value) => value.exists ? UserProfile.fromDocumentSnapshot(value) : null ); 
    } catch (_) {
      throw CouldNotGetProfileException();
    }
  }

  Future<bool?> isUserMute ({
    required String ownerUserId
  }) async {
    try {
      return await profile.doc("profile")
        .get()
        .then((value) => value.exists ? UserProfile.fromDocumentSnapshot(value).isMute : null );
    } catch (_) {
      throw CouldNotGetMuteStatusException();
    }
  }

  Future<void> deleteProfile({
    required String documentId
  }) async {
    try {
      await profile.doc(documentId).delete();
    } catch (_) {
      throw CouldNotDeleteProfileException();
    }
  }

  Future<void> updateProfile({
    required String documentId,
    required String name,
    required int age,
    required String gender,
    required double height,
    required double weight,
    required bool isMute,
    required Map<String, dynamic> history,
    required Map<String, dynamic> habits,
    required String profileAvatar,
    required String bmiResult,
  }) async {
    try {
      await profile.doc(documentId).update({
        nameFieldName: name,
        ageFieldName: age,
        genderFieldName: gender,
        heightFieldName: height,
        weightFieldName: weight,
        isMuteFieldName: isMute,
        'history': history,
        'habits': habits,
        profileAvatarFieldName: profileAvatar,
        bmiFieldName: bmiResult,
      });
    } catch (_) {
      throw CouldNotUpdateProfileException();
    }
  }

  Future<void> createProfile({
    required String ownerUserId,
    required String name,
    required int age,
    required String gender,
    required double height,
    required double weight,
    required bool isMute,
    required Map<String, dynamic> history,
    required Map<String, dynamic> habits,
    required String profileAvatar,
    required String bmi,
  }) async {
    await profile.doc("profile").set({
      ownerUserIdFieldName: ownerUserId,
      nameFieldName: name,
      ageFieldName: age,
      genderFieldName: gender,
      heightFieldName: height,
      weightFieldName: weight,
      isMuteFieldName: isMute,
      'history': history,
      'habits': habits,
      profileAvatarFieldName: profileAvatar,
      bmiFieldName : bmi,
    }, SetOptions(merge: true));
  }

  static final FirebaseProfileStorage _shared =
      FirebaseProfileStorage._sharedInstance();
  FirebaseProfileStorage._sharedInstance();
  factory FirebaseProfileStorage() => _shared;
}