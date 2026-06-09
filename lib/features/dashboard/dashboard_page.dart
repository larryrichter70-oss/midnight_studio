import 'package:flutter/material.dart';

import '../../core/controllers/project_controller.dart';
import '../../core/models/music_project.dart';
import '../../core/theme/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topCenter,
            radius: 1.3,
            colors: [
              AppColors.deepPurple,
              AppColors.midnightBlue,
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth >= 900;
              return Padding(
                padding: const EdgeInsets.all(18),
                child: isWide
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: const [
                          SizedBox(width: 260, child: _Sidebar()),
                          SizedBox(width: 18),
                          Expanded(child: _StudioWorkspace(isWide: true)),
                          SizedBox(width: 18),
                          SizedBox(width: 320, child: _RightPanel()),
                        ],
                      )
                    : SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(minWidth: constraints.maxWidth),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: const [
                              _Sidebar(),
                              SizedBox(height: 18),
                              _StudioWorkspace(isWide: false),
                              SizedBox(height: 18),
                              _RightPanel(),
                            ],
                          ),
                        ),
                      ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.fromLTRB(20, 28, 20, 24),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.gold, AppColors.neonPurple],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(Icons.graphic_eq_rounded, color: AppColors.background, size: 32),
                ),
                const SizedBox(height: 14),
                const Text(
                  'MIDNIGHT',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2.0,
                  ),
                ),
                const Text(
                  'Studio',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 26),
            const Divider(color: Colors.white12, height: 1),
            const SizedBox(height: 22),
            const _NavItem(icon: Icons.dashboard_customize_rounded, label: 'Dashboard', isActive: true),
            const _NavItem(icon: Icons.mic_rounded, label: 'Studio'),
            const _NavItem(icon: Icons.folder_open_rounded, label: 'Projekte'),
            const _NavItem(icon: Icons.upload_file_rounded, label: 'Export'),
            const _NavItem(icon: Icons.settings_rounded, label: 'Settings'),
          ],
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;

  const _NavItem({
    required this.icon,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Icon(icon, size: 22, color: isActive ? AppColors.gold : AppColors.textSecondary),
          const SizedBox(width: 14),
          Text(
            label,
            style: TextStyle(
              color: isActive ? AppColors.textPrimary : AppColors.textSecondary,
              fontSize: 15,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _StudioWorkspace extends StatelessWidget {
  final bool isWide;

  const _StudioWorkspace({required this.isWide});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<List<MusicProject>>(
      valueListenable: ProjectController.projects,
      builder: (context, projects, child) {
        final activeProject = projects.isNotEmpty ? projects.first : _demoProject;
        final projectItems = projects.isNotEmpty ? projects : [_demoProject];

        final activeProjectTitle = activeProject.title.isNotEmpty ? activeProject.title : 'Untitled Projekt';
        final activeProjectMood = activeProject.mood.isNotEmpty ? activeProject.mood : 'Demo Track';
        final activeProjectGenre = activeProject.genre.isNotEmpty ? activeProject.genre : '';
        final activeProjectGenreMood = activeProjectGenre.isNotEmpty
            ? '$activeProjectGenre · $activeProjectMood'
            : activeProjectMood;
        final activeProjectTempo = activeProject.beatBpm.isNotEmpty ? '${activeProject.beatBpm} BPM' : '92 BPM';

        return Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Projekt Header kompakt
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            activeProjectTitle,
                            style: const TextStyle(
                              color: AppColors.gold,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            activeProjectGenreMood,
                            style: const TextStyle(
                              color: AppColors.textSecondary,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _StatusChip(label: 'LIVE', color: AppColors.gold),
                  ],
                ),
                const SizedBox(height: 14),
                // Transport Controls
                Row(
                  children: [
                    _TransportButton(icon: Icons.play_arrow_rounded, label: 'Play'),
                    const SizedBox(width: 10),
                    _TransportButton(icon: Icons.pause_rounded, label: 'Pause'),
                    const SizedBox(width: 10),
                    _TransportButton(icon: Icons.stop_rounded, label: 'Stop'),
                    const Spacer(),
                    _StatusChip(label: '01:34 / 03:42', color: AppColors.textSecondary),
                  ],
                ),
                const SizedBox(height: 16),
                // GROSSE WAVEFORM - das zentrale Element (50% der verfügbaren Höhe)
                Flexible(
                  fit: FlexFit.loose,
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.midnightBlue,
                      borderRadius: BorderRadius.circular(26),
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Waveform',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                letterSpacing: 1.6,
                              ),
                            ),
                            Text(
                              'Arrangement',
                              style: TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                letterSpacing: 1.6,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 14),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(22),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: List.generate(48, (index) {
                                final height = 32.0 + (index % 9) * 10.0 + (index.isEven ? 10.0 : 0.0);
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 1),
                                    child: Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        height: height,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(999),
                                          gradient: LinearGradient(
                                            colors: [
                                              AppColors.neonPurple.withAlpha(220),
                                              AppColors.gold.withAlpha(200),
                                            ],
                                            begin: Alignment.bottomCenter,
                                            end: Alignment.topCenter,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _MiniInfo(label: 'Tempo', value: activeProjectTempo),
                            _MiniInfo(label: 'Tracks', value: '08'),
                            _MiniInfo(label: 'Status', value: activeProject.recordingStatus.isNotEmpty ? activeProject.recordingStatus : 'Ready'),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                // Trackliste darunter (50% der verfügbaren Höhe)
                Flexible(
                  fit: FlexFit.loose,
                  child: _ProjectListView(projects: projectItems),
                ),
              ],
            ),
          ),
        );

      },
    );
  }
}

