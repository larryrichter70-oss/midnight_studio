import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/midnight_header.dart';

class ExportPage extends StatelessWidget {
  const ExportPage({super.key});

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
            child: ListView(
              children: const [
                MidnightHeader(
                  title: 'Export',
                  subtitle: 'Song vorbereiten, finalisieren und ausgeben.',
                  icon: Icons.file_upload_rounded,
                  showBackButton: true,
                ),
                SizedBox(height: 24),
                _ExportPreviewCard(),
                SizedBox(height: 18),
                _ExportSettingsCard(),
                SizedBox(height: 18),
                _ExportActionCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ExportPreviewCard extends StatelessWidget {
  const _ExportPreviewCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Night Pulse',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Finaler Demo-Mix · 03:18 · 92 BPM',
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: 0.86,
              minHeight: 8,
              backgroundColor: Colors.white10,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '86 % vorbereitet',
            style: TextStyle(
              color: AppColors.silver,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExportSettingsCard extends StatelessWidget {
  const _ExportSettingsCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Export Einstellungen',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          _ExportRow(label: 'Format', value: 'MP3'),
          SizedBox(height: 12),
          _ExportRow(label: 'Qualität', value: '320 kbps'),
          SizedBox(height: 12),
          _ExportRow(label: 'Mastering', value: 'Studio Balanced'),
          SizedBox(height: 12),
          _ExportRow(label: 'Dateiname', value: 'night_pulse_final.mp3'),
        ],
      ),
    );
  }
}

class _ExportRow extends StatelessWidget {
  final String label;
  final String value;

  const _ExportRow({
    required this.label,
    required this.value,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.gold,
              fontWeight: FontWeight.bold,
              fontSize: 13,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _ExportActionCard extends StatelessWidget {
  const _ExportActionCard();

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        children: [
          Container(
            width: 78,
            height: 78,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.gold.withOpacity(0.16),
              border: Border.all(
                color: AppColors.gold.withOpacity(0.55),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withOpacity(0.28),
                  blurRadius: 28,
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: AppColors.neonPurple.withOpacity(0.26),
                  blurRadius: 36,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: const Icon(
              Icons.file_download_done_rounded,
              size: 42,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Bereit zum Exportieren',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Später wird hier dein fertiger Song erzeugt.',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: null,
              icon: Icon(Icons.download_rounded),
              label: Text('Export starten'),
            ),
          ),
        ],
      ),
    );
  }
}