import 'package:flutter/material.dart';
import 'dart:io';
import 'art_piece_detail_screen.dart';
import 'add_art_piece_screen.dart';
import 'art_piece_edit_screen.dart'; // Import the edit screen
import '../models/art_piece.dart';
import '../repository/art_piece_repository.dart';

class ArtPieceListScreen extends StatefulWidget {
  final ArtPieceRepository repository;

  ArtPieceListScreen({required this.repository});

  @override
  _ArtPieceListScreenState createState() => _ArtPieceListScreenState();
}

class _ArtPieceListScreenState extends State<ArtPieceListScreen> {
  late List<ArtPiece> artPieces;

  @override
  void initState() {
    super.initState();
    // Initialize the list of art pieces
    artPieces = widget.repository.getArtPieces();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Art Pieces'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              // Navigate to the Add Art Piece screen
              await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddArtPieceScreen(repository: widget.repository),
                ),
              );
              // Refresh the list after returning
              setState(() {
                artPieces = widget.repository.getArtPieces();
              });
            },
          ),
        ],
      ),
      body: artPieces.isEmpty
          ? const Center(child: Text('No art pieces available.'))
          : ListView.builder(
        itemCount: artPieces.length,
        itemBuilder: (context, index) {
          final artPiece = artPieces[index];
          return ListTile(
            title: Text(artPiece.title),
            subtitle: Text('By: ${artPiece.artistName}'),
            leading: artPiece.imageFile != null
                ? Image.file(
              File(artPiece.imageFile!.path),
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            )
                : Icon(Icons.image, size: 50, color: Colors.grey),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtPieceDetailScreen(
                    artPiece: artPiece,
                    repository: widget.repository,
                  ),
                ),
              );
            },
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blue),
                  onPressed: () async {
                    // Navigate to the Edit Art Piece screen
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArtPieceEditScreen(
                          artPiece: artPiece,
                          repository: widget.repository,
                        ),
                      ),
                    );
                    // Refresh the list after returning from the edit screen
                    setState(() {
                      artPieces = widget.repository.getArtPieces();
                    });
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () async {
                    // Show confirmation dialog before deleting
                    bool shouldDelete = await _showDeleteConfirmationDialog(context);
                    if (shouldDelete) {
                      // Delete the art piece from the repository
                      widget.repository.deleteArtPiece(artPiece.id);
                      // Refresh the list
                      setState(() {
                        artPieces = widget.repository.getArtPieces();
                      });
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<bool> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Art Piece'),
          content: const Text('Are you sure you want to delete this art piece?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // User cancelled
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // User confirmed
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    ).then((value) => value ?? false); // Ensure the return is not null
  }
}
