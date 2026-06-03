import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/widgets/glass_card.dart';
import '../../core/widgets/midnight_header.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

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
                  title: 'Settings',
                  subtitle: 'Audio, Export, Design und Studio-Optionen.',
                  icon: Icons.settings_rounded,
                ),

                SizedBox(height: 24),

                SettingsGroup(
                  title: 'Audio',
                  items: [
                    SettingsItem(
                      icon: Icons.volume_up_rounded,
                      title: 'Audioqualität',
                      subtitle: 'High Quality · 320 kbps',
                      accent: AppColors.gold,
                    ),
                    SettingsItem(
                      icon: Icons.mic_rounded,
                      title: 'Mikrofon',
                      subtitle: 'Standard-Gerät verwenden',
                      accent: AppColors.neonPurple,
                    ),
                  ],
                ),

                SizedBox(height: 18),

                SettingsGroup(
                  title: 'Export',
                  items: [
                    SettingsItem(
                      icon: Icons.file_download_rounded,
                      title: 'Exportformat',
                      subtitle: 'MP3 / WAV vorbereitet',
                      accent: AppColors.neonBlue,
                    ),
                    SettingsItem(
                      icon: Icons.folder_rounded,
                      title: 'Speicherort',
                      subtitle: 'Projektordner',
                      accent: AppColors.gold,
                    ),
                  ],
                ),

                SizedBox(height: 18),

                SettingsGroup(
                  title: 'Design',
                  items: [
                    SettingsItem(
                      icon: Icons.dark_mode_rounded,
                      title: 'Midnight Theme',
                      subtitle: 'Gold · Lila · Mitternachtsblau',
                      accent: AppColors.gold,
                    ),
                    SettingsItem(
                      icon: Icons.auto_awesome_rounded,
                      title: 'Glow Effekte',
                      subtitle: 'Aktiviert',
                      accent: AppColors.neonPurple,
                    ),
                  ],
                ),

                SizedBox(height: 18),

                AppInfoCard(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SettingsGroup extends StatelessWidget {
  final String title;
  final List<SettingsItem> items;

  const SettingsGroup({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 14),
          ...items,
        ],
      ),
    );
  }
}

class SettingsItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;

  const SettingsItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.black.withOpacity(0.22),
        border: Border.all(
          color: accent.withOpacity(0.28),
        ),
        boxShadow: [
          BoxShadow(
            color: accent.withOpacity(0.10),
            blurRadius: 18,
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: accent),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 16,
            color: AppColors.silver,
          ),
        ],
      ),
    );
  }
}

class AppInfoCard extends StatelessWidget {
  const AppInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [
                  AppColors.gold,
                  AppColors.neonPurple,
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.gold.withOpacity(0.26),
                  blurRadius: 24,
                ),
              ],
            ),
            child: const Icon(
              Icons.graphic_eq_rounded,
              color: Colors.black,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Midnight Studio',
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Prototype Build · v0.1',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}