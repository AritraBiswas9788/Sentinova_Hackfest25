import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../models/user_model.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';
import '../services/mongo_service.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _summaryController = TextEditingController();
  final _bodyController = TextEditingController();
  File? _selectedImage;
  String? _uploadedImageUrl;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });
      await _uploadToCloudinary(_selectedImage!);
    }
  }

  Future<void> _uploadToCloudinary(File image) async {
    const cloudName = 'your-cloud-name';
    const uploadPreset = 'your-upload-preset';

    final url =
    Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields['upload_preset'] = uploadPreset
      ..files.add(await http.MultipartFile.fromPath('file', image.path));

    final response = await request.send();
    final res = await http.Response.fromStream(response);

    if (response.statusCode == 200) {
      final responseData = json.decode(res.body);
      setState(() {
        _uploadedImageUrl = responseData['secure_url'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Image upload failed")),
      );
    }
  }

  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      if (_uploadedImageUrl == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Please upload an image")),
        );
        return;
      }

      final dummyAuthor = UserModel(
        id: "u001",
        name: "John Doe",
        email: "john.doe@example.com",
        image: "https://i.pravatar.cc/300",
        followers: 123,
        joined: DateTime(2022, 5, 10),
        posts: 42,
      );

      final newPost = PostModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        summary: _summaryController.text,
        body: _bodyController.text,
        imageURL: _uploadedImageUrl!,
        postTime: DateTime.now(),
        reacts: 0,
        views: 0,
        author: dummyAuthor,
        comments: <CommentModel>[],
      );

      _sendPostToMongoDB(newPost);
      Navigator.pop(context);
    }
  }

  Future<void> _sendPostToMongoDB(PostModel post) async {
    // final success = await MongoService.uploadPostToEvent("67f03774f1e87155ee26e619", post);
    // if (success) {
    //   print("Post uploaded!");
    // }

  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Create New Post")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: _inputDecoration("Title", Icons.title),
                validator: (val) => val == null || val.isEmpty ? 'Enter title' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _summaryController,
                decoration: _inputDecoration("Summary", Icons.short_text),
                validator: (val) => val == null || val.isEmpty ? 'Enter summary' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _bodyController,
                maxLines: 5,
                decoration: _inputDecoration("Body", Icons.article),
                validator: (val) => val == null || val.isEmpty ? 'Enter body' : null,
              ),
              const SizedBox(height: 20),
              _selectedImage != null
                  ? ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(_selectedImage!, height: 200),
              )
                  : TextButton.icon(
                icon: Icon(Icons.image),
                label: Text("Pick Image from Gallery"),
                onPressed: _pickImage,
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _submitPost,
                  icon: Icon(Icons.publish),
                  label: Text("Publish Post"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
