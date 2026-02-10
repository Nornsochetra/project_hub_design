import 'package:flutter/material.dart';
import 'package:project_hub_design/models/project.dart';
import 'package:project_hub_design/services/project_service.dart';

class ProjectViewModel extends ChangeNotifier {
  final ProjectService service = ProjectService();

  List<Project> project = [];
  bool isLoading = false;
  String? error;

  // get all projects
  Future<void> getAllProjects() async {
    isLoading = true;
    notifyListeners();

    try{
      project = await service.fetchAllProjects();
      error = null;
    }catch (e){
      error = e.toString();
    }

    isLoading = false;
    notifyListeners();
  }

  // create project
  Future<void> addProject(String title,String date,double progress,StatusProject status) async {
    isLoading = true;
    notifyListeners();

    try{
      var newProject = await service.createProject(title, date, progress,status);
      project.add(newProject);
      notifyListeners();
    }catch (e) {
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> updateProjectById(String id,String title, String date, double progress,StatusProject status) async {
    final index = project.indexWhere((t) => t.id == id);
    if(index == -1) return;

    // backup old project for rollback
    final oldProject = project[index];

    // optimistic update (local UI update)
    final newProject = Project(
        id: oldProject.id,
        title: title,
        dateTime: DateTime.parse(date),
        progress: progress,
        status: status
    );

    project[index] = newProject;
    notifyListeners();

    try{
      // send to API (progress is 0-100, date is string)
      final response = await service.updateProject(id, title, date, progress, status);
      // replace with server response
      project[index] = response;
      notifyListeners();
    }catch (e) {
      project[index] = oldProject;
      error = e.toString();
      notifyListeners();
    }
  }

  Future<void> deleteProjectById(String id) async {
    final index = project.indexWhere((t) => t.id == id);
    if(index == -1) return;

    final removeProject = project[index];
    project.removeAt(index);
    notifyListeners();

    try{
      await service.deleteProject(id);
    }catch(e){
      project.insert(index, removeProject);
      error = e.toString();
      notifyListeners();
    }
  }
}