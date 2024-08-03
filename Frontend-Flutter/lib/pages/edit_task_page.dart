import 'package:flutter/material.dart';
import 'package:api_crud_tasklist_flutter/data/models/task_response_model.dart';
import 'package:api_crud_tasklist_flutter/data/datasources/task_remote_datasource.dart';
import 'package:api_crud_tasklist_flutter/data/models/add_task_request_model.dart';
import 'package:api_crud_tasklist_flutter/pages/home_page.dart';

class EditTaskPage extends StatefulWidget {
  final TaskResponseModel task;

  const EditTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<EditTaskPage> createState() => _EditTaskPageState();
}

class _EditTaskPageState extends State<EditTaskPage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    titleController.text = widget.task.title;
    descriptionController.text = widget.task.description;
  }

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
        title: const Text('Edit Tugas'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Judul',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Deskripsi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final editedTask = AddTaskRequestModel(
                  title: titleController.text,
                  description: descriptionController.text,
                );
                try {
                  await TaskRemoteDataSource().editTask(widget.task.id, editedTask);
                  // Show a success message
                  ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Tugas berhasil diperbarui',
                      style: const TextStyle(color: Colors.white),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
                  // Navigate to HomePage and clear the stack
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage(title: 'Daftar Tugas')),
                    (Route<dynamic> route) => false,
                  );
                } catch (e) {
                  // Show an error message
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Gagal untuk memperbarui tugas: $e',
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              },
              child: const Text('Edit'),
            ),
          ],
        ),
      ),
    );
  }
}