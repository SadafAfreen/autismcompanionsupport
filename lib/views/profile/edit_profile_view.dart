import 'dart:io';

import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/services/profile/profile_storage_exception.dart';
import 'package:autismcompanionsupport/services/profile/user_profile.dart';
import 'package:autismcompanionsupport/utilities/generics/get_arguments.dart';
import 'package:autismcompanionsupport/utilities/utils.dart';
import 'package:autismcompanionsupport/views/profile/user_preferences/expansion_view.dart';
import 'package:autismcompanionsupport/views/profile/user_preferences/preferences_item.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:autismcompanionsupport/widgets/custom_text_button.dart';
import 'package:autismcompanionsupport/widgets/input_field.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/services/profile/profile_storage_constants.dart';
import 'package:autismcompanionsupport/services/profile/firebase_profile_storage.dart';
import 'package:flutter/material.dart';

class EditProfileView extends StatefulWidget {
  const EditProfileView({super.key});

  @override
  State<EditProfileView> createState() => _EditProfileView();
}

class _EditProfileView extends State<EditProfileView>{
  bool _loadData = true;
  late final FirebaseProfileStorage _profileService;

  late final TextEditingController _nameController;
  late final TextEditingController _ageController;
  late final TextEditingController _genderController;
  late final TextEditingController _heightController;
  late final TextEditingController _weightController;
  late final ValueNotifier<bool> _isMuteController;
  late final TextEditingController _photoController;

  late final List<Map<String, dynamic>> _historyBurnouts = [];
  late final List<Map<String, dynamic>> _historyEvents = [];
  late final List<Map<String, dynamic>> _historyRetentions = [];

  late final List<Map<String, dynamic>> _habitsMorning = [];
  late final List<Map<String, dynamic>> _habitsEvening = [];
  late final List<Map<String, dynamic>> _habitsAfternoon = [];
  late final List<Map<String, dynamic>> _habitsNight = [];
  late final List<Map<String, dynamic>> _habitsNoon = [];

  Map<String, dynamic>? _historyPreference;
  Map<String, dynamic>? _habitsPreference;

  late final String bmiResult;

