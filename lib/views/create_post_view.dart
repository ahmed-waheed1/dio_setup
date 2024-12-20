import 'package:dio_setup/models/post_request.dart';
import 'package:dio_setup/network/api_service.dart';
import 'package:flutter/material.dart';

class CreatePostView extends StatelessWidget {
  CreatePostView({super.key});
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Post'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Title is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  decoration: const InputDecoration(
                    hintText: 'Title',
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Body is required';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  controller: _bodyController,
                  decoration: const InputDecoration(
                    hintText: 'Body',
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _onCreatePost(
                          context, _titleController.text, _bodyController.text);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please fill all fields'),
                        ),
                      );
                    }
                  },
                  child: const Text('Create Post'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onCreatePost(context, String title, String body) {
    PostRequest postRequest = PostRequest(
      title: title,
      body: body,
    );
    ApiService.instance.createPost(postRequest).then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Post created successfully'),
        ),
      );
    }).catchError((error)  {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to create post'),
        ),
      );
    });
  }
}
