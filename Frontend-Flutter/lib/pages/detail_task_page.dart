import 'package:api_crud_tasklist_flutter/data/datasources/task_remote_datasource.dart';
import 'package:api_crud_tasklist_flutter/data/models/task_response_model.dart';
import 'package:api_crud_tasklist_flutter/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:api_crud_tasklist_flutter/pages/edit_task_page.dart';

class DetailTaskPage extends StatefulWidget {
  final TaskResponseModel task;

  const DetailTaskPage({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<DetailTaskPage> createState() => _DetailTaskPageState();
}

class _DetailTaskPageState extends State<DetailTaskPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Tugas',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        children: [
          Text('Judul : ${widget.task.title}'),
          const SizedBox(height: 16),
          Text('Deskripsi : ${widget.task.description}'),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => EditTaskPage(task: widget.task),
                    ),
                  );
                  if (result == true) {
                    setState(() {});
                  }
                },
                child: const Text('Edit'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.red,
                ),
                onPressed: () {
                  showDialog(context: context, builder: (context) {
                    return AlertDialog(
                      title: const Text('Konfirmasi'),
                      content: const Text('Apakah kamu yakin ingin menghapus tugas?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Tidak'),
                        ),
                        TextButton(
                          onPressed: () async {
                            try {
                              await TaskRemoteDataSource().deleteTask(widget.task.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Tugas berhasil dihapus',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                                return const HomePage(title: 'Daftar Tugas');
                              }));
                            } catch (e) {
                              // Show an error message
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    'Gagal untuk menghapus tugas: $e',
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          },
                          child: const Text('Ya'),
                        ),
                      ],
                    );
                  });
                },
                child: const Text('Hapus'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}