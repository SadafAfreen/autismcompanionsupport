class CardModel {
  final String id;
  final String name;
  final String imageUrl;
  final List<String>? phrases;
  final List<String>? audioUrls;

  CardModel({
    required this.id,
    required this.name,
    required this.imageUrl,
    this.phrases,
    this.audioUrls,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'phrases': phrases,
      'audioUrls': audioUrls,
    };
  }

  static CardModel fromMap(String id, Map<String, dynamic> data) {
    return CardModel(
      id: id,
      name: data['name'],
      imageUrl: data['imageUrl'],
      phrases: List<String>.from(data['phrases'] ?? []),
      audioUrls: List<String>.from(data['audioUrls'] ?? []),
    );
  }
}
