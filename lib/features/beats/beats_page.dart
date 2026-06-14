import 'package:flutter/material.dart';

import '../../core/controllers/project_controller.dart';
import '../../core/models/music_project.dart';

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
    final genre = beatGenreController.text.trim();
    final bpm = beatBpmController.text.trim();
    final mood = beatMoodController.text.trim();
    final instruments = beatInstrumentsController.text.trim();

    final currentProject = widget.project;

    if (currentProject == null) {
      final newProject = MusicProject(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: 'Unbenannter Beat Track',
        beatGenre: genre,
        beatBpm: bpm,
        beatMood: mood,
        beatInstruments: instruments,
        createdAt: DateTime.now(),
      );

      await ProjectController.addProject(newProject);
    } else {
      final updatedProject = currentProject.copyWith(
        beatGenre: genre,
        beatBpm: bpm,
        beatMood: mood,
        beatInstruments: instruments,
      );

      await ProjectController.updateProject(updatedProject);
    }

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
          child: Padding(
            padding: const EdgeInsets.all(26),
            child: ListView(
              children: [
                const _BeatsHeader(),
                const SizedBox(height: 28),

                if (!hasProject)
                  const _StudioHint(
                    text:
                        'Hinweis: Öffne Beats am besten über ein Projekt, damit deine Beat-Daten gespeichert werden können.',
                  ),

                if (!hasProject) const SizedBox(height: 22),

                const _SilverMetalText(
                  'BEAT INFORMATION',
                  fontSize: 16,
                ),

                const SizedBox(height: 20),

                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Genre',
                        hint: 'Dark Pop / Hip-Hop',
                        controller: beatGenreController,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _InputField(
                        label: 'BPM',
                        hint: '92',
                        controller: beatBpmController,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: _InputField(
                        label: 'Stimmung',
                        hint: 'Dunkel · emotional',
                        controller: beatMoodController,
                      ),
                    ),
                    const SizedBox(width: 40),
                    Expanded(
                      child: _InputField(
                        label: 'Instrumente',
                        hint: 'Piano · 808 · Pads',
                        controller: beatInstrumentsController,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 34),

                const _SilverMetalText(
                  'BEAT PREVIEW',
                  fontSize: 16,
                ),

                const SizedBox(height: 16),

                const _BeatPreviewInfo(),

                const SizedBox(height: 30),

                _StudioActionButton(
                  icon: Icons.auto_awesome_rounded,
                  label: 'Beat generieren',
                  onTap: () {},
                ),

                const SizedBox(height: 14),

                _StudioActionButton(
                  icon: Icons.save_rounded,
                  label: 'Beat im Projekt speichern',
                  onTap: saveBeatData,
                ),

                const SizedBox(height: 34),

                const _SilverMetalText(
                  'DEMO BEATS',
                  fontSize: 16,
                ),

                const SizedBox(height: 16),

                const _BeatItem(
                  title: 'Midnight Pulse',
                  bpm: '92 BPM',
                  tag: 'Dark Pop',
                ),
                const _BeatItem(
                  title: 'Golden Shadows',
                  bpm: '84 BPM',
                  tag: 'Emotional',
                ),
                const _BeatItem(
                  title: 'Neon Heartbeat',
                  bpm: '104 BPM',
                  tag: 'Synth Pop',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BeatsHeader extends StatelessWidget {
  const _BeatsHeader();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const _LogoStyleIcon(icon: Icons.graphic_eq_rounded),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            _GoldMetalText(
              'BEATS',
              fontSize: 28,
            ),
            SizedBox(height: 4),
            Text(
              'Genre, BPM, Stimmung und Sound formen',
              style: TextStyle(
                color: Color(0xFF9EA8C8),
                fontSize: 12,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ],
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
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      style: const TextStyle(
        color: Color(0xFFE8EDF7),
        fontSize: 14,
      ),
      decoration: _studioInputDecoration(
        label: label,
        hint: hint,
      ),
    );
  }
}

InputDecoration _studioInputDecoration({
  String? label,
  required String hint,
}) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(
      color: Color(0xFFD9E5FF),
      fontWeight: FontWeight.w700,
      letterSpacing: 0.6,
    ),
    hintText: hint,
    hintStyle: const TextStyle(
      color: Color(0xFF7E86A8),
    ),
    filled: true,
    fillColor: Colors.transparent,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 0,
      vertical: 14,
    ),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0x448A78FF),
      ),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(0xFFE8EDF7),
        width: 1.4,
      ),
    ),
  );
}

class _StudioActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _StudioActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
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
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 12,
              color: Color(0xFF7E86A8),
            ),
          ],
        ),
      ),
    );
  }
}

class _StudioHint extends StatelessWidget {
  final String text;

  const _StudioHint({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: const TextStyle(
          color: Color(0xFF9EA8C8),
          fontSize: 13,
          height: 1.4,
        ),
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
                  '$bpm · $tag',
                  style: const TextStyle(
                    color: Color(0xFF9EA8C8),
                    fontSize: 12,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.play_arrow_rounded,
            size: 18,
            color: Color(0xFFE8EDF7),
          ),
        ],
      ),
    );
  }
}
class _BeatPreviewInfo extends StatelessWidget {
  const _BeatPreviewInfo();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          _LogoStyleIcon(icon: Icons.graphic_eq_rounded),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              'Beat Preview · 92 BPM · Dark Pop · Piano · 808 · Pads',
              style: TextStyle(
                color: Color(0xFF9EA8C8),
                fontSize: 13,
                letterSpacing: 0.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BeatWavePainter extends CustomPainter {
  const _BeatWavePainter();

  @override
  void paint(Canvas canvas, Size size) {
    final centerY = size.height / 2;

    final glowPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 18)
      ..shader = const LinearGradient(
        colors: [
          Color(0xFF63E7FF),
          Color(0xFFE8EDF7),
          Color(0xFF8A78FF),
          Color(0xFFFF7CE6),
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final mainPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
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

    for (double x = 0; x <= size.width; x += 7) {
      final p = x / size.width;
      final y = centerY +
          (p < 0.5 ? 1 : -1) *
              (size.height * 0.18) *
              (1 - (p - 0.5).abs()) +
          (p * 30).sinLike() * size.height * 0.12;

      if (x == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    canvas.drawPath(path, glowPaint);
    canvas.drawPath(path, mainPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

extension _BeatMath on double {
  double sinLike() {
    final x = this;
    return (x % 6.28) < 3.14 ? 0.65 : -0.65;
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

class _GoldMetalText extends StatelessWidget {
  final String text;
  final double fontSize;

  const _GoldMetalText(
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
            ),
            Shadow(
              color: Color(0x88000000),
              blurRadius: 8,
              offset: Offset(2, 3),
            ),
          ],
        ),
      ),
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