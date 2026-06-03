import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/midnight_header.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

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
                  title: 'Midnight Studio',
                  subtitle: 'Deine kreative Musik-Zentrale.',
                  icon: Icons.graphic_eq_rounded,
                ),
                SizedBox(height: 28),
                FeaturedProjectCard(),
                SizedBox(height: 18),
                LastActivityCard(),
                SizedBox(height: 18),
                StudioStatsCard(),
                SizedBox(height: 18),
                LastExportCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FeaturedProjectCard extends StatelessWidget {
  const FeaturedProjectCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 145,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.neonPurple,
                  AppColors.midnightBlue,
                  AppColors.gold,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.neonPurple.withOpacity(0.35),
                  blurRadius: 28,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Stack(
              children: [
                Positioned(
                  right: 18,
                  top: 18,
                  child: Icon(
                    Icons.graphic_eq_rounded,
                    size: 72,
                    color: Colors.black.withOpacity(0.35),
                  ),
                ),
                const Positioned(
                  left: 18,
                  bottom: 18,
                  child: Text(
                    'Night Pulse',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            'Aktuelles Projekt',
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 6),
          const Text(
            'Text fertig · Beat gewählt · Aufnahme offen',
            style: TextStyle(
              fontSize: 13,
              color: AppColors.silver,
            ),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: 0.58,
              minHeight: 8,
              backgroundColor: Colors.white10,
              color: AppColors.gold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            '58 % abgeschlossen',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

class LastActivityCard extends StatelessWidget {
  const LastActivityCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Letzte Aktivität',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 14),
          ActivityItem(
            icon: Icons.edit_note_rounded,
            title: 'Songtext bearbeitet',
            subtitle: 'vor wenigen Minuten',
          ),
          SizedBox(height: 10),
          ActivityItem(
            icon: Icons.music_note_rounded,
            title: 'Beat-Vorschau erstellt',
            subtitle: 'Demo · 92 BPM',
          ),
          SizedBox(height: 10),
          ActivityItem(
            icon: Icons.mic_rounded,
            title: 'Vocal Take vorbereitet',
            subtitle: 'Take 01 wartet',
          ),
        ],
      ),
    );
  }
}

class ActivityItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const ActivityItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.gold, size: 24),
        const SizedBox(width: 12),
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
              const SizedBox(height: 2),
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
      ],
    );
  }
}

class StudioStatsCard extends StatelessWidget {
  const StudioStatsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Studio Übersicht',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: _StatItem(value: '3', label: 'Projekte')),
              Expanded(child: _StatItem(value: '7', label: 'Texte')),
              Expanded(child: _StatItem(value: '2', label: 'Mixes')),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String value;
  final String label;

  const _StatItem({
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            fontSize: 26,
            fontWeight: FontWeight.bold,
            color: AppColors.gold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}

class LastExportCard extends StatelessWidget {
  const LastExportCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          const Icon(
            Icons.file_download_done_rounded,
            size: 46,
            color: AppColors.gold,
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Letzter Export',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'night_pulse_demo.mp3',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 18,
            color: AppColors.silver,
          ),
        ],
      ),
    );
  }
}