import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:sentinova/helper/data.dart';
import 'package:sentinova/helper/demo_values.dart';
import 'package:sentinova/screens/sign_in.dart';
import 'package:sentinova/services/apiservice.dart';
import 'dart:convert';

import '../helper/constant.dart';
import '../models/user_model.dart';
import '../models/comment_model.dart';
import '../models/post_model.dart';

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

  bool _isPoll = false;
  List<TextEditingController> _pollOptionControllers = [
    TextEditingController(),
    TextEditingController(),
  ];

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
    const uploadPreset = 'your-upload-preset';

    final url =
    Uri.parse('https://api.cloudinary.com/v1_1/$CLOUD_NAME/image/upload');

    final request = http.MultipartRequest('POST', url)
      ..fields[UPLOAD_PRESET] = uploadPreset
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

  void _addPollOptionField() {
    setState(() {
      _pollOptionControllers.add(TextEditingController());
    });
  }

  void _removePollOptionField(int index) {
    setState(() {
      _pollOptionControllers.removeAt(index);
    });
  }

  void _submitPost() {
    if (_formKey.currentState!.validate()) {
      _uploadedImageUrl ??= "https://static.thenounproject.com/png/1095867-200.png";

      var author = currUser ?? UserModel(
        id: "u001",
        name: "John Doe",
        email: "john.doe@example.com",
        image: "https://i.pravatar.cc/300",
        joined: DateTime(2022, 5, 10),
        posts: 42,
      );



      var newPost = PostModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: _titleController.text,
        summary: _summaryController.text,
        body: _bodyController.text,
        imageURL: _uploadedImageUrl!,
        postTime: DateTime.now(),
        reacts: 0,
        views: 0,
        author: author,
        comments: <CommentModel>[],
        options: _isPoll
            ? _pollOptionControllers
            .where((c) => c.text.trim().isNotEmpty)
            .map((c) => PollOption(text: c.text.trim()))
            .toList()
            : [],
        isPoll: _isPoll,
      );
        // ..options.addAll(
        //   _isPoll
        //       ? _pollOptionControllers
        //       .where((c) => c.text.trim().isNotEmpty)
        //       .map((c) => PollOption(text: c.text.trim()))
        //       .toList()
        //       : [],
        // );

      _sendPostToMongoDB(newPost);
      Navigator.pop(context);
    }
  }

  Future<void> _sendPostToMongoDB(PostModel post) async {
    // DemoValues.posts.add(post);
    // await MongoService.uploadPostToEvent("your-event-id", post);
    print("uploading post...");
    await ApiService.addPost(post);
    print("uploaded post!!!");
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
              SwitchListTile(
                title: Text("Make this a Poll?"),
                value: _isPoll,
                onChanged: (val) => setState(() => _isPoll = val),
              ),
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
              if (_isPoll) ...[
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Poll Options", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 8),
                for (int i = 0; i < _pollOptionControllers.length; i++)
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _pollOptionControllers[i],
                          decoration: InputDecoration(
                            labelText: 'Option ${i + 1}',
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          ),
                          validator: (val) {
                            if (_isPoll && (val == null || val.trim().isEmpty)) {
                              return 'Enter option';
                            }
                            return null;
                          },
                        ),
                      ),
                      if (_pollOptionControllers.length > 2)
                        IconButton(
                          icon: Icon(Icons.remove_circle_outline),
                          onPressed: () => _removePollOptionField(i),
                        ),
                    ],
                  ),
                TextButton.icon(
                  onPressed: _addPollOptionField,
                  icon: Icon(Icons.add),
                  label: Text("Add Option"),
                ),
              ],
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