  @override
  void initState() {
    super.initState();

    _profileService = FirebaseProfileStorage();

    _nameController = TextEditingController();
    _ageController = TextEditingController();
    _genderController = TextEditingController();
    _heightController = TextEditingController();
    _weightController = TextEditingController();
    _isMuteController = ValueNotifier<bool>(false);
    _photoController = TextEditingController();

    _historyPreference = {
      "burnouts": [],
      "events": [],
      "retentions": [],
    };

    _habitsPreference = {
      "morning": [],
      "afternoon": [],
      "evening": [],
      "night": [],
      "noon": [],
    };

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_loadData) _loadProfileData();     
  }

  void _loadProfileData() {
    try {
      final profile = context.getArgument<UserProfile>();

      if(profile != null && mounted) {
        setState(() {
          _nameController.text = profile.name;
          _ageController.text = profile.age.toString();
          _genderController.text = profile.gender;
          _heightController.text = profile.height.toString();
          _weightController.text = profile.weight.toString(); 
          _isMuteController.value = profile.isMute;
          _photoController.text =  profile.profileAvatar.toString();

          _loadPreferencesData(profile.history, _historyPreference!);
          _loadPreferencesData(profile.habits, _habitsPreference!);

          _loadData = false;
        });
      } else {
        setState(() {
          _loadPreferencesData({}, _historyPreference!);
          _loadPreferencesData({}, _habitsPreference!);
        });
      }
    } catch(_) {
      throw CouldNotGetProfileException;
    }
  }

  void _loadPreferencesData(final data, Map<String, dynamic> dataPreference){
    if(data == null || data.isEmpty) {
      dataPreference.forEach((key, value) {
        if (value == null || (value is List && value.isEmpty)) {
          dataPreference[key] = [];
        }
      });
      return; 
    }

    data.forEach((key, value) {
      List<PreferencesItem> preferenceList = [];
      for(var preference in value) { 
        List<SubPreferencesItem> subPreferences = []; 
        preference.forEach((innerKey, innerValue) {
          if(innerValue is String) {
            subPreferences.add(SubPreferencesItem(innerValue, isSelected: true)); 
          } 
          else {
            for(var item in innerValue){
              subPreferences.add(SubPreferencesItem(item, isSelected: true)); 
            }
          }
          preferenceList.add(
            PreferencesItem(
              item: innerKey,
              subPreferencesItems: subPreferences,
            )
          );
        });
      }
      dataPreference[key] = preferenceList;
    });
  }

  @override
  void dispose() {
    if(!mounted) return;
    _nameController.dispose();
    _ageController.dispose();
    _genderController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _isMuteController.dispose();
    _photoController.dispose();

    super.dispose();
  }

  List<Map<String, dynamic>> _mapPreferences(List<dynamic> items) {
    List<Map<String, dynamic>> mappedList = [];

    for (var item in items) {
      List<String> subPreferencesList = [];

      for (var subItem in item.subPreferencesItems) {
        if(subItem is List) {
          for(var pref in subItem) {
            subPreferencesList.add(pref.title);
          }
        } else {
          subPreferencesList.add(subItem.title);
        }
      }
      
      mappedList.add({
        item.item: subPreferencesList.isEmpty ? [] : subPreferencesList,  
      });
    }

    return mappedList;
  }

  Future<void> _saveHistoryPreferences(Map<String, dynamic> preferences) async {
    preferences.forEach((key, value) {
      if (key == burnoutsHistoryFieldName) {
        _historyBurnouts.addAll(_mapPreferences(value));
      } else if (key == eventsHistoryFieldName) {
        _historyEvents.addAll(_mapPreferences(value));
      } else if (key == retentionsHistoryFieldName) {
        _historyRetentions.addAll(_mapPreferences(value));
      }
    });
  }

  Future<void> _saveHabitsPreferences(Map<String, dynamic> preferences) async {
    preferences.forEach((key, value) {
      if (key == morningHabitsFieldName) {
        _habitsMorning.addAll(_mapPreferences(value));
      } else if (key == afternoonHabitsFieldName) {
        _habitsAfternoon.addAll(_mapPreferences(value));
      } else if (key == eveningHabitsFieldName) {
        _habitsEvening.addAll(_mapPreferences(value));
      } else if (key == nightHabitsFieldName) {
        _habitsNight.addAll(_mapPreferences(value));
      } else if (key == noonHabitsFieldName) {
        _habitsNoon.addAll(_mapPreferences(value));
      }
    });
  }

  void calculateBMI() {
    if(_weightController.text.isEmpty || _heightController.text.isEmpty) return;

    final double bmi =  double.parse(_weightController.text) / (double.parse(_heightController.text) * double.parse(_heightController.text));
  
    setState(() {
      bmiResult = determineBMICategory(bmi);
    });
  }

  String determineBMICategory(bmiResult) {
    if (bmiResult < 1) {
      return '';
    } else if (bmiResult < 18.5) {
      return 'Underweight';
    } else if (bmiResult <= 24.9) {
      return 'Normal Weight';
    } else if (bmiResult <= 29.9) {
      return 'Overweight';
    } else if (bmiResult <= 34.9) {
      return 'Obesity Class I';
    } else if (bmiResult <= 39.9) {
      return 'Obesity Class II';
    } else {
      return 'Obesity Class III';
    }
  }

  Future<void> _saveProfile() async {
    try {
      final currentUser = AuthService.firebase().currentUser!;

      await _saveHabitsPreferences(_habitsPreference!);
      await _saveHistoryPreferences(_historyPreference!);

      calculateBMI();

      await _profileService.createProfile(
        ownerUserId: currentUser.id,
        name: _nameController.text,
        age: int.parse(_ageController.text),
        gender: _genderController.text,
        height: double.parse(_heightController.text),
        weight: double.parse(_weightController.text),
        isMute: _isMuteController.value,
        profileAvatar: _photoController.text,
        bmi: bmiResult,

        history: {
          'burnouts': _historyBurnouts,
          'events': _historyEvents,
          'retentions': _historyRetentions,
        },
        habits: {
          'morning': _habitsMorning,
          'afternoon': _habitsAfternoon,
          'evening': _habitsEvening,
          'night': _habitsNight,
          'noon': _habitsNoon
        },
      );
      if(!mounted) return;
      if(context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile saved successfully!')),
        );
        Future.delayed(const Duration(seconds: 1), () {
          if(mounted) Navigator.pop(context,);
        });
      }
    } catch (_) {
        if(!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save profile. Try Again.')),
        );
    }
  }

  Future<void> _selectImage() async {
    final Map<String, dynamic>? result = await pickImage(ImageSource.gallery);

    if (result != null) {
      setState(() {
        _photoController.text = result['path']; 
      });
      _cropImage();
    }
  }

  Future<void> _cropImage() async {
    if (_photoController.text.isNotEmpty) {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: _photoController.text,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.square,
            lockAspectRatio: false,
            aspectRatioPresets: [
              CropAspectRatioPreset.original,
              CropAspectRatioPreset.square,
              CropAspectRatioPreset.ratio4x3,
              CropAspectRatioPresetCustom(),
            ],
          ),
        ],
      );
      if (croppedFile != null) {
        setState(() {
          _photoController.text = croppedFile.path;
        });
      }
    }
  }
  
  void _setHistoryPrefereces(preferences) {
    setState(() {
      _historyPreference = preferences;
      //_saveHistoryPreferences(preferences);
    });
  }

  void _setHabitsPrefereces(preferences) {
    setState(() {
      _habitsPreference = preferences;
      //_saveHabitsPreferences(preferences);
    });
  }

  Widget _profileAvatarWidget() {
    return GestureDetector(
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
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _selectGenderWidget() {
    return DropdownButtonFormField<String>(
      value: _genderController.text.isEmpty ? null : _genderController.text,
      decoration: const InputDecoration(
        labelText: 'Gender',
        //border: OutlineInputBorder(),
      ),
      items: ['Male', 'Female'].map((gender) {
        return DropdownMenuItem(
          value: gender,
          child: Text(gender),
        );
      }).toList(),
      onChanged: (newValue) {
        setState(() =>  _genderController.text = newValue ?? "");
      },
      onTap: () {
      },
    );
  }
  
  Widget _toggleMuteWidget() {
    return Row(
      children: [
        const LightText(text: "Is child Mute?"),
        const SizedBox(width: 5,),
        Switch(
          value: _isMuteController.value,
          overlayColor: AppColors.overlayColor,
          trackColor: AppColors.trackColor,
          thumbColor: const WidgetStatePropertyAll<Color>(Colors.black),
          onChanged: (bool value) {
            setState(() {
              _isMuteController.value = value;
            });
          },
        ),
      ],
    );
  }
  
  Widget _saveButtonWidget() {
    return CustomTextButton(
      text: "Save", 
      onPressed: _saveProfile,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const BoldText(text: "Edit Profile"),
        backgroundColor: AppColors.primaryColor,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _profileAvatarWidget(),
          const SizedBox(height: 20),
          InputField(placeholder: "Child Name", controller: _nameController,),
          const SizedBox(height: 20),
          InputField(placeholder: "Child Age", controller: _ageController, type: TextInputType.number),
          const SizedBox(height: 20),
          _selectGenderWidget(),
          const SizedBox(height: 20),
          _toggleMuteWidget(),
          const SizedBox(height: 20),
          InputField(placeholder: "Height (in cm)", controller: _heightController, type: TextInputType.number),
          const SizedBox(height: 20),
          InputField(placeholder: "Weight (in kg)", controller: _weightController, type: TextInputType.number),
          const SizedBox(height: 20),
          ExpansionView(
            title: historyFieldName,
            selectedPreferences: _historyPreference,
            callback: _setHistoryPrefereces,
          ),
          const SizedBox(height: 20),
          ExpansionView(
            title: habitsFieldName,
            selectedPreferences: _habitsPreference,
            callback: _setHabitsPrefereces,
          ),
          const SizedBox(height: 20),
          _saveButtonWidget(),
        ],
      ),
    );
  }
}

class CropAspectRatioPresetCustom implements CropAspectRatioPresetData {
  @override
  (int, int)? get data => (2, 3);

  @override
  String get name => '2x3 (customized)';
}