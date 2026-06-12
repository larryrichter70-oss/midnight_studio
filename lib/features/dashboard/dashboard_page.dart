import 'dart:math' as math;
import 'package:flutter/material.dart';

import '../../core/controllers/project_controller.dart';
import '../../core/models/music_project.dart';
import '../../core/theme/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
Widget build(BuildContext context) {
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
        child: LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth >= 900;

            if (!isWide) {
              return SingleChildScrollView(
                padding: const EdgeInsets.all(18),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minWidth: constraints.maxWidth,
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _Sidebar(),
                      SizedBox(height: 18),
                      _StudioWorkspace(isWide: false),
                      SizedBox(height: 18),
                      _RightPanel(),
                    ],
                  ),
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 26,
                vertical: 22,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  SizedBox(
                    width: 260,
                    child: _Sidebar(),
                  ),
                  _FadingDivider(),
                  Expanded(
                    child: _StudioWorkspace(isWide: true),
                  ),
                  _FadingDivider(),
                  SizedBox(
                    width: 320,
                    child: _RightPanel(),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}
}

class _FadingDivider extends StatelessWidget {
  const _FadingDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      margin: const EdgeInsets.symmetric(horizontal: 22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            const Color(0xFFC9C9D6).withAlpha(35),
            const Color(0xFFE8E8F2).withAlpha(80),
            const Color(0xFFC9C9D6).withAlpha(35),
            Colors.transparent,
          ],
          stops: const [0.0, 0.22, 0.5, 0.78, 1.0],
        ),
      ),
    );
  }
}
class _Sidebar extends StatelessWidget {
  const _Sidebar();

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                const SizedBox(height: 18),

                const _GoldMetalText(
                  'MIDNIGHT',
                  fontSize: 24,
                ),

                SizedBox(height: 4),

                Text(
                  'STUDIO',
                  style: TextStyle(
                    color: Color(0xFFE8EDF7),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4,
                  ),
                ),

                SizedBox(height: 10),

                Text(
                  'Creative Music Production',
                  style: TextStyle(
                    color: Color(0xFF9EA8C8),
                    fontSize: 11,
                    letterSpacing: 1.3,
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
      padding: const EdgeInsets.symmetric(vertical: 9),
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
          if (isActive)
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
              color: Color(0xFF7E86A8),
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

       return Padding(
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
                          _GoldMetalText(
                            activeProjectTitle,
                            fontSize: 32,
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
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Container(
                            color: Colors.transparent,    
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

  const _RecentProjectRow({
    required this.title,
    required this.genreBpm,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          const _LogoStyleIcon(icon: Icons.music_note_rounded),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SilverMetalText(title, fontSize: 13),
                const SizedBox(height: 4),
                Text(
                  genreBpm,
                  style: const TextStyle(
                    color: Color(0xFF9EA8C8),
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            width: 90,
            height: 28,
            child: CustomPaint(
              painter: _MiniLogoWavePainter(),
            ),
          ),
          const SizedBox(width: 12),
          Text(
            duration,
            style: const TextStyle(
              color: Color(0xFF7E86A8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
class _MiniLogoWavePainter extends CustomPainter {
  const _MiniLogoWavePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF63E7FF),
          Color(0xFFE8EDF7),
          Color(0xFF8A78FF),
          Color(0xFFFF7CE6),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final path = Path();

    for (double x = 0; x <= size.width; x += 6) {
      final p = x / size.width;
      final y = centerY +
          math.sin(p * math.pi * 7) * size.height * 0.25 +
          math.sin(p * math.pi * 15) * size.height * 0.08;

      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _RightPanel extends StatelessWidget {
  const _RightPanel();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const _SilverMetalText(
              'Recent Clips',
              fontSize: 18,
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
            const _SilverMetalText(
              'Quick Actions',
              fontSize: 16,
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          _LogoStyleIcon(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _SilverMetalText(title, fontSize: 13),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: const TextStyle(
                    color: Color(0xFF9EA8C8),
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          Text(
            timestamp,
            style: const TextStyle(
              color: Color(0xFF7E86A8),
              fontSize: 11,
            ),
          ),
        ],
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

  const _QuickActionButton({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          _LogoStyleIcon(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: _SilverMetalText(
              label,
              fontSize: 13,
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 12,
            color: Color(0xFF7E86A8),
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
      ..style = PaintingStyle.stroke
      ..strokeWidth = 18
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18)
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF63E7FF),
          Color(0xFFC9D6E8),
          Color(0xFF8C6DFF),
          Color(0xFFFF65D8),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final mainPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.5
      ..strokeCap = StrokeCap.round
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF9FF4FF),
          Color(0xFFE8EDF7),
          Color(0xFF8A78FF),
          Color(0xFFFF7CE6),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final thinPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..strokeCap = StrokeCap.round
      ..color = const Color(0xFFE8EDF7).withAlpha(120);

    Path wave(double amplitude, double offset, double frequency) {
      final path = Path();
      for (double x = 0; x <= size.width; x += 8) {
        final progress = x / size.width;
        final envelope =
            (0.35 + 0.65 * (1 - (progress - 0.5).abs() * 1.55)).clamp(0.2, 1.0);

        final y = centerY +
            offset +
            amplitude *
                envelope *
                (
                  0.65 * math.sin(progress * math.pi * frequency) +
                  0.35 * math.sin(progress * math.pi * frequency * 2.4)
                );

        if (x == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      return path;
    }

    final mainWave = wave(size.height * 0.22, 0, 7.2);
    final upperWave = wave(size.height * 0.13, -size.height * 0.12, 6.4);
    final lowerWave = wave(size.height * 0.13, size.height * 0.12, 6.4);

    canvas.drawPath(mainWave, glowPaint);
    canvas.drawPath(upperWave, glowPaint);
    canvas.drawPath(lowerWave, glowPaint);

    canvas.drawPath(mainWave, mainPaint);
    canvas.drawPath(upperWave, thinPaint);
    canvas.drawPath(lowerWave, thinPaint);

    final silverLine = Paint()
      ..color = const Color(0xFFE8EDF7).withAlpha(45)
      ..strokeWidth = 1;

    canvas.drawLine(
      Offset(0, centerY),
      Offset(size.width, centerY),
      silverLine,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
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
    return Stack(
      children: [
        Text(
          text,
          style: TextStyle(
            fontSize: fontSize,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.4,
            color: const Color(0xFF3A2105),
            shadows: const [
              Shadow(
                color: Color(0xCC000000),
                blurRadius: 10,
                offset: Offset(3, 4),
              ),
            ],
          ),
        ),
        Transform.translate(
          offset: const Offset(-1.4, -1.4),
          child: ShaderMask(
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
                    offset: Offset(0, 0),
                  ),
                  Shadow(
                    color: Color(0x88FFFFFF),
                    blurRadius: 5,
                    offset: Offset(-1, -1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
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
