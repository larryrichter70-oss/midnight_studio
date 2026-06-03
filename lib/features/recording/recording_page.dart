import 'package:flutter/material.dart';
import '../../core/controllers/project_controller.dart';
import '../../core/models/music_project.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/midnight_header.dart';

class RecordingPage extends StatefulWidget {
  final MusicProject? project;

  const RecordingPage({
    super.key,
    this.project,
  });

  @override
  State<RecordingPage> createState() => _RecordingPageState();
}

class _RecordingPageState extends State<RecordingPage> {
  final recordingNameController = TextEditingController();
  final recordingDurationController = TextEditingController();
  final recordingStatusController = TextEditingController();
  final recordingNotesController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final project = widget.project;

    if (project != null) {
      recordingNameController.text = project.recordingName;
      recordingDurationController.text = project.recordingDuration;
      recordingStatusController.text = project.recordingStatus;
      recordingNotesController.text = project.recordingNotes;
    }
  }

  @override
  void dispose() {
    recordingNameController.dispose();
    recordingDurationController.dispose();
    recordingStatusController.dispose();
    recordingNotesController.dispose();
    super.dispose();
  }

  Future<void> saveRecordingData() async {
    final currentProject = widget.project;

    if (currentProject == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kein Projekt ausgewählt.')),
      );
      return;
    }

    final updatedProject = currentProject.copyWith(
      recordingName: recordingNameController.text.trim(),
      recordingDuration: recordingDurationController.text.trim(),
      recordingStatus: recordingStatusController.text.trim(),
      recordingNotes: recordingNotesController.text.trim(),
    );

    await ProjectController.updateProject(updatedProject);

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recording-Daten gespeichert.')),
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
                  title: 'Aufnahme',
                  subtitle: 'Stimme aufnehmen, kontrollieren und vorbereiten.',
                  icon: Icons.mic_rounded,
                  showBackButton: true,
                ),

                const SizedBox(height: 24),

                if (!hasProject)
                  const GlassCard(
                    child: Text(
                      'Hinweis: Öffne Aufnahme am besten über ein Projekt, damit deine Recording-Daten gespeichert werden können.',
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),

                if (!hasProject) const SizedBox(height: 18),

                const _RecordControlCard(),

                const SizedBox(height: 18),

                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Recording Daten',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Take Name',
                        hint: 'z. B. Hook Vocal',
                        controller: recordingNameController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Dauer',
                        hint: 'z. B. 00:42',
                        controller: recordingDurationController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Status',
                        hint: 'Entwurf, Gut, Final',
                        controller: recordingStatusController,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        label: 'Notizen',
                        hint: 'z. B. zweite Hook klingt besser',
                        controller: recordingNotesController,
                        maxLines: 3,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: hasProject ? saveRecordingData : null,
                    icon: const Icon(Icons.save_rounded),
                    label: const Text('Recording im Projekt speichern'),
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

                const _VocalSettingsCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecordControlCard extends StatelessWidget {
  const _RecordControlCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          const Text(
            'Vocal Recording',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Bereit für Take 01',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            width: 118,
            height: 118,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withOpacity(0.16),
              border: Border.all(
                color: AppColors.gold.withOpacity(0.65),
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withOpacity(0.25),
                  blurRadius: 35,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: const Icon(
              Icons.mic_rounded,
              color: AppColors.gold,
              size: 58,
            ),
          ),
          const SizedBox(height: 22),
          const Text(
            '00:00:00',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.silver,
            ),
          ),
        ],
      ),
    );
  }
}

class _VocalSettingsCard extends StatelessWidget {
  const _VocalSettingsCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Vocal Control',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          _FakeSlider(label: 'Input Gain', value: 0.72),
          SizedBox(height: 14),
          _FakeSlider(label: 'Pitch', value: 0.46),
          SizedBox(height: 14),
          _FakeSlider(label: 'Reverb', value: 0.38),
          SizedBox(height: 14),
          _FakeSlider(label: 'Monitoring', value: 0.62),
        ],
      ),
    );
  }
}

class _FakeSlider extends StatelessWidget {
  final String label;
  final double value;

  const _FakeSlider({
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
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: LinearProgressIndicator(
            value: value,
            minHeight: 8,
            backgroundColor: Colors.white10,
            color: AppColors.gold,
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