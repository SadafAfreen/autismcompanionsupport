import 'dart:io';

import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/utilities/utils.dart';
import 'package:autismcompanionsupport/widgets/custom_text_button.dart';
import 'package:autismcompanionsupport/widgets/input_field.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
import 'package:image_picker/image_picker.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/services/profile/user_profile.dart';
import 'package:autismcompanionsupport/services/profile/profile_storage_constants.dart';
import 'package:autismcompanionsupport/services/profile/firebase_profile_storage.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView>{
  UserProfile? _profile;
  late final FirebaseProfileStorage _profileService;

  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _genderController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final ValueNotifier<bool> _isMuteController;
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
    _profileService = FirebaseProfileStorage();

    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _genderController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _isMuteController = ValueNotifier<bool>(false);
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
    _loadProfileData();
  }

  

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _isMuteController.dispose();
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

  Future<void> _createOrGetProfile() async {
    try {
      final currentUser = AuthService.firebase().currentUser!;
      await _profileService.createProfile(
        ownerUserId: currentUser.id,
        name: _nameController.text,
        age: int.parse(_ageController.text),
        gender: _genderController.text,
        height: int.parse(_heightController.text),
        weight: int.parse(_weightController.text),
        isMute: _isMuteController.value,
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
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully!')),
        );
      }
    } catch (_) {
      //if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save profile. Try Again.')),
        );
      //}
    }
  }

  Future<void> _loadProfileData() async {
    final currentUser = AuthService.firebase().currentUser!;
    final profile = await _profileService.getProfile(ownerUserId: currentUser.id);
    if(profile != null) {
      setState(() {
        _profile = profile;
        _nameController.text = profile.name;
        _ageController.text = profile.age.toString();
        _genderController.text = profile.gender;
        _heightController.text = profile.height.toString();
        _weightController.text = profile.weight.toString(); 
        _isMuteController.value = profile.isMute;
        _photoController.text =  profile.profileAvatar.toString();
        _burnoutsController.text = profile.history[burnoutsHistoryFieldName].toString();
        _eventsController.text = profile.history[eventsHistoryFieldName].toString();
        _retentionsController.text = profile.history[retentionsHistoryFieldName].toString();
        _morningHabitsController.text = profile.habits[morningHabitsFieldName].toString();
        _afternoonHabitsController.text = profile.habits[afternoonHabitsFieldName].toString();
        _eveningHabitsController.text = profile.habits[eveningHabitsFieldName].toString();
        _nightHabitsController.text = profile.habits[nightHabitsFieldName].toString();
        _noonHabitsController.text = profile.habits[noonHabitsFieldName].toString();
      });
    }
    
  
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

  final WidgetStateProperty<Color?> trackColor = 
      WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if(states.contains(WidgetState.selected)) {
          return AppColors.primaryColor;
        }
        return null;
      });

  final WidgetStateProperty<Color?> overlayColor = 
      WidgetStateProperty.resolveWith<Color?>((Set<WidgetState> states) {
        if(states.contains(WidgetState.selected)) {
          return AppColors.primaryColor.withOpacity(0.54);
        }
        if(states.contains(WidgetState.disabled)) {
          return AppColors.textFieldWhite;
        }
        return null;
      });

  @override
  Widget build(BuildContext context) {
    return ListView(
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
              const SizedBox(height: 20),
              InputField(placeholder: "Child Name", controller: _nameController,),
              const SizedBox(height: 20),
              InputField(placeholder: "Child Age", controller: _ageController, type: TextInputType.number),
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
              Row(
                children: [
                  const LightText(text: "Is child Mute?"),
                  const SizedBox(width: 5,),
                  Switch(
                    value: _isMuteController.value,
                    overlayColor: overlayColor,
                    trackColor: trackColor,
                    thumbColor: const WidgetStatePropertyAll<Color>(Colors.black),
                    onChanged: (bool value) {
                      setState(() {
                        _isMuteController.value = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              InputField(placeholder: "Height (in inches)", controller: _heightController, type: TextInputType.number),
              const SizedBox(height: 20),
              InputField(placeholder: "Weight (in kg)", controller: _weightController, type: TextInputType.number),
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
              const SizedBox(height: 20),
              CustomTextButton(
                text: "Save", 
                onPressed: _createOrGetProfile,
              )
            ],
          );
    
  }
}