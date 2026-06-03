import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/midnight_header.dart';
import '../beats/beats_page.dart';
import '../mixing/mixing_page.dart';
import '../recording/recording_page.dart';
import '../songwriter/songwriter_page.dart';

class StudioPage extends StatelessWidget {
  const StudioPage({super.key});

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
                  title: 'Studio',
                  subtitle: 'Dein kreativer Produktionsbereich.',
                  icon: Icons.auto_awesome_rounded,
                ),
                const SizedBox(height: 26),
                Expanded(
                  child: ListView(
                    children: [
                      StudioActionCard(
                        icon: Icons.edit_note_rounded,
                        title: 'Songwriter',
                        subtitle: 'Ideen, Stichwörter und KI-Texte vorbereiten.',
                        accent: AppColors.neonPurple,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const SongwriterPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      StudioActionCard(
                        icon: Icons.music_note_rounded,
                        title: 'Beats',
                        subtitle: 'Genre, BPM, Stimmung und Demo-Beats auswählen.',
                        accent: AppColors.neonBlue,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const BeatsPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      StudioActionCard(
                        icon: Icons.mic_rounded,
                        title: 'Aufnahme',
                        subtitle: 'Stimme aufnehmen, Monitoring und Vocal-Control.',
                        accent: AppColors.gold,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => RecordingPage(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      StudioActionCard(
                        icon: Icons.tune_rounded,
                        title: 'Mixing',
                        subtitle: 'Spuren, Lautstärke, EQ, Effekte und Master.',
                        accent: AppColors.silver,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const MixingPage(),
                            ),
                          );
                        },
                      ),
                    ],
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

class StudioActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
  final VoidCallback? onTap;

  const StudioActionCard({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(24),
        onTap: onTap,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            color: Colors.white.withOpacity(0.07),
            border: Border.all(
              color: AppColors.gold.withOpacity(0.25),
            ),
            boxShadow: [
              BoxShadow(
                color: accent.withOpacity(0.22),
                blurRadius: 24,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: accent.withOpacity(0.16),
                  border: Border.all(
                    color: accent.withOpacity(0.55),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: accent.withOpacity(0.30),
                      blurRadius: 22,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: Icon(
                  icon,
                  color: accent,
                  size: 30,
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 18,
                color: accent,
              ),
            ],
          ),
        ),
      ),
    );
  }
}