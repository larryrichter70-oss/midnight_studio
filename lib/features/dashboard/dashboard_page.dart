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
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/ms_logo.png',
                    width: 140,
                    height: 140,
                    fit: BoxFit.contain,
                  ),
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
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xFF0E1324),
                          Color(0xFF121A35),
                          Color(0xFF17132D),
                        ],
                      ),
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
                              borderRadius: BorderRadius.circular(22),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color(0xFF07111F),
                                  Color(0xFF10172F),
                                  Color(0xFF17102A),
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFF7A6CFF).withAlpha(70),
                                  blurRadius: 34,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(18),
                            child: CustomPaint(
                              painter: _RealisticWaveformPainter(),
                              size: Size.infinite,
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
    // "Letzte Projekte" Bereich unter der großen Waveform
    final demoProjects = [
      {'title': 'Night Pulse', 'genreBpm': 'Dark Pop · 92 BPM', 'duration': '3:42'},
      {'title': 'Neon Lights', 'genreBpm': 'Synthwave · 110 BPM', 'duration': '4:10'},
      {'title': 'Lost In Space', 'genreBpm': 'Ambient · 78 BPM', 'duration': '5:01'},
      {'title': 'Eternal Night', 'genreBpm': 'Dark Pop · 96 BPM', 'duration': '3:58'},
    ];

    // Use a ListView to avoid vertical overflow and allow scrolling
    return ListView.separated(
      padding: const EdgeInsets.only(top: 4),
      itemCount: demoProjects.length + 1, // header + items
      separatorBuilder: (context, index) {
        if (index == 0) return const SizedBox.shrink();
        return const Divider(color: Colors.white10, height: 1);
      },
      itemBuilder: (context, index) {
        if (index == 0) {
          return const Padding(
            padding: EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              'Letzte Projekte',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }

        final p = demoProjects[index - 1];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          child: Column(
            children: [
              _RecentProjectRow(
                title: p['title']!,
                genreBpm: p['genreBpm']!,
                duration: p['duration']!,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _RecentProjectRow extends StatelessWidget {
  final String title;
  final String genreBpm;
  final String duration;

  const _RecentProjectRow({required this.title, required this.genreBpm, required this.duration});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          // kleines Cover
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.deepPurple, AppColors.neonPurple],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(width: 12),
          // Titel + Genre/BPM
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  genreBpm,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          // kleine Waveform (mini)
          SizedBox(
            width: 120,
            height: 36,
            child: Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: List.generate(
                  20,
                  (i) {
                    final h = 6.0 + (i % 5) * 4.0;
                    return Expanded(
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 1),
                        height: h,
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          // Dauer
          SizedBox(
            width: 56,
            child: Text(
              duration,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
              textAlign: TextAlign.right,
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

class _RealisticWaveformPainter extends CustomPainter {
  const _RealisticWaveformPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;

    final glowPaint = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(
        BlurStyle.normal,
        10,
      )
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF76F3FF),
          Color(0xFF786CFF),
          Color(0xFFFF66E5),
        ],
      ).createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    final linePaint = Paint()
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [
          Color(0xFFBFF6FF),
          Color(0xFF9A8CFF),
          Color(0xFFFF8CEF),
        ],
      ).createShader(
        Rect.fromLTWH(0, 0, size.width, size.height),
      );

    final randomHeights = <double>[
      12,16,18,22,30,42,34,26,18,12,
      10,18,28,44,58,72,64,48,36,22,
      14,20,38,62,88,110,92,70,48,32,
      22,34,58,86,126,148,118,82,54,38,
      26,42,68,98,138,164,130,96,64,42,
      28,46,74,112,152,178,142,104,72,48,
      34,52,80,118,146,128,98,70,52,36,
      24,38,60,88,118,146,122,92,64,44,
      28,42,66,94,124,148,118,84,60,42,
    ];

    final spacing = size.width / randomHeights.length;

    for (int i = 0; i < randomHeights.length; i++) {
      final x = i * spacing;
      final h = randomHeights[i];

      canvas.drawLine(
        Offset(x, centerY - h),
        Offset(x, centerY + h),
        glowPaint,
      );

      canvas.drawLine(
        Offset(x, centerY - h),
        Offset(x, centerY + h),
        linePaint,
      );
    }

    final centerPaint = Paint()
      ..color = Colors.white.withAlpha(25)
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      centerPaint,
    );

    final playheadPaint = Paint()
      ..color = const Color(0xFFEAF9FF)
      ..strokeWidth = 2;

    canvas.drawLine(
      Offset(size.width * 0.35, 10),
      Offset(size.width * 0.35, size.height - 10),
      playheadPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
