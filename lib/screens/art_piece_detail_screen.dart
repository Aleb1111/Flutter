import 'dart:io';

import 'package:flutter/material.dart';
import '../models/art_piece.dart';
import 'art_piece_edit_screen.dart';
import '../repository/art_piece_repository.dart';

class ArtPieceDetailScreen extends StatelessWidget {
  final ArtPiece artPiece;
  final ArtPieceRepository repository;

  ArtPieceDetailScreen({required this.artPiece, required this.repository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Art Piece Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image centered at the top with max width and height
            Center(
              child: artPiece.imageFile != null
                  ? Container(
                width: 300, // Set max width
                height: 300, // Set max height
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(File(artPiece.imageFile!.path)),
                    fit: BoxFit.cover, // Crop to fill the container
                  ),
                ),
              )
                  : Container(
                height: 200,
                width: 200,
                color: Colors.grey[300],
                child: Icon(Icons.image, size: 100, color: Colors.grey[700]),
              ),
            ),
            SizedBox(height: 16),

            // Title centered below the image
            Center(
              child: Text(
                artPiece.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),

            // Author (artist name) on the right
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Artist: ${artPiece.artistName}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Year Created below the author, on the right
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'Year Created: ${artPiece.yearCreated}',
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Rest of the details aligned to the left
            Text('Medium: ${artPiece.medium}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Dimensions: ${artPiece.dimensions}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Style/Genre: ${artPiece.styleGenre}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Condition: ${artPiece.condition}', style: TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
