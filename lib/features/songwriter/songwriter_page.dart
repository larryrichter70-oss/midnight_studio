import 'package:flutter/material.dart';

import '../../core/controllers/project_controller.dart';
import '../../core/models/music_project.dart';

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
          'Gefühle so klar wie ein endloser Refrain.\n\n'
          'Verse 2:\n'
          'Die Worte wie Sterne, der Beat wie ein Meer,\n'
          'in deinem Blick liegt das Versprechen von mehr.\n'
          'Wir schreiben Geschichte, so nah und so klar,\n'
          'und jeder Moment wird zur Melodie, die ich wahr.\n\n'
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
      backgroundColor: Colors.black,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF020203),
              Color(0xFF050812),
              Color(0xFF07040D),
              Color(0xFF000000),
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: ListView(
              children: [
                const _SongwriterHeader(),
                const SizedBox(height: 28),

                if (!hasProject)
                  const _StudioHint(
                    text:
                        'Hinweis: Öffne den Songwriter am besten über ein Projekt, damit deine Texte gespeichert werden können.',
                  ),

                if (!hasProject) const SizedBox(height: 22),

                const _SilverMetalText(
                  'SONG INFORMATION',
                  fontSize: 16,
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Songtitel',
                        hint: 'z. B. Night Pulse',
                        controller: titleController,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _InputField(
                        label: 'Genre',
                        hint: 'Pop, Hip-Hop, Rock',
                        controller: genreController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Stimmung',
                        hint: 'dunkel, emotional',
                        controller: moodController,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _InputField(
                        label: 'Sprache',
                        hint: 'Deutsch, Englisch',
                        controller: languageController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                _InputField(
                  label: 'BPM',
                  hint: '92',
                  controller: bpmController,
                ),

                const SizedBox(height: 36),

                const _SilverMetalText(
                  'CREATIVE INPUT',
                  fontSize: 16,
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Schlagwörter',
                        hint: 'Nacht, Herz, Erinnerung',
                        controller: keywordsController,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _InputField(
                        label: 'Songwriting-Ideen',
                        hint: 'Cineastisch, emotional',
                        controller: ideasController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 28),
                const _SilverMetalText(
                  'LYRICS EDITOR',
                  fontSize: 16,
                ),

                const SizedBox(height: 14),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      top: BorderSide(
                        color: const Color(0xFFE8EDF7).withAlpha(45),
                      ),
                      bottom: BorderSide(
                        color: const Color(0xFF8A78FF).withAlpha(45),
                      ),
                    ),
                  ),
                  child: TextField(
                    controller: lyricsController,
                    maxLines: 18,
                    style: const TextStyle(
                      color: Color(0xFFE8EDF7),
                      fontSize: 14,
                      height: 1.55,
                      letterSpacing: 0.2,
                    ),
                    decoration: const InputDecoration(
                      hintText:
                          'Verse 1:\n\nPre-Chorus:\n\nChorus:\n\nVerse 2:\n\nBridge:',
                      hintStyle: TextStyle(
                        color: Color(0xFF7E86A8),
                        height: 1.55,
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),

                const SizedBox(height: 26),

                _StudioActionButton(
                  icon: Icons.auto_awesome_rounded,
                  label: 'Demo-Text generieren',
                  onTap: generateDemoText,
                ),
                const SizedBox(height: 14),
                _StudioActionButton(
                  icon: Icons.save_rounded,
                  label: 'Im Projekt speichern',
                  onTap: saveSongwriterData,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SongwriterHeader extends StatelessWidget {
  const _SongwriterHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _LogoStyleIcon(icon: Icons.edit_note_rounded),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _GoldMetalText(
              'SONGWRITER',
              fontSize: 26,
            ),
            SizedBox(height: 4),
            Text(
              'Ideen, Stimmungen und Songtexte entwickeln',
              style: TextStyle(
                color: Color(0xFF9EA8C8),
                fontSize: 12,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ],
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
    return TextField(
      controller: controller,
      style: const TextStyle(
        color: Color(0xFFE8EDF7),
        fontSize: 14,
      ),
      decoration: _studioInputDecoration(
        label: label,
        hint: hint,
      ),
    );
  }
}

InputDecoration _studioInputDecoration({
  String? label,
  required String hint,
}) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(
      color: Color(0xFFD9E5FF),
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
    ),
    hintText: hint,
    hintStyle: const TextStyle(
      color: Color(0xFF7E86A8),
    ),
    filled: true,
    fillColor: Colors.transparent,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 14,
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0x448A78FF),
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFE8EDF7),
        width: 1.4,
      ),
    ),
  );
}

class _StudioActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _StudioActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            _LogoStyleIcon(icon: icon),
            const SizedBox(width: 14),
            Expanded(
              child: _SilverMetalText(
                label,
                fontSize: 14,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
              color: Color(0xFF7E86A8),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudioHint extends StatelessWidget {
  final String text;

  const _StudioHint({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF9EA8C8),
          fontSize: 13,
          height: 1.4,
        ),
      ),
    );
  }
}

class _LogoStyleIcon extends StatelessWidget {
  final IconData icon;

  const _LogoStyleIcon({required this.icon});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF63E7FF).withAlpha(45),
                blurRadius: 18,
              ),
              BoxShadow(
                color: const Color(0xFFFF7CE6).withAlpha(35),
                blurRadius: 18,
              ),
            ],
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) {
            return const LinearGradient(
              colors: [
                Color(0xFF63E7FF),
                Color(0xFFE8EDF7),
                Color(0xFF8A78FF),
                Color(0xFFFF7CE6),
              ],
            ).createShader(bounds);
          },
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }
}

class _GoldMetalText extends StatelessWidget {
  final String text;
  final double fontSize;

  const _GoldMetalText(
    this.text, {
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFFFF2B6),
            Color(0xFFFFC64B),
            Color(0xFF8C4F09),
            Color(0xFFE8EDF7),
          ],
          stops: [0.0, 0.18, 0.45, 0.72, 1.0],
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w900,
          letterSpacing: 1.4,
          shadows: const [
            Shadow(
              color: Color(0xBBFFB000),
              blurRadius: 18,
            ),
            Shadow(
              color: Color(0x88000000),
              blurRadius: 8,
              offset: Offset(2, 3),
            ),
          ],
        ),
      ),
    );
  }
}

class _SilverMetalText extends StatelessWidget {
  final String text;
  final double fontSize;

  const _SilverMetalText(
    this.text, {
    required this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFFFFFFF),
            Color(0xFFD9E5FF),
            Color(0xFFB8C4E8),
            Color(0xFF8A78FF),
          ],
        ).createShader(bounds);
      },
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
          shadows: const [
            Shadow(
              color: Color(0x668A78FF),
              blurRadius: 12,
            ),
            Shadow(
              color: Color(0x33FFFFFF),
              blurRadius: 4,
              offset: Offset(-1, -1),
            ),
          ],
        ),
      ),
    );
  }
}