class _ProjectListView extends StatelessWidget {
  final List<MusicProject> projects;

  const _ProjectListView({required this.projects});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.midnightBlue,
        borderRadius: BorderRadius.circular(26),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Trackliste',
            style: TextStyle(
              color: AppColors.textPrimary,
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: projects.length,
              separatorBuilder: (context, index) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                return _TrackRow(project: projects[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _TrackRow extends StatelessWidget {
  final MusicProject project;

  const _TrackRow({required this.project});

  @override
  Widget build(BuildContext context) {
    final progress = _projectProgress(project);
    return Container(
      height: 130,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.midnightBlue,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.deepPurple, AppColors.neonPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(18),
            ),
            child: const Icon(Icons.music_note_rounded, color: AppColors.gold, size: 28),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  project.title.isNotEmpty ? project.title : 'Untitled Track',
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  project.genre.isNotEmpty
                      ? '${project.genre} · ${project.mood.isNotEmpty ? project.mood : 'Unbekannt'}'
                      : 'Night Pulse · Demo Track',
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.white10,
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Text(
                        project.recordingStatus.isNotEmpty ? project.recordingStatus : 'Ready',
                        style: const TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: LinearProgressIndicator(
                          value: progress,
                          minHeight: 6,
                          backgroundColor: Colors.white10,
                          valueColor: const AlwaysStoppedAnimation(AppColors.gold),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '${(progress * 100).round()}%',
                      style: const TextStyle(
                        color: AppColors.gold,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          SizedBox(
            width: 100,
            height: 98,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.background,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: List.generate(
                        6,
                        (index) => Expanded(
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 1.5),
                            height: 8.0 + (index % 3) * 10.0 + (index.isEven ? 6.0 : 0.0),
                            decoration: BoxDecoration(
                              color: AppColors.gold.withAlpha(200),
                              borderRadius: BorderRadius.circular(99),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Track',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
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


class _RightPanel extends StatelessWidget {
  const _RightPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(28),
      ),
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Recent Clips',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            const _RecentCard(
              icon: Icons.mic_rounded,
              title: 'Letzte Aufnahme',
              description: 'Lead Vocals aufgenommen',
              timestamp: 'vor 8 Min.',
            ),
            const SizedBox(height: 12),
            const _RecentCard(
              icon: Icons.audiotrack_rounded,
              title: 'Letzter Beat',
              description: 'Synthwave Loop erstellt',
              timestamp: 'vor 23 Min.',
            ),
            const SizedBox(height: 12),
            const _RecentCard(
              icon: Icons.upload_file_rounded,
              title: 'Letzter Export',
              description: 'Mastered WAV ready',
              timestamp: 'vor 1 Std.',
            ),
            const SizedBox(height: 24),
            const Text(
              'Quick Actions',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 14),
            _QuickActionButton(icon: Icons.mic_none_rounded, label: 'Aufnehmen'),
            const SizedBox(height: 12),
            _QuickActionButton(icon: Icons.equalizer_rounded, label: 'Mixer'),
            const SizedBox(height: 12),
            _QuickActionButton(icon: Icons.cloud_upload_rounded, label: 'Export'),
          ],
        ),
      ),
    );
  }
}

class _RecentCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String timestamp;

  const _RecentCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.midnightBlue,
        borderRadius: BorderRadius.circular(22),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.deepPurple,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: AppColors.gold, size: 22),
          ),
          const SizedBox(width: 14),
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
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Text(
            timestamp,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }
}

class _TransportButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _TransportButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: AppColors.midnightBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 18),
          const SizedBox(width: 10),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;

  const _QuickActionButton({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.midnightBlue,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.gold, size: 18),
          const SizedBox(width: 12),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _MiniInfo extends StatelessWidget {
  final String label;
  final String value;

  const _MiniInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 11,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String label;
  final Color color;

  const _StatusChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 14),
      decoration: BoxDecoration(
        color: color.withAlpha(36),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

final MusicProject _demoProject = MusicProject(
  id: 'demo-001',
  title: 'Night Pulse',
  genre: 'Dark Pop',
  mood: 'Mystisch',
  lyrics: 'Verse, Chorus, Bridge',
  beatGenre: 'Synthwave',
  beatBpm: '92',
  beatMood: 'Atmosphärisch',
  beatInstruments: 'Synth, Bass, Drums',
  recordingName: 'Vocals & Pads',
  recordingDuration: '3:42',
  recordingStatus: 'Bereit',
  recordingNotes: 'Lead vocals aufgenommen',
  mixStatus: 'In Arbeit',
  mixMastering: 'Vorbereitung',
  mixNotes: 'Reverb und EQ anpassen',
  createdAt: DateTime(2025, 1, 1),
);

double _projectProgress(MusicProject project) {
  final checks = <bool>[
    project.lyrics.isNotEmpty,
    project.beatGenre.isNotEmpty || project.beatBpm.isNotEmpty || project.beatInstruments.isNotEmpty,
    project.recordingName.isNotEmpty || project.recordingStatus.isNotEmpty,
    project.mixStatus.isNotEmpty || project.mixMastering.isNotEmpty,
  ];
  return checks.where((value) => value).length / checks.length;
}
