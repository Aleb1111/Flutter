import 'package:flutter/material.dart';
import '../models/art_piece.dart';
import '../repository/art_piece_repository.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ArtPieceEditScreen extends StatefulWidget {
  final ArtPiece? artPiece;
  final ArtPieceRepository repository;

  ArtPieceEditScreen({this.artPiece, required this.repository});

  @override
  _ArtPieceEditScreenState createState() => _ArtPieceEditScreenState();
}

class _ArtPieceEditScreenState extends State<ArtPieceEditScreen> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  late TextEditingController _titleController;
  late TextEditingController _artistNameController;
  late TextEditingController _yearController;
  late TextEditingController _mediumController;
  late TextEditingController _dimensionsController;
  late TextEditingController _styleController;
  late TextEditingController _conditionController;

  @override
  void initState() {
    super.initState();

    // Initialize controllers with existing values if editing
    _titleController = TextEditingController(text: widget.artPiece?.title ?? '');
    _artistNameController = TextEditingController(text: widget.artPiece?.artistName ?? '');
    _yearController = TextEditingController(text: widget.artPiece?.yearCreated.toString() ?? '');
    _mediumController = TextEditingController(text: widget.artPiece?.medium ?? '');
    _dimensionsController = TextEditingController(text: widget.artPiece?.dimensions ?? '');
    _styleController = TextEditingController(text: widget.artPiece?.styleGenre ?? '');
    _conditionController = TextEditingController(text: widget.artPiece?.condition ?? '');
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  void _saveArtPiece() {
    if (_formKey.currentState!.validate()) {
      // If all fields are valid, save or update the art piece
      final newArtPiece = ArtPiece(
        id: widget.artPiece?.id ?? DateTime.now().millisecondsSinceEpoch, // For new art pieces, generate a new ID
        title: _titleController.text,
        artistName: _artistNameController.text,
        yearCreated: int.parse(_yearController.text),
        medium: _mediumController.text,
        dimensions: _dimensionsController.text,
        styleGenre: _styleController.text,
        condition: _conditionController.text,
        imageFile: _image, // Use the selected image
      );

      // If editing, update; if adding, save a new one
      if (widget.artPiece != null) {
        widget.repository.updateArtPiece(newArtPiece);
      } else {
        widget.repository.addArtPiece(newArtPiece);
      }

      // Show success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Art piece saved successfully!')),
      );

      Navigator.pop(context); // Go back to the previous screen
    } else {
      // If form is not valid, show error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artPiece == null ? 'Add Art Piece' : 'Edit Art Piece'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Image picker
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.grey[300],
                  child: _image == null
                      ? Center(child: Icon(Icons.image, size: 50, color: Colors.grey[700]))
                      : Image.file(File(_image!.path), fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 16),

              // Title field
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Please enter the title' : null,
              ),
              SizedBox(height: 8),

              // Artist name field
              TextFormField(
                controller: _artistNameController,
                decoration: InputDecoration(labelText: 'Artist Name'),
                validator: (value) => value!.isEmpty ? 'Please enter the artist name' : null,
              ),
              SizedBox(height: 8),

              // Year field
              TextFormField(
                controller: _yearController,
                decoration: InputDecoration(labelText: 'Year Created'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter the year';
                  if (int.tryParse(value) == null) return 'Please enter a valid year';
                  return null;
                },
              ),
              SizedBox(height: 8),

              // Other fields...
              TextFormField(
                controller: _mediumController,
                decoration: InputDecoration(labelText: 'Medium'),
              ),
              SizedBox(height: 8),

              TextFormField(
                controller: _dimensionsController,
                decoration: InputDecoration(labelText: 'Dimensions'),
              ),
              SizedBox(height: 8),

              TextFormField(
                controller: _styleController,
                decoration: InputDecoration(labelText: 'Style/Genre'),
              ),
              SizedBox(height: 8),

              TextFormField(
                controller: _conditionController,
                decoration: InputDecoration(labelText: 'Condition'),
              ),
              SizedBox(height: 16),

              // Save button
              ElevatedButton(
                onPressed: _saveArtPiece,
                child: Text(widget.artPiece == null ? 'Add Art Piece' : 'Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
