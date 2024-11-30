import '../models/art_piece.dart';

class ArtPieceRepository {
  final List<ArtPiece> _artPieces = [];

  // Add hardcoded 10 art pieces
  ArtPieceRepository() {
    _artPieces.addAll([
      ArtPiece(
        id: 1,
        title: 'Starry Night',
        artistName: 'Vincent van Gogh',
        yearCreated: 1889,
        medium: 'Oil on Canvas',
        dimensions: '73.7 x 92.1 cm',
        styleGenre: 'Post-Impressionism',
        condition: 'Excellent',
        imageFile: null, // No image initially
      ),
      ArtPiece(
        id: 2,
        title: 'The Persistence of Memory',
        artistName: 'Salvador Dalí',
        yearCreated: 1931,
        medium: 'Oil on Canvas',
        dimensions: '24 x 33 cm',
        styleGenre: 'Surrealism',
        condition: 'Good',
        imageFile: null, // No image initially
      ),
      ArtPiece(
        id: 3,
        title: 'Mona Lisa',
        artistName: 'Leonardo da Vinci',
        yearCreated: 1503,
        medium: 'Oil on Poplar',
        dimensions: '77 x 53 cm',
        styleGenre: 'Renaissance',
        condition: 'Excellent',
        imageFile: null, // No image initially
      ),
      ArtPiece(
        id: 4,
        title: 'The Scream',
        artistName: 'Edvard Munch',
        yearCreated: 1893,
        medium: 'Oil on Canvas',
        dimensions: '91 x 73.5 cm',
        styleGenre: 'Expressionism',
        condition: 'Fair',
        imageFile: null, // No image initially
      ),
      ArtPiece(
        id: 5,
        title: 'The Girl with a Pearl Earring',
        artistName: 'Johannes Vermeer',
        yearCreated: 1665,
        medium: 'Oil on Canvas',
        dimensions: '44.5 x 39 cm',
        styleGenre: 'Baroque',
        condition: 'Good',
        imageFile: null, // No image initially
      ),
      ArtPiece(
        id: 6,
        title: 'Guernica',
        artistName: 'Pablo Picasso',
        yearCreated: 1937,
        medium: 'Oil on Canvas',
        dimensions: '349 x 776 cm',
        styleGenre: 'Cubism',
        condition: 'Excellent',
        imageFile: null, // No image initially
      ),
      ArtPiece(
        id: 7,
        title: 'The Kiss',
        artistName: 'Gustav Klimt',
        yearCreated: 1907,
        medium: 'Oil and Gold Leaf on Canvas',
        dimensions: '180 x 180 cm',
        styleGenre: 'Symbolism',
        condition: 'Good',
        imageFile: null, // No image initially
      ),
      ArtPiece(
        id: 8,
        title: 'The Night Watch',
        artistName: 'Rembrandt van Rijn',
        yearCreated: 1642,
        medium: 'Oil on Canvas',
        dimensions: '363 x 437 cm',
        styleGenre: 'Baroque',
        condition: 'Fair',
        imageFile: null, // No image initially
      ),
      ArtPiece(
        id: 9,
        title: 'The Birth of Venus',
        artistName: 'Sandro Botticelli',
        yearCreated: 1486,
        medium: 'Tempera on Canvas',
        dimensions: '172.5 x 278.9 cm',
        styleGenre: 'Renaissance',
        condition: 'Excellent',
        imageFile: null, // No image initially
      ),
      ArtPiece(
        id: 10,
        title: 'The Creation of Adam',
        artistName: 'Michelangelo',
        yearCreated: 1512,
        medium: 'Fresco',
        dimensions: '280 x 570 cm',
        styleGenre: 'Renaissance',
        condition: 'Good',
        imageFile: null, // No image initially
      ),
    ]);
  }

  List<ArtPiece> getArtPieces() {
    return _artPieces;
  }

  ArtPiece getArtPiece(int id) {
    return _artPieces.firstWhere((artPiece) => artPiece.id == id);
  }

  void addArtPiece(ArtPiece artPiece) {
    _artPieces.add(artPiece);
  }

  void updateArtPiece(ArtPiece updatedArtPiece) {
    final index = _artPieces.indexWhere((artPiece) => artPiece.id == updatedArtPiece.id);
    if (index != -1) {
      _artPieces[index] = updatedArtPiece;
    }
  }

  void deleteArtPiece(int id) {
    _artPieces.removeWhere((artPiece) => artPiece.id == id);
  }
}
