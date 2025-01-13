import 'package:autismcompanionsupport/constants/app_colors.dart';
import 'package:autismcompanionsupport/constants/questions.dart';
import 'package:autismcompanionsupport/services/profile/profile_storage_constants.dart';
import 'package:autismcompanionsupport/utilities/generics/get_arguments.dart';
import 'package:autismcompanionsupport/views/profile/user_preferences/preferences_item.dart';
import 'package:autismcompanionsupport/widgets/bold_text.dart';
import 'package:autismcompanionsupport/widgets/light_text.dart';
import 'package:flutter/material.dart';

class PreferencesView extends StatefulWidget {
  const PreferencesView({super.key});

  @override
  State<PreferencesView> createState() => _PreferencesViewState();
}

class _PreferencesViewState extends State<PreferencesView> {
  String? _appbarTitle;
  bool _loadData = true;
  List<PreferencesItem>? items;
  List<String>? selectedPreferences;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if(_loadData) {
      _loadPreferncesData();
    }
  }

  Future<void> _loadPreferncesData() async {
    final Map<String, dynamic>? args = context.getArgument<Map<String, dynamic>?>();

    setState(() => _appbarTitle = args?['label']);
    selectedPreferences = args?['selectedPreferences'];
    
    _loadPreferncesItems(args?['label']?? '');
  }

  Future<void> _loadPreferncesItems(String value) async {
    switch(value) {
      case burnoutsHistoryFieldName:
        items = _mapPreferencesList(Burnouts);
        break;
      case eventsHistoryFieldName:
        items = _mapPreferencesList(Events);
        break;
      case retentionsHistoryFieldName:
        items = _mapPreferencesList(Retentions);
        break;
      case morningHabitsFieldName:
        items = _mapPreferencesList(Morning);
        break;
      case afternoonHabitsFieldName:
        items = _mapPreferencesList(Afternoon);
        break;
      case eveningHabitsFieldName:
        items = _mapPreferencesList(Evening);
        break;
      case nightHabitsFieldName:
        items = _mapPreferencesList(Night);
        break;
      case noonHabitsFieldName:
        items = _mapPreferencesList(Noon);
        break;
      default:
        items = [];
    }

    for (var item in items!) {
      if (selectedPreferences!.contains(item.item)) {
        item.isSelected = true;
      }
      if (item.subPreferencesItems != null) {
        for (var subItem in item.subPreferencesItems!) {
          if (selectedPreferences!.contains(subItem.title)) {
            subItem.isSelected = true;
          }
        }
      }
    }

    setState(() {
      _loadData = false;
    });
  }

  List<PreferencesItem> _mapPreferencesList(List<Map<String, dynamic>> data) {
    return data.map<PreferencesItem>((itemData) {
      return PreferencesItem(
        item: itemData['item'],
        subPreferencesItems: (itemData['subPreferencesItems'] as List?)
            ?.map<SubPreferencesItem>((subItemData) {
          return SubPreferencesItem(subItemData);
        }).toList(),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BoldText(text: _appbarTitle ?? "Autism Companion", size: 15,),
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(items), 
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: ListView.builder(
        itemCount: items?.length,
        itemBuilder: (context, index) {
          return _buildParentItem(items![index]);
        },
      ),
    );
  }

  Widget _buildParentItem(PreferencesItem item) {
    return ExpansionTile(
      initiallyExpanded: item.isSelected,
      title: Row(
        children: [
          Checkbox(
            value: item.isSelected,
              onChanged: (bool? value) {
                setState(() {
                  item.isSelected = value ?? false;
                  
                  for (var subItem in item.subPreferencesItems!) {
                    subItem.isSelected = item.isSelected;
                  }
                });
              },
              activeColor: AppColors.primaryColor,
              checkColor: AppColors.textColorBlack,
            ),
            Expanded(
              child: LightText(text: item.item, size: 12, align: TextAlign.left),
            ),
          ],
      ),
      children: item.subPreferencesItems != null && item.subPreferencesItems!.isNotEmpty
        ? item.subPreferencesItems!.map((subItem) => _buildSubPreferencesItem(subItem, item)).toList()
        : [],
    );
  }

  Widget _buildSubPreferencesItem(SubPreferencesItem subItem, PreferencesItem parentItem) {
    return CheckboxListTile(
      title: LightText(text: subItem.title, size: 12, align: TextAlign.left),
      controlAffinity: ListTileControlAffinity.leading,
      value: subItem.isSelected,
      onChanged: (bool? value) {
        setState(() {
          subItem.isSelected = value ?? false;
          if (value == true) {
            parentItem.isSelected = true;
          } else {
            bool anySubItemSelected = parentItem.subPreferencesItems!.any((sub) => sub.isSelected);
            if (!anySubItemSelected) {
              parentItem.isSelected = false;
            }
          }
        });
      },
      activeColor: AppColors.primaryColor,
      checkColor: AppColors.textColorBlack,
    );
  }
}