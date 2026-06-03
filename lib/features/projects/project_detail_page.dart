import 'package:flutter/material.dart';
import '../../core/controllers/project_controller.dart';
import '../../core/models/music_project.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/midnight_header.dart';
import '../beats/beats_page.dart';
import '../recording/recording_page.dart';
import '../songwriter/songwriter_page.dart';
import '../mixing/mixing_page.dart';

class ProjectDetailPage extends StatefulWidget {
  final MusicProject project;

  const ProjectDetailPage({
    super.key,
    required this.project,
  });

  @override
  State<ProjectDetailPage> createState() => _ProjectDetailPageState();
}

class _ProjectDetailPageState extends State<ProjectDetailPage> {
  late TextEditingController titleController;
  late TextEditingController genreController;
  late TextEditingController moodController;

  MusicProject get currentProject {
    return ProjectController.projects.value.firstWhere(
      (project) => project.id == widget.project.id,
      orElse: () => widget.project,
    );
  }

  @override
  void initState() {
    super.initState();

    titleController = TextEditingController(text: currentProject.title);
    genreController = TextEditingController(text: currentProject.genre);
    moodController = TextEditingController(text: currentProject.mood);
  }

  @override
  void dispose() {
    titleController.dispose();
    genreController.dispose();
    moodController.dispose();
    super.dispose();
  }

  MusicProject get previewProject {
    final latest = currentProject;

    return latest.copyWith(
      title: titleController.text.trim().isEmpty
          ? latest.title
          : titleController.text.trim(),
      genre: genreController.text.trim(),
      mood: moodController.text.trim(),
    );
  }

  Future<void> saveProject() async {
    await ProjectController.updateProject(previewProject);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Projekt gespeichert.')),
    );

    Navigator.pop(context);
  }

  void openSongwriter() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SongwriterPage(project: previewProject),
      ),
    );
  }

  void openBeats() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BeatsPage(project: previewProject),
      ),
    );
  }

  void openRecording() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => RecordingPage(project: previewProject),
      ),
    );
  }
  void openMixing() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MixingPage(project: previewProject),
      ),
    );
  }

  Future<void> deleteProject() async {
    await ProjectController.deleteProject(widget.project.id);

    if (!mounted) return;

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final latest = currentProject;

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
            child: ListView(
              children: [
                const MidnightHeader(
                  title: 'Projekt',
                  subtitle: 'Projekt bearbeiten und Studio-Bereiche öffnen.',
                  icon: Icons.library_music_rounded,
                  showBackButton: true,
                ),

                const SizedBox(height: 24),

                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InputField(
                        label: 'Titel',
                        hint: 'z. B. Night Pulse',
                        controller: titleController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Genre',
                        hint: 'z. B. Dark Pop',
                        controller: genreController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Stimmung',
                        hint: 'z. B. dunkel · emotional',
                        controller: moodController,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Projektbereiche',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 14),

                      _ProjectAreaButton(
                        icon: Icons.edit_note_rounded,
                        title: 'Songwriter öffnen',
                        subtitle: latest.lyrics.isEmpty
                            ? 'Text und Lyrics bearbeiten'
                            : 'Songtext vorhanden',
                        accent: AppColors.neonPurple,
                        onTap: openSongwriter,
                      ),

                      const SizedBox(height: 10),

                      _ProjectAreaButton(
                        icon: Icons.music_note_rounded,
                        title: 'Beats öffnen',
                        subtitle: latest.beatBpm.isEmpty
                            ? 'Genre, BPM und Instrumente bearbeiten'
                            : '${latest.beatGenre} · ${latest.beatBpm} BPM',
                        accent: AppColors.gold,
                        onTap: openBeats,
                      ),

                      const SizedBox(height: 10),

                      _ProjectAreaButton(
                        icon: Icons.mic_rounded,
                        title: 'Aufnahme öffnen',
                        subtitle: latest.recordingName.isEmpty
                            ? 'Takes, Status und Notizen bearbeiten'
                            : '${latest.recordingName} · ${latest.recordingStatus}',
                        accent: AppColors.neonBlue,
                        onTap: openRecording,
                      ),
                      const SizedBox(height: 10),

                      _ProjectAreaButton(
                        icon: Icons.tune_rounded,
                        title: 'Mixing öffnen',
                        subtitle: 'Mix, Mastering und Notizen bearbeiten',
                        accent: AppColors.silver,
                        onTap: openMixing,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: saveProject,
                    icon: const Icon(Icons.save_rounded),
                    label: const Text('Projekt speichern'),
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

                const SizedBox(height: 10),

                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: deleteProject,
                    icon: const Icon(Icons.delete_outline_rounded),
                    label: const Text('Projekt löschen'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.silver,
                      side: BorderSide(
                        color: AppColors.silver.withOpacity(0.35),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
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

class _ProjectAreaButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback onTap;

  const _ProjectAreaButton({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(14),
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, color: accent, size: 30),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: accent,
            size: 16,
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 14,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(color: AppColors.textSecondary),
            filled: true,
            fillColor: Colors.black.withOpacity(0.22),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 13,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.silver.withOpacity(0.18),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: AppColors.silver.withOpacity(0.18),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: const BorderSide(color: AppColors.gold),
            ),
          ),
        ),
      ],
    );
  }
}