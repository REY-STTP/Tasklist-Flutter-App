import 'package:api_crud_tasklist_flutter/data/models/add_task_request_model.dart';
import 'package:api_crud_tasklist_flutter/data/models/add_task_response_model.dart';
import 'package:api_crud_tasklist_flutter/data/models/task_response_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TaskRemoteDataSource {
  Future<List<TaskResponseModel>> getTasks() async {
    final response = await http.get(
      Uri.parse('http://localhost:3000/api/tasks/'),
    );
    if (response.statusCode == 200) {
      List<dynamic> taskList = json.decode(response.body);
      return taskList.map((task) => TaskResponseModel.fromJson(task)).toList();
    } else {
      throw Exception('Failed to load tasks');
    }
  }

  Future<AddTaskResponseModel> addTask(AddTaskRequestModel data) async {
    final response = await http.post(
      Uri.parse('http://localhost:3000/api/tasks/'),
      body: json.encode(data.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      return AddTaskResponseModel.fromRawJson(response.body);
    } else {
      throw Exception('Failed to add task: ${response.reasonPhrase}');
    }
  }

  Future<void> deleteTask(String id) async {
    final response = await http.delete(
      Uri.parse('http://localhost:3000/api/tasks/$id'),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to delete task');
    }
  }

  Future<void> editTask(String id, AddTaskRequestModel data) async {
    final response = await http.patch(
      Uri.parse('http://localhost:3000/api/tasks/$id'),
      body: json.encode(data.toJson()),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to edit task: ${response.reasonPhrase}');
    }
  }
}