import 'package:flutter/material.dart';
import '../../core/controllers/project_controller.dart';
import '../../core/models/music_project.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/midnight_header.dart';

class BeatsPage extends StatefulWidget {
  final MusicProject? project;

  const BeatsPage({
    super.key,
    this.project,
  });

  @override
  State<BeatsPage> createState() => _BeatsPageState();
}

class _BeatsPageState extends State<BeatsPage> {
  final beatGenreController = TextEditingController();
  final beatBpmController = TextEditingController();
  final beatMoodController = TextEditingController();
  final beatInstrumentsController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final project = widget.project;

    if (project != null) {
      beatGenreController.text = project.beatGenre;
      beatBpmController.text = project.beatBpm;
      beatMoodController.text = project.beatMood;
      beatInstrumentsController.text = project.beatInstruments;
    }
  }

  @override
  void dispose() {
    beatGenreController.dispose();
    beatBpmController.dispose();
    beatMoodController.dispose();
    beatInstrumentsController.dispose();
    super.dispose();
  }

  Future<void> saveBeatData() async {
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
      beatGenre: beatGenreController.text.trim(),
      beatBpm: beatBpmController.text.trim(),
      beatMood: beatMoodController.text.trim(),
      beatInstruments: beatInstrumentsController.text.trim(),
    );

    await ProjectController.updateProject(updatedProject);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Beat-Daten gespeichert.'),
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
                  title: 'Beats',
                  subtitle: 'Genre, BPM, Stimmung und Sound formen.',
                  icon: Icons.music_note_rounded,
                  showBackButton: true,
                ),

                const SizedBox(height: 24),

                if (!hasProject)
                  const GlassCard(
                    child: Text(
                      'Hinweis: Öffne Beats am besten über ein Projekt, damit deine Beat-Daten gespeichert werden können.',
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
                      const Text(
                        'Beat Einstellungen',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Genre',
                        hint: 'Dark Pop / Hip-Hop',
                        controller: beatGenreController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'BPM',
                        hint: '92',
                        controller: beatBpmController,
                        keyboardType: TextInputType.number,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Stimmung',
                        hint: 'Dunkel · emotional',
                        controller: beatMoodController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Instrumente',
                        hint: 'Piano · 808 · Pads',
                        controller: beatInstrumentsController,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                const _WavePreviewCard(),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: hasProject ? saveBeatData : null,
                    icon: const Icon(Icons.save_rounded),
                    label: const Text('Beat im Projekt speichern'),
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

                const _BeatListCard(),
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
  final TextInputType? keyboardType;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    this.keyboardType,
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
          keyboardType: keyboardType,
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

class _WavePreviewCard extends StatelessWidget {
  const _WavePreviewCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Beat Vorschau',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 70,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                24,
                (index) {
                  final height = 18 + ((index * 17) % 48).toDouble();

                  return Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Container(
                        height: height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(999),
                          gradient: const LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              AppColors.neonPurple,
                              AppColors.gold,
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BeatListCard extends StatelessWidget {
  const _BeatListCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Demo Beats',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 14),
          _BeatItem(title: 'Midnight Pulse', bpm: '92 BPM', tag: 'Dark Pop'),
          SizedBox(height: 10),
          _BeatItem(title: 'Golden Shadows', bpm: '84 BPM', tag: 'Emotional'),
          SizedBox(height: 10),
          _BeatItem(title: 'Neon Heartbeat', bpm: '104 BPM', tag: 'Synth Pop'),
        ],
      ),
    );
  }
}

class _BeatItem extends StatelessWidget {
  final String title;
  final String bpm;
  final String tag;

  const _BeatItem({
    required this.title,
    required this.bpm,
    required this.tag,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black.withOpacity(0.22),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.18),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.music_note_rounded,
            color: AppColors.gold,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$title • $bpm • $tag',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}