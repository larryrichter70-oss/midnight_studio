import 'package:flutter/material.dart';
import '../../core/controllers/project_controller.dart';
import '../../core/models/music_project.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/midnight_header.dart';
import 'project_detail_page.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  Future<void> createDemoProject() async {
    final now = DateTime.now();

    final project = MusicProject(
      id: now.millisecondsSinceEpoch.toString(),
      title: 'Neuer Midnight Track',
      genre: 'Dark Pop',
      mood: 'Dunkel · emotional',
      lyrics: '',
      createdAt: now,
    );

    await ProjectController.addProject(project);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.background,
              AppColors.midnightBlue,
              AppColors.deepPurple,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const MidnightHeader(
                  title: 'Projekte',
                  subtitle: 'Alle Songs und Entwürfe an einem Ort.',
                  icon: Icons.folder_rounded,
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: createDemoProject,
                    icon: const Icon(Icons.add_rounded),
                    label: const Text('Neues Projekt erstellen'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.gold,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                Expanded(
                  child: ValueListenableBuilder<List<MusicProject>>(
                    valueListenable: ProjectController.projects,
                    builder: (context, projects, _) {
                      if (projects.isEmpty) {
                        return const EmptyProjectsCard();
                      }

                      return ListView.separated(
                        itemCount: projects.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final project = projects[index];

                          return ProjectCard(
                            project: project,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => ProjectDetailPage(
                                    project: project,
                                  ),
                                ),
                              );
                            },
                            onDelete: () {
                              ProjectController.deleteProject(project.id);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EmptyProjectsCard extends StatelessWidget {
  const EmptyProjectsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.library_music_rounded,
            color: AppColors.gold,
            size: 42,
          ),
          SizedBox(height: 14),
          Text(
            'Noch keine Projekte',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Erstelle dein erstes Midnight-Studio-Projekt.',
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final MusicProject project;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final genre = project.genre.isEmpty ? 'Kein Genre' : project.genre;
    final mood = project.mood.isEmpty ? 'Keine Stimmung' : project.mood;

    return GlassCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withOpacity(0.16),
              border: Border.all(
                color: AppColors.gold.withOpacity(0.45),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withOpacity(0.22),
                  blurRadius: 22,
                ),
              ],
            ),
            child: const Icon(
              Icons.graphic_eq_rounded,
              color: AppColors.gold,
              size: 30,
            ),
          ),

          const SizedBox(width: 18),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  project.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  genre,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  mood,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.silver,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),

          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete_outline_rounded,
              color: AppColors.silver,
            ),
          ),
        ],
      ),
    );
  }
}