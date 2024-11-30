import 'package:image_picker/image_picker.dart';

class ArtPiece {
  final int id;
  final String title;
  final String artistName;
  final int yearCreated;
  final String medium;
  final String dimensions;
  final String styleGenre;
  final String condition;
  final XFile? imageFile;

  ArtPiece({
    required this.id,
    required this.title,
    required this.artistName,
    required this.yearCreated,
    required this.medium,
    required this.dimensions,
    required this.styleGenre,
    required this.condition,
    this.imageFile,
  });

  ArtPiece copyWith({
    String? title,
    String? artistName,
    int? yearCreated,
    String? medium,
    String? dimensions,
    String? styleGenre,
    String? condition,
    XFile? imageFile,
  }) {
    return ArtPiece(
      id: id,
      title: title ?? this.title,
      artistName: artistName ?? this.artistName,
      yearCreated: yearCreated ?? this.yearCreated,
      medium: medium ?? this.medium,
      dimensions: dimensions ?? this.dimensions,
      styleGenre: styleGenre ?? this.styleGenre,
      condition: condition ?? this.condition,
      imageFile: imageFile ?? this.imageFile,
    );
  }
}
