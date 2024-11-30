import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../models/art_piece.dart';
import '../repository/art_piece_repository.dart';

class AddArtPieceScreen extends StatefulWidget {
  final ArtPieceRepository repository;

  AddArtPieceScreen({required this.repository});

  @override
  _AddArtPieceScreenState createState() => _AddArtPieceScreenState();
}

class _AddArtPieceScreenState extends State<AddArtPieceScreen> {
  final _formKey = GlobalKey<FormState>(); // FormKey to manage form validation

  final _titleController = TextEditingController();
  final _artistController = TextEditingController();
  final _yearController = TextEditingController();
  final _mediumController = TextEditingController();
  final _dimensionsController = TextEditingController();
  final _styleController = TextEditingController();
  final _conditionController = TextEditingController();

  XFile? _imageFile;

  final ImagePicker _picker = ImagePicker();

  // Image picker function
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedFile;
    });
  }

  // Function to save the art piece
  void _saveArtPiece() {
    if (_formKey.currentState!.validate()) {
      // Only proceed if the form is valid

      final newArtPiece = ArtPiece(
        id: DateTime.now().millisecondsSinceEpoch, // Unique ID based on time
        title: _titleController.text,
        artistName: _artistController.text,
        yearCreated: int.parse(_yearController.text),
        medium: _mediumController.text,
        dimensions: _dimensionsController.text,
        styleGenre: _styleController.text,
        condition: _conditionController.text,
        imageFile: _imageFile,
      );

      try {
        widget.repository.addArtPiece(newArtPiece);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Art piece added successfully!')),
        );

        Navigator.pop(context); // Go back to the list screen
      } catch (e) {
        // Show error message if there is an issue
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error adding art piece: ${e.toString()}')),
        );
      }
    } else {
      // Show error message if the form is not valid
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Art Piece'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Attach form key to the form
          child: ListView(
            children: [
              // Title field with validation
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the title';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),

              // Artist name field with validation
              TextFormField(
                controller: _artistController,
                decoration: const InputDecoration(labelText: 'Artist Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the artist name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),

              // Year created field with validation
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Year Created'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the year';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Please enter a valid year';
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),

              // Medium field
              TextFormField(
                controller: _mediumController,
                decoration: const InputDecoration(labelText: 'Medium'),
              ),
              SizedBox(height: 8),

              // Dimensions field
              TextFormField(
                controller: _dimensionsController,
                decoration: const InputDecoration(labelText: 'Dimensions'),
              ),
              SizedBox(height: 8),

              // Style/Genre field
              TextFormField(
                controller: _styleController,
                decoration: const InputDecoration(labelText: 'Style/Genre'),
              ),
              SizedBox(height: 8),

              // Condition field
              TextFormField(
                controller: _conditionController,
                decoration: const InputDecoration(labelText: 'Condition'),
              ),
              SizedBox(height: 16),

              // Image display and picker button
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: _imageFile == null
                    ? Container(
                  color: Colors.grey[300],
                  height: 200,
                  child: const Icon(Icons.image, size: 100, color: Colors.grey),
                )
                    : Image.file(File(_imageFile!.path)),
              ),
              ElevatedButton(
                onPressed: _pickImage,
                child: const Text('Pick Image'),
              ),
              const SizedBox(height: 16),

              // Save button
              ElevatedButton(
                onPressed: _saveArtPiece,
                child: const Text('Save Art Piece'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
