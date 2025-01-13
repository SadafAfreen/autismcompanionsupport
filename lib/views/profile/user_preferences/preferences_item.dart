class PreferencesItem {
  String item;
  bool isSelected;
  List<SubPreferencesItem>? subPreferencesItems;

  PreferencesItem({
    required this.item,
    this.isSelected = false,
    this.subPreferencesItems,
  });
}

class SubPreferencesItem {
  String title;
  bool isSelected;

  SubPreferencesItem(this.title, {this.isSelected = false});
}