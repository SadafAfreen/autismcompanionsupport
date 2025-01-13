import 'package:autismcompanionsupport/constants/routes.dart';
import 'package:autismcompanionsupport/views/profile/user_preferences/expansion_item.dart';
import 'package:autismcompanionsupport/views/profile/user_preferences/preferences_item.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ExpansionView extends StatefulWidget {
  final String title;
  Map<String, dynamic>? selectedPreferences;
  Function(Map<String, dynamic>)? callback;

  ExpansionView({
    super.key, 
    required this.title,
    this.selectedPreferences,
    this.callback,
  });

  @override
  State<ExpansionView> createState() => _ExpansionViewState();
}

class _ExpansionViewState extends State<ExpansionView> {
  bool _isExpanded = false;
  late List<ExpansionItem> items = [];
  late List<String> selectedPreferencesList = [];

  @override
  initState() {
    if (mounted) _loadItemsFromPreferences(widget.selectedPreferences);
    
    super.initState();
  }

  Future<void> _navigateAndDisplaySelection(String value, List<String> selectedPreferences) async {
    final List<PreferencesItem>? items = await Navigator.of(context).pushNamed(
      preferencesViewRoute,
      arguments: {'label': value, 'selectedPreferences': selectedPreferences},
    ) as List<PreferencesItem>?;

    if(mounted && items != null){
      _updateSelectedPreferences(items, value);
      
      setState(() {
        _loadItemsFromPreferences(widget.selectedPreferences);
        widget.callback!(widget.selectedPreferences!);
      });
    }
  }

  void _updateSelectedPreferences(List<PreferencesItem> items, String key) {
    widget.selectedPreferences ??= {};
    List<PreferencesItem> updatedPreferences = [];

    for (var item in items) {
      List<SubPreferencesItem> selectedSubItems = [];
      for (var subItem in item.subPreferencesItems!) {
        if (subItem.isSelected) {
          selectedSubItems.add(subItem); 
        }
      }
      if (selectedSubItems.isNotEmpty) {
        updatedPreferences.add(
          PreferencesItem(
            item: item.item, 
            subPreferencesItems: selectedSubItems,
          )
        );
      }
    }

    setState(() {
      widget.selectedPreferences![key] = updatedPreferences.isEmpty ? [] : updatedPreferences;
    });
  }

  void _loadItemsFromPreferences(Map<String, dynamic>? preferences) {
    if(preferences == null) items = [];
    
    selectedPreferencesList = [];

    items = preferences!.map((key, value) {
      List<String> subItems = [];
      if(value is List && value.isNotEmpty) {
        for (var subItem in value) {
          subItems.add(subItem.item);
          selectedPreferencesList.add(subItem.item);
          for (var subItem in subItem.subPreferencesItems!) {
            if(subItem is List) {
              for(var pref in subItem) {
                selectedPreferencesList.add(pref.title);
              }
            } else {
              selectedPreferencesList.add(subItem.title);
            }
          }
        }
      }

      return MapEntry(
        key,
        ExpansionItem(label: key, subItems: subItems),
      );
    }).values.toList();
  }

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: Text(widget.title),
      trailing: Icon(
        _isExpanded ? Icons.expand_less : Icons.expand_more,
      ),
      initiallyExpanded: _isExpanded,
      onExpansionChanged: (expanded) {
        setState(() {
          _isExpanded = expanded;
        });
      },
      children: items.map((item) {
        String subItemsText = item.subItems.join(", ");
        
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: TextFormField(
            initialValue: subItemsText.isNotEmpty ? subItemsText : "",
            keyboardType: TextInputType.none, 
            maxLines: null,
            minLines: 1,
            style: const TextStyle(
              fontSize: 12,
            ),
            decoration: InputDecoration(
              labelText: item.label,
            ),
            onTap: () async {
              await _navigateAndDisplaySelection(item.label, selectedPreferencesList); 
              setState(() {
                subItemsText = subItemsText.isNotEmpty ? subItemsText : "";
              });
            },
          ),
        );
      }).toList(),
    );
  }
}