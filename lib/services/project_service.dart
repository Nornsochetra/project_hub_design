import 'dart:convert';
import 'package:project_hub_design/models/project.dart';
import 'package:http/http.dart' as http;

class ProjectService {

  final String baseUrl = 'https://6982b4339c3efeb892a30e71.mockapi.io/api/v1/todo';

  // get all projects
  Future<List<Project>> fetchAllProjects() async {
    var response = await http.get(Uri.parse('$baseUrl/getAll_Project'));

    if(response.statusCode == 200){
      final List data = jsonDecode(response.body);
      return data.map((e) => Project.fromJson(e)).toList();
    }else{
      throw Exception('Failed to load project');
    }
  }

  // create project
  Future<Project> createProject(String title, String date, double progress,StatusProject status) async {
    var response = await http.post(
        Uri.parse('$baseUrl/getAll_Project'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'title': title,
          'date': date,
          'progress': progress,
          'status': status.name
        })
    );

    if(response.statusCode == 201 || response.statusCode == 200){
      return Project.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fail to create project');
    }
  }

  // update project
  Future<Project> updateProject(String id,String title, String date, double progress,StatusProject status) async {
    var response = await http.put(
      Uri.parse('$baseUrl/getAll_Project/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'title': title,
        'date': date,
        'progress': progress,
        'status': status.name
      })
    );

    if(response.statusCode == 200){
      return Project.fromJson(jsonDecode(response.body));
    }else{
      throw Exception('Fail to update project');
    }
  }

  // delete project
  Future<void> deleteProject(String id) async {
    var response = await http.delete(Uri.parse('$baseUrl/getAll_Project/$id'));

    if(response.statusCode == 200){
      print('Project $id delete successfully');
    }else{
      throw Exception('Failed to load project');
    }
  }
}