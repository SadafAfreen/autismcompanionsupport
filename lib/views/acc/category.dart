class CategoryModel {
  final String name;
  final String? imageUrl;
  final String? audioUrl;
  final List<Map<String, dynamic>> subcategories;

  CategoryModel({
    required this.name, 
    this.imageUrl,
    this.audioUrl,
    this.subcategories = const [],
  });

  Map<String, dynamic> toMap() => {
        'name': name,
        'imageUrl': imageUrl,
        'audioUrl': audioUrl,
        'subcategories': subcategories,
      };

  factory CategoryModel.fromMap(Map<String, dynamic> map) => CategoryModel(
        name: map['name'],
        imageUrl: map['imageUrl'],
        audioUrl: map['audioUrl'],
        subcategories: List<Map<String, dynamic>>.from(map['subcategories'] ?? []),
      );
}