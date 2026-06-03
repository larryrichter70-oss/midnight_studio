import 'package:flutter/material.dart';
import '../../core/controllers/project_controller.dart';
import '../../core/models/music_project.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/midnight_header.dart';
import '../export/export_page.dart';

class MixingPage extends StatefulWidget {
  final MusicProject? project;

  const MixingPage({
    super.key,
    this.project,
  });

  @override
  State<MixingPage> createState() => _MixingPageState();
}

class _MixingPageState extends State<MixingPage> {
  final mixStatusController = TextEditingController();
  final mixMasteringController = TextEditingController();
  final mixNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final project = widget.project;

    if (project != null) {
      mixStatusController.text = project.mixStatus;
      mixMasteringController.text = project.mixMastering;
      mixNotesController.text = project.mixNotes;
    }
  }

  @override
  void dispose() {
    mixStatusController.dispose();
    mixMasteringController.dispose();
    mixNotesController.dispose();
    super.dispose();
  }

  Future<void> saveMixData() async {
    final currentProject = widget.project;

    if (currentProject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kein Projekt ausgewählt.')),
      );
      return;
    }

    final updatedProject = currentProject.copyWith(
      mixStatus: mixStatusController.text.trim(),
      mixMastering: mixMasteringController.text.trim(),
      mixNotes: mixNotesController.text.trim(),
    );

    await ProjectController.updateProject(updatedProject);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Mixing-Daten gespeichert.')),
    );

    Navigator.pop(context);
  }

  void openExport() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const ExportPage(),
      ),
    );
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
                  title: 'Mixing',
                  subtitle: 'Spuren, EQ, Effekte und Master vorbereiten.',
                  icon: Icons.tune_rounded,
                  showBackButton: true,
                ),

                const SizedBox(height: 24),

                if (!hasProject)
                  const GlassCard(
                    child: Text(
                      'Hinweis: Öffne Mixing am besten über ein Projekt, damit deine Mix-Daten gespeichert werden können.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),

                if (!hasProject) const SizedBox(height: 18),

                const _MasterVisualCard(),

                const SizedBox(height: 18),

                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Mixing Daten',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Mix Status',
                        hint: 'z. B. Demo Mix, Final, Rohmix',
                        controller: mixStatusController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Mastering',
                        hint: 'z. B. Studio Balanced',
                        controller: mixMasteringController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Notizen',
                        hint: 'z. B. Vocals etwas lauter, Bass reduzieren',
                        controller: mixNotesController,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: hasProject ? saveMixData : null,
                    icon: const Icon(Icons.save_rounded),
                    label: const Text('Mix im Projekt speichern'),
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
                    onPressed: openExport,
                    icon: const Icon(Icons.file_upload_rounded),
                    label: const Text('Export öffnen'),
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

                const SizedBox(height: 18),

                const _TrackMixerCard(),

                const SizedBox(height: 18),

                const _EqCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _MasterVisualCard extends StatelessWidget {
  const _MasterVisualCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Master Output',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Demo-Mix · 92 BPM',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 22),
          SizedBox(
            height: 72,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: List.generate(
                28,
                (index) {
                  final height = 14 + ((index * 23) % 52).toDouble();
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
                              AppColors.neonBlue,
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

class _TrackMixerCard extends StatelessWidget {
  const _TrackMixerCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Spuren',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          _MixTrack(label: 'Vocal', value: 0.78, icon: Icons.mic_rounded),
          SizedBox(height: 14),
          _MixTrack(label: 'Beat', value: 0.66, icon: Icons.music_note_rounded),
          SizedBox(height: 14),
          _MixTrack(label: 'Bass', value: 0.58, icon: Icons.graphic_eq_rounded),
          SizedBox(height: 14),
          _MixTrack(label: 'Drums', value: 0.72, icon: Icons.album_rounded),
        ],
      ),
    );
  }
}

class _MixTrack extends StatelessWidget {
  final String label;
  final double value;
  final IconData icon;

  const _MixTrack({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.gold, size: 26),
        const SizedBox(width: 12),
        SizedBox(
          width: 58,
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 8,
              backgroundColor: Colors.white10,
              color: AppColors.gold,
            ),
          ),
        ),
      ],
    );
  }
}

class _EqCard extends StatelessWidget {
  const _EqCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Equalizer',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          _EqBand(label: 'Low', value: 0.55),
          SizedBox(height: 14),
          _EqBand(label: 'Mid', value: 0.68),
          SizedBox(height: 14),
          _EqBand(label: 'High', value: 0.48),
        ],
      ),
    );
  }
}

class _EqBand extends StatelessWidget {
  final String label;
  final double value;

  const _EqBand({
    required this.label,
    required this.value,
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
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: Colors.white10,
            color: AppColors.neonPurple,
          ),
        ),
      ],
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController controller;
  final int maxLines;

  const _InputField({
    required this.label,
    required this.hint,
    required this.controller,
    this.maxLines = 1,
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
          maxLines: maxLines,
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