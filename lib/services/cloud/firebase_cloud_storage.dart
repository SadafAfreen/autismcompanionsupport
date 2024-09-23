import 'package:autismcompanionsupport/services/cloud/cloud_profile.dart';
import 'package:autismcompanionsupport/services/cloud/cloud_storage_constants.dart';
import 'package:autismcompanionsupport/services/cloud/cloud_storage_exception.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseCloudStorage {
  final profile = FirebaseFirestore.instance.collection('Test_000');

  Future<Iterable<CloudProfile>> getProfile({
    required String ownerUserId
  }) async {
    try {
      return await profile.where(
        ownerUserIdFieldName,
        isEqualTo: ownerUserId
      )
      .get()
      .then(
        (value) => value.docs.map(
          (doc) => CloudProfile.fromSnapshot(doc)
        )
      );
    } catch (e) {
      throw CouldNotGetProfileException();
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
    required int height,
    required int weight,
    required Map<String, String> history,
    required Map<String, String> habits,
    required String profileAvatar,
  }) async {
    try {
      await profile.doc(documentId).update({
        nameFieldName: name,
        ageFieldName: age,
        genderFieldName: gender,
        heightFieldName: height,
        weightFieldName: weight,
        'history': history,
        'habits': habits,
        profileAvatarFieldName: profileAvatar,
      });
    } catch (_) {
      throw CouldNotUpdateProfileException();
    }
  }

  Future<CloudProfile> createProfile({
    required String ownerUserId,
    required String name,
    required int age,
    required String gender,
    required int height,
    required int weight,
    required Map<String, String> history,
    required Map<String, String> habits,
    required String profileAvatar,
  }) async {
    final document = await profile.add({
      ownerUserIdFieldName: ownerUserId,
      nameFieldName: name,
      ageFieldName: age,
      genderFieldName: gender,
      heightFieldName: height,
      weightFieldName: weight,
      'history': history,
      'habits': habits,
      profileAvatarFieldName: profileAvatar,
    });
    final fetchedProfile = await document.get();
    return CloudProfile(
      documentId: fetchedProfile.id,
      ownerUserId: ownerUserId,
      name: name,
      age: age,
      gender: gender,
      height: height,
      weight: weight,
      history: history,
      habits: habits,
      profileAvatar: profileAvatar,
    );
  }

  static final FirebaseCloudStorage _shared =
      FirebaseCloudStorage._sharedInstance();
  FirebaseCloudStorage._sharedInstance();
  factory FirebaseCloudStorage() => _shared;
}