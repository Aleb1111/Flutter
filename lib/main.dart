import 'package:flutter/material.dart';
import 'package:art_pieces_flutter/repository/art_piece_repository.dart';
import 'screens/ArtPieceListScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ArtPieceRepository repository = ArtPieceRepository();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Art Pieces',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ArtPieceListScreen(repository: repository),
    );
  }
}
