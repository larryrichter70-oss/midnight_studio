import 'package:flutter/material.dart';
import '../../core/controllers/project_controller.dart';
import '../../core/models/music_project.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/midnight_header.dart';

class SongwriterPage extends StatefulWidget {
  final MusicProject? project;

  const SongwriterPage({
    super.key,
    this.project,
  });

  @override
  State<SongwriterPage> createState() => _SongwriterPageState();
}

class _SongwriterPageState extends State<SongwriterPage> {
  final titleController = TextEditingController();
  final genreController = TextEditingController();
  final moodController = TextEditingController();
  final keywordsController = TextEditingController();
  final lyricsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final project = widget.project;

    if (project != null) {
      titleController.text = project.title;
      genreController.text = project.genre;
      moodController.text = project.mood;
      lyricsController.text = project.lyrics;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    genreController.dispose();
    moodController.dispose();
    keywordsController.dispose();
    lyricsController.dispose();
    super.dispose();
  }

  void generateDemoText() {
    final title = titleController.text.trim().isEmpty
        ? 'Midnight Song'
        : titleController.text.trim();

    final mood = moodController.text.trim().isEmpty
        ? 'dunkel und emotional'
        : moodController.text.trim();

    final keywords = keywordsController.text.trim().isEmpty
        ? 'Nacht, Licht, Herz'
        : keywordsController.text.trim();

    setState(() {
      lyricsController.text =
          'Titel: $title\n\n'
          'Verse 1:\n'
          'Ich lauf durch die Nacht, $mood im Blick,\n'
          'aus alten Gedanken entsteht neues Glück.\n'
          'Zwischen $keywords such ich meinen Klang,\n'
          'und jede Zeile zieht mich weiter voran.\n\n'
          'Hook:\n'
          '$title, ich dreh die Welt laut,\n'
          'bau mir aus Träumen einen Sound aus Gold und Haut.\n'
          '$title, die Nacht wird mein Licht,\n'
          'Midnight Studio, und der Beat vergisst mich nicht.';
    });
  }

  Future<void> saveSongwriterData() async {
    final currentProject = widget.project;

    if (currentProject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Kein Projekt ausgewählt.'),
        ),
      );
      return;
    }

    final updatedProject = currentProject.copyWith(
      title: titleController.text.trim().isEmpty
          ? 'Unbenannter Track'
          : titleController.text.trim(),
      genre: genreController.text.trim(),
      mood: moodController.text.trim(),
      lyrics: lyricsController.text.trim(),
    );

    await ProjectController.updateProject(updatedProject);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Songwriter-Daten gespeichert.'),
      ),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final hasProject = widget.project != null;

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
                  title: 'Songwriter',
                  subtitle: 'Ideen, Stimmungen und Songtexte entwickeln.',
                  icon: Icons.edit_note_rounded,
                  showBackButton: true,
                ),

                const SizedBox(height: 24),

                if (!hasProject)
                  const GlassCard(
                    child: Text(
                      'Hinweis: Öffne den Songwriter am besten über ein Projekt, damit deine Texte gespeichert werden können.',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ),

                if (!hasProject) const SizedBox(height: 18),

                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _InputField(
                        label: 'Songtitel',
                        hint: 'z. B. Night Pulse',
                        controller: titleController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Genre',
                        hint: 'Pop, Hip-Hop, Rock, Singer-Songwriter',
                        controller: genreController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Stimmung',
                        hint: 'dunkel, emotional, kraftvoll',
                        controller: moodController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Schlagwörter',
                        hint: 'Nacht, Herz, Straße, Erinnerung',
                        controller: keywordsController,
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
                        'Textentwurf',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      TextField(
                        controller: lyricsController,
                        maxLines: 12,
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 14,
                          height: 1.45,
                        ),
                        decoration: InputDecoration(
                          hintText: 'Hier erscheint dein Songtext...',
                          hintStyle: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                          filled: true,
                          fillColor: Colors.black.withOpacity(0.22),
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
                            borderSide: const BorderSide(
                              color: AppColors.gold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: generateDemoText,
                        icon: const Icon(Icons.auto_awesome_rounded),
                        label: const Text('Demo-Text generieren'),
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
                        onPressed: hasProject ? saveSongwriterData : null,
                        icon: const Icon(Icons.save_rounded),
                        label: const Text('Im Projekt speichern'),
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
              ],
            ),
          ),
        ),
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
            hintStyle: const TextStyle(
              color: AppColors.textSecondary,
            ),
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
              borderSide: const BorderSide(
                color: AppColors.gold,
              ),
            ),
          ),
        ),
      ],
    );
  }
}