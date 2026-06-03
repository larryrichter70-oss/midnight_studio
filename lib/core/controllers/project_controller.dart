import 'package:flutter/foundation.dart';

import '../models/music_project.dart';
import '../services/project_service.dart';

class ProjectController {
  static final ValueNotifier<List<MusicProject>> projects =
      ValueNotifier<List<MusicProject>>([]);

  static Future<void> loadProjects() async {
    projects.value = await ProjectService.loadProjects();
  }

  static Future<void> addProject(MusicProject project) async {
    final updatedProjects = [...projects.value, project];
    projects.value = updatedProjects;
    await ProjectService.saveProjects(updatedProjects);
  }

  static Future<void> updateProject(MusicProject updatedProject) async {
    final updatedProjects = projects.value.map((project) {
      if (project.id == updatedProject.id) {
        return updatedProject;
      }

      return project;
    }).toList();

    projects.value = updatedProjects;
    await ProjectService.saveProjects(updatedProjects);
  }

  static Future<void> deleteProject(String projectId) async {
    final updatedProjects = projects.value
        .where((project) => project.id != projectId)
        .toList();

    projects.value = updatedProjects;
    await ProjectService.saveProjects(updatedProjects);
  }
}