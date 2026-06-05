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
  final languageController = TextEditingController();
  final bpmController = TextEditingController();
  final keywordsController = TextEditingController();
  final ideasController = TextEditingController();
  final lyricsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final project = widget.project;

    if (project != null) {
      titleController.text = project.title;
      genreController.text = project.genre;
      moodController.text = project.mood;
      bpmController.text = project.beatBpm;
      lyricsController.text = project.lyrics;
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    genreController.dispose();
    moodController.dispose();
    languageController.dispose();
    bpmController.dispose();
    keywordsController.dispose();
    ideasController.dispose();
    lyricsController.dispose();
    super.dispose();
  }

  void generateDemoText() {
    final title = titleController.text.trim().isEmpty
        ? 'Midnight Song'
        : titleController.text.trim();

    final genre = genreController.text.trim().isEmpty
        ? 'Pop'
        : genreController.text.trim();

    final mood = moodController.text.trim().isEmpty
        ? 'dunkel und emotional'
        : moodController.text.trim();

    final language = languageController.text.trim().isEmpty
        ? 'Deutsch'
        : languageController.text.trim();

    final bpm = bpmController.text.trim().isEmpty
        ? '92'
        : bpmController.text.trim();

    final keywords = keywordsController.text.trim().isEmpty
        ? 'Nacht, Licht, Herz'
        : keywordsController.text.trim();

    final ideas = ideasController.text.trim().isEmpty
        ? 'Melancholischer Beat, eingängiger Refrain, cineastische Atmosphäre'
        : ideasController.text.trim();

    setState(() {
      lyricsController.text =
          'Titel: $title\n'
          'Genre: $genre\n'
          'Stimmung: $mood\n'
          'Sprache: $language\n'
          'BPM: $bpm\n'
          'Schlagwörter: $keywords\n'
          'Songwriting-Ideen: $ideas\n\n'
          'Verse 1:\n'
          'Im Schatten der Laternen, die Stadt schläft noch nicht,\n'
          'dein Echo im Kopf, ein Gefühl, das mich bricht.\n'
          'Zwischen Neon und Sehnsucht such ich mein Licht,\n'
          'und jeder Atemzug bleibt ein Versprechen an dich.\n\n'
          'Pre-Chorus:\n'
          'Die Melodie zieht uns leise in den Morgen,\n'
          'wir tragen den Moment, lassen Sorgen verborgen.\n\n'
          'Chorus:\n'
          'Denn wir sind das Licht in der Nacht,\n'
          '$title nimmt uns mit auf die Fahrt.\n'
          'Herz schlägt im Takt, $bpm BPM,\n'
          'Gefühle so klar wie ein endloser Hymnen-Refrain.\n\n'
          'Verse 2:\n'
          'Die Worte wie Sterne, der Beat wie ein Meer,\n'
          'in deinem Blick liegt das Versprechen von mehr.\n'
          'Wir schreiben Geschichte, so nah und so klar,\n'
          'und jedes Motiv wird zur Melodie, die ich wahr.\n\n'
          'Bridge:\n'
          'Hier in der Stille zwischen den Takten,\n'
          'wird aus Erinnerung ein neuer Klang erwacht.\n'
          'Wir halten das Jetzt, lassen die Zeit sich verlieren,\n'
          'und die Nacht wird zum Lied, das uns nie verliert.\n';
    });
  }

  Future<void> saveSongwriterData() async {
    final title = titleController.text.trim().isEmpty
        ? 'Unbenannter Track'
        : titleController.text.trim();
    final genre = genreController.text.trim();
    final mood = moodController.text.trim();
    final bpm = bpmController.text.trim();
    final lyrics = lyricsController.text.trim();

    final currentProject = widget.project;

    if (currentProject == null) {
      final newProject = MusicProject(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        genre: genre,
        mood: mood,
        lyrics: lyrics,
        beatBpm: bpm,
        createdAt: DateTime.now(),
      );

      await ProjectController.addProject(newProject);
    } else {
      final updatedProject = currentProject.copyWith(
        title: title,
        genre: genre,
        mood: mood,
        lyrics: lyrics,
        beatBpm: bpm,
      );

      await ProjectController.updateProject(updatedProject);
    }

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
                        label: 'Sprache',
                        hint: 'Deutsch, Englisch, Spanisch',
                        controller: languageController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'BPM',
                        hint: 'z. B. 92',
                        controller: bpmController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Schlagwörter',
                        hint: 'Nacht, Herz, Straße, Erinnerung',
                        controller: keywordsController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Songwriting-Ideen',
                        hint: 'z. B. Melancholisch, cineastisch, hookig',
                        controller: ideasController,
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
                        onPressed: saveSongwriterData,
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