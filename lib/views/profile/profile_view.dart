import 'dart:io';

import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/services/auth/auth_service.dart';
import 'package:autismcompanionsupport/services/profile/firebase_profile_storage.dart';
import 'package:autismcompanionsupport/services/profile/user_profile.dart';
import 'package:autismcompanionsupport/utilities/utils.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  UserProfile? _profile;
  late final FirebaseProfileStorage _profileService;

  @override
  void initState() {
    super.initState();
    _profileService = FirebaseProfileStorage();
  }

  @override
  didChangeDependencies() {
    super.didChangeDependencies();
    _loadProfileData();
  }

  Future<void> _loadProfileData() async {
    final currentUser = AuthService.firebase().currentUser!;
    final profile = await _profileService.getProfile(ownerUserId: currentUser.id);
    if(profile != null && mounted) {
      setState(() {
        _profile = profile;
       // log(_profile.toString());
      });
    }
  }

  ImageProvider _getImageProvider(String? imagePath) {
    if (imagePath != null) {
      if (imagePath.startsWith('http') || imagePath.startsWith('https')) {
        return NetworkImage(imagePath);
      } else {
        return FileImage(File(imagePath));
      }
    }       
    
    return const AssetImage('assets/images/default_avatar.png');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _listWidget(),
        _editFloatingButton(),
      ]
    );
  }

  Widget _listWidget() {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Container(
          width: 120, // 2 * radius (60 * 2)
          height: 120, // 2 * radius (60 * 2)
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: _getImageProvider(_profile?.profileAvatar),
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 20),
        BoldText(
          text: _profile?.name != null ? (_profile?.name).toString() : "Child Name", 
          size: 16,
          align: TextAlign.center,
        ),
        customDivider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const BoldText( text: "Age: ", size: 12,),
                  const SizedBox(width: 5,),
                  LightText(text: "${_profile?.age}", size: 12,)
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const BoldText(text: "Gender: ", size: 12,),
                  const SizedBox(width: 5,),
                  LightText(text: "${_profile?.gender}", size: 12,)
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const BoldText(text: "Is Child Mute: ", size: 12,),
                  const SizedBox(width: 5,),
                  LightText(text: "${_profile != null ? _profile!.isMute ? 'Yes' : 'No' : null}", size: 12,)
                ],
              ), 
              const SizedBox(height: 20),
              Row(
                children: [
                  const BoldText(text: "Height (in cm): ", size: 12,),
                  const SizedBox(width: 5,),
                  LightText(text: "${_profile?.height}", size: 12,)
                ],
              ),  
              const SizedBox(height: 20),
              Row(
                children: [
                  const BoldText(text: "Weight (in kg): ", size: 12,),
                  const SizedBox(width: 5,),
                  LightText(text: "${_profile?.weight}", size: 12,)
                ],
              ), 
            ],
          ),
        ),
        customDivider(),
        buildExpansionSection("History", _profile?.history),
        const SizedBox(height: 20),
        buildExpansionSection("Habits", _profile?.habits),
      ],
    );
  }

  Widget buildExpansionSection(String title, Map<String, dynamic>? data) {
    return ExpansionTile(
      title: Text(title),
      children: _buildExpansionTilesFromData(data),
    );
  }

  List<Widget> _buildExpansionTilesFromData(data) {
    if (data == null || data.isEmpty) {
      return [const Text("No data available")];
    }

    List<Widget> expansionTiles = [];
    
    data.forEach((category, items) {
      expansionTiles.add(
        ExpansionTile(
          title: BoldText(
            text: category, 
            size: 12.5, 
            color: items.isEmpty 
              ? AppColors.primaryColor.withOpacity(0.5) 
              : AppColors.primaryColor, 
          ),
          iconColor: AppColors.primaryColor, 
          collapsedIconColor: AppColors.primaryColor, 
          trailing: items.isEmpty 
            ? null 
            : const Icon(
                Icons.arrow_drop_down,
                color: AppColors.primaryColor,
                size: 24.0,
              ),

          children: _buildItemExpansionTiles(items),
        ),
      );
    });

    return expansionTiles;
  }

  List<Widget> _buildItemExpansionTiles(List<dynamic> items) {
    List<Widget> itemTiles = [];
    
    for (var item in items) {
      itemTiles.add(
        ExpansionTile(
          title: LightText(text: item.keys.first, size: 12, color: AppColors.textColorBlack), 
          children: (item.values.first as List<dynamic>).map((subItem) {
            return ListTile(
              title: LightText(text: subItem, size: 12), 
            );
          }).toList(),
        ),
      );
    }

    return itemTiles;
  }


  Widget _editFloatingButton() {
      return Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 32.0, bottom: 32.0),
          child: FloatingActionButton(
            onPressed: () async {
              await Navigator.of(context).pushNamed(
                editProfileRoute,
                arguments: _profile,
              );
              await _loadProfileData();
            },
            backgroundColor: AppColors.primaryColor,
            tooltip: 'Edit Profile',
            child: const Icon(Icons.edit),
          ),
        ),
      );
    }
}