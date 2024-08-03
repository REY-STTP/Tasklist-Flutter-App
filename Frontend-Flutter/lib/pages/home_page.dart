import 'package:api_crud_tasklist_flutter/data/datasources/task_remote_datasource.dart';
import 'package:api_crud_tasklist_flutter/data/models/task_response_model.dart';
import 'package:api_crud_tasklist_flutter/pages/add_task_page.dart';
import 'package:api_crud_tasklist_flutter/pages/detail_task_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoaded = false;
  List<TaskResponseModel> tasks = [];

  Future<void> getTasks() async {
    setState(() {
      isLoaded = true;
    });
    try {
      tasks = await TaskRemoteDataSource().getTasks();
      setState(() {
        isLoaded = false;
      });
    } catch (e) {
      setState(() {
        isLoaded = false;
      });
      // Handle the error here
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getTasks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.title,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 2,
        backgroundColor: Colors.blue,
      ),
      body: isLoaded
          ? const Center(child: CircularProgressIndicator())
          : tasks.isEmpty
              ? const Center(child: Text('Daftar Tugas Kosong', style: TextStyle(fontSize: 18, color: Colors.grey)))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return DetailTaskPage(task: tasks[index]);
                        }));
                      },
                      child: Card(
                        child: ListTile(
                          title: Text(tasks[index].title),
                          subtitle: Text(tasks[index].description),
                          trailing: const Icon(Icons.check_circle),
                        ),
                      ),
                    );
                  },
                  itemCount: tasks.length,
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddTaskPage();
          }));
          getTasks();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}