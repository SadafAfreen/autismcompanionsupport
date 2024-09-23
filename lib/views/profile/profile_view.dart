import 'dart:io';

import 'package:autismcompanionsupport/utilities/utils.dart';
import 'package:image_picker/image_picker.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/services/cloud/cloud_profile.dart';
import 'package:autismcompanionsupport/services/cloud/cloud_storage_constants.dart';
import 'package:autismcompanionsupport/services/cloud/firebase_cloud_storage.dart';
import 'package:autismcompanionsupport/utilities/generics/get_arguments.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView>{
  CloudProfile?_profile;
  late final FirebaseCloudStorage _profileService;

  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _genderController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final TextEditingController _burnoutsController;
  late final TextEditingController _eventsController;
  late final TextEditingController _retentionsController;
  late final TextEditingController _morningHabitsController;
  late final TextEditingController _afternoonHabitsController;
  late final TextEditingController _eveningHabitsController;
  late final TextEditingController _nightHabitsController;
  late final TextEditingController _noonHabitsController;
  late final TextEditingController _photoController;

  @override
  void initState() {
    _profileService = FirebaseCloudStorage();

    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _genderController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _burnoutsController = TextEditingController();
    _eventsController = TextEditingController();
    _retentionsController = TextEditingController();
    _morningHabitsController = TextEditingController();
    _afternoonHabitsController = TextEditingController();
    _eveningHabitsController = TextEditingController();
    _nightHabitsController = TextEditingController();
    _noonHabitsController = TextEditingController();
    _photoController = TextEditingController();

    super.initState();
    _setupTextControllerListeners();
  }

  void _setupTextControllerListeners() {
    _nameController.addListener(_textControllerListener);
    _ageController.addListener(_textControllerListener);
    _genderController.addListener(_textControllerListener);
    _heightController.addListener(_textControllerListener);
    _weightController.addListener(_textControllerListener);
    _burnoutsController.addListener(_textControllerListener);
    _eventsController.addListener(_textControllerListener);
    _retentionsController.addListener(_textControllerListener);
    _morningHabitsController.addListener(_textControllerListener);
    _afternoonHabitsController.addListener(_textControllerListener);
    _eveningHabitsController.addListener(_textControllerListener);
    _nightHabitsController.addListener(_textControllerListener);
    _noonHabitsController.addListener(_textControllerListener);
    _photoController.addListener(_textControllerListener);
  }

  void _textControllerListener() async {
    final profile = _profile;
    if (profile == null) return;

    await _profileService.updateProfile(
      documentId: profile.documentId,
      name: _nameController.text,
      age: _ageController.hashCode,
      gender: _genderController.text,
      height: _heightController.hashCode,
      weight: _weightController.hashCode,
      history: {
        'burnouts': _burnoutsController.text,
        'events': _eventsController.text,
        'retentions': _retentionsController.text,
      },
      habits: {
        'morning': _morningHabitsController.text,
        'afternoon': _afternoonHabitsController.text,
        'evening': _eveningHabitsController.text,
        'night': _nightHabitsController.text,
        'noon': _noonHabitsController.text,
      },
      profileAvatar: _photoController.text,
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _burnoutsController.dispose();
    _eventsController.dispose();
    _retentionsController.dispose();
    _morningHabitsController.dispose();
    _afternoonHabitsController.dispose();
    _eveningHabitsController.dispose();
    _nightHabitsController.dispose();
    _noonHabitsController.dispose();
    _photoController.dispose();
    super.dispose();
  }

  Future<CloudProfile> createOrGetProfile(BuildContext context) async {
    final widgetProfile = context.getArgument<CloudProfile>();

    if (widgetProfile != null) {
      _profile = widgetProfile;
      _nameController.text = widgetProfile.name;
      _ageController.text = widgetProfile.age.toString();
      _heightController.text = widgetProfile.height.toString();
      _weightController.text = widgetProfile.weight.toString();
      _genderController.text = widgetProfile.gender;
      _burnoutsController.text = widgetProfile.history[burnoutsHistoryFieldName] ?? '';
      _eventsController.text = widgetProfile.history[eventsHistoryFieldName] ?? '';
      _retentionsController.text = widgetProfile.history[retentionsHistoryFieldName] ?? '';
      _morningHabitsController.text = widgetProfile.habits[morningHabitsFieldName] ?? '';
      _afternoonHabitsController.text = widgetProfile.habits[afternoonHabitsFieldName] ?? '';
      _eveningHabitsController.text = widgetProfile.habits[eveningHabitsFieldName] ?? '';
      _nightHabitsController.text = widgetProfile.habits[nightHabitsFieldName] ?? '';
      _noonHabitsController.text = widgetProfile.habits[noonHabitsFieldName] ?? '';
      _photoController.text = widgetProfile.profileAvatar;
      return widgetProfile;
    }

    final existingProfile = _profile;
    if (existingProfile != null) return existingProfile;

    final currentUser = AuthService.firebase().currentUser!;

    final newProfile = await _profileService.createProfile(
      ownerUserId: currentUser.id,
      name: _nameController.text,
      age: _ageController.hashCode,
      gender: _genderController.text,
      height: _heightController.hashCode,
      weight: _weightController.hashCode,
      history: {
        'burnouts': _burnoutsController.text,
        'events': _eventsController.text,
        'retentions': _retentionsController.text,
      },
      habits: {
        'morning': _morningHabitsController.text,
        'afternoon': _afternoonHabitsController.text,
        'evening': _eveningHabitsController.text,
        'night': _nightHabitsController.text,
        'noon': _noonHabitsController.text,
      },
      profileAvatar: _photoController.text,
    );
    _profile = newProfile;
    return newProfile;
  }

  void _selectImage() async {
    final Map<String, dynamic>? result = await pickImage(ImageSource.gallery);

    if (result != null) {
      final String imagePath = result['path'];

      setState(() {
        _photoController.text = imagePath; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          GestureDetector(
            onTap: _selectImage,
            child: Container(
              width: 120, // 2 * radius (60 * 2)
              height: 120, // 2 * radius (60 * 2)
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: _photoController.text.isNotEmpty 
                      ? FileImage(File(_photoController.text)) 
                      : const AssetImage('assets/images/default_avatar.png') as ImageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
,
          const SizedBox(height: 20),
          TextField(
            controller: _nameController,
            decoration: const InputDecoration(
              labelText: 'Child Name',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _ageController,
            decoration: const InputDecoration(
              labelText: 'Child Age',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          DropdownButtonFormField<String>(
            value: _genderController.text.isEmpty ? null : _genderController.text,
            decoration: const InputDecoration(
              labelText: 'Gender',
            ),
            items: ['Male', 'Female'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (newValue) {
              _genderController.text = newValue ?? '';
            },
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _heightController,
            decoration: const InputDecoration(
              labelText: 'Height (in inches)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _weightController,
            decoration: const InputDecoration(
              labelText: 'Weight (in kg)',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 20),
          ExpansionTile(
            title: const Text('History'),
            children: [
              TextField(
                controller: _burnoutsController,
                decoration: const InputDecoration(
                  labelText: 'Burnouts',
                ),
              ),
              TextField(
                controller: _eventsController,
                decoration: const InputDecoration(
                  labelText: 'Events',
                ),
              ),
              TextField(
                controller: _retentionsController,
                decoration: const InputDecoration(
                  labelText: 'Retentions',
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ExpansionTile(
            title: const Text('Habits'),
            children: [
              TextField(
                controller: _morningHabitsController,
                decoration: const InputDecoration(
                  labelText: 'Morning',
                ),
              ),
              TextField(
                controller: _noonHabitsController,
                decoration: const InputDecoration(
                  labelText: 'Noon',
                ),
              ),
              TextField(
                controller: _afternoonHabitsController,
                decoration: const InputDecoration(
                  labelText: 'Afternoon',
                ),
              ),
              TextField(
                controller: _eveningHabitsController,
                decoration: const InputDecoration(
                  labelText: 'Evening',
                ),
              ),
              TextField(
                controller: _nightHabitsController,
                decoration: const InputDecoration(
                  labelText: 'Night',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}