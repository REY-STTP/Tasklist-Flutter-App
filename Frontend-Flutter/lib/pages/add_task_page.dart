import 'package:api_crud_tasklist_flutter/data/datasources/task_remote_datasource.dart';
import 'package:api_crud_tasklist_flutter/data/models/add_task_request_model.dart';
import 'package:flutter/material.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Tambah Tugas',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              hintText: 'Judul',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(
              hintText: 'Deskripsi',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final model = AddTaskRequestModel(
                title: titleController.text,
                description: descriptionController.text,
              );
              try {
                final response = await TaskRemoteDataSource().addTask(model);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Tugas berhasil ditambahkan',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                Navigator.pop(context, response);
              } catch (e) {
                // Show an error message
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Gagal untuk menambahkan tugas: $e',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Colors.green,
            ),
            child: const Text('Tambah'),
          ),
        ],
      ),
    );
  }
}