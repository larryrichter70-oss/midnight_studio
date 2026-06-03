import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/music_project.dart';

class ProjectService {
  static const String _storageKey = 'midnight_studio_projects';

  static Future<List<MusicProject>> loadProjects() async {
    final prefs = await SharedPreferences.getInstance();
    final rawData = prefs.getString(_storageKey);

    if (rawData == null || rawData.isEmpty) {
      return [];
    }

    final decoded = jsonDecode(rawData);

    if (decoded is! List) {
      return [];
    }

    return decoded
        .whereType<Map<String, dynamic>>()
        .map(MusicProject.fromJson)
        .toList();
  }

  static Future<void> saveProjects(List<MusicProject> projects) async {
    final prefs = await SharedPreferences.getInstance();

    final encoded = jsonEncode(
      projects.map((project) => project.toJson()).toList(),
    );

    await prefs.setString(_storageKey, encoded);
  }

  static Future<void> addProject(MusicProject project) async {
    final projects = await loadProjects();
    projects.add(project);
    await saveProjects(projects);
  }

  static Future<void> updateProject(MusicProject updatedProject) async {
    final projects = await loadProjects();

    final index = projects.indexWhere(
      (project) => project.id == updatedProject.id,
    );

    if (index == -1) {
      return;
    }

    projects[index] = updatedProject;
    await saveProjects(projects);
  }

  static Future<void> deleteProject(String projectId) async {
    final projects = await loadProjects();

    projects.removeWhere(
      (project) => project.id == projectId,
    );

    await saveProjects(projects);
  }
}