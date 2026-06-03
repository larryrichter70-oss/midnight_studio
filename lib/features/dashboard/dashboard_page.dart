import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.topRight,
            radius: 1.4,
            colors: [
              AppColors.deepPurple,
              AppColors.midnightBlue,
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
            child: Column(
              children: const [
                _TopStudioBar(),
                SizedBox(height: 18),
                Expanded(
                  child: _StudioCockpit(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TopStudioBar extends StatelessWidget {
  const _TopStudioBar();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 54,
          height: 54,
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
                color: AppColors.gold.withOpacity(0.35),
                blurRadius: 26,
              ),
            ],
          ),
          child: const Icon(
            Icons.graphic_eq_rounded,
            color: Colors.black,
            size: 30,
          ),
        ),
        const SizedBox(width: 14),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MIDNIGHT',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 3,
                  color: AppColors.gold,
                ),
              ),
              Text(
                'STUDIO CONTROL ROOM',
                style: TextStyle(
                  fontSize: 11,
                  letterSpacing: 2,
                  color: AppColors.silver,
                ),
              ),
            ],
          ),
        ),
        Icon(
          Icons.more_horiz_rounded,
          color: AppColors.silver,
          size: 30,
        ),
      ],
    );
  }
}

class _StudioCockpit extends StatelessWidget {
  const _StudioCockpit();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Positioned.fill(
          child: _AmbientGrid(),
        ),

        Positioned(
          left: 0,
          right: 0,
          top: 0,
          height: 280,
          child: _MainDeck(),
        ),

        Positioned(
          left: 0,
          right: 0,
          top: 300,
          child: _TransportSection(),
        ),

        Positioned(
          left: 0,
          right: 0,
          top: 405,
          child: _ModuleStrip(),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 10,
          child: _ProjectStatusRail(),
        ),
      ],
    );
  }
}

class _AmbientGrid extends StatelessWidget {
  const _AmbientGrid();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _GridPainter(),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.gold.withOpacity(0.045)
      ..strokeWidth = 1;

    for (double x = 0; x < size.width; x += 32) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }

    for (double y = 0; y < size.height; y += 32) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MainDeck extends StatelessWidget {
  const _MainDeck();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(34),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.35),
          width: 1.2,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.black.withOpacity(0.45),
            AppColors.deepPurple.withOpacity(0.55),
            AppColors.midnightBlue.withOpacity(0.55),
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.32),
            blurRadius: 42,
            spreadRadius: 2,
          ),
          BoxShadow(
            color: AppColors.gold.withOpacity(0.12),
            blurRadius: 28,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -38,
            top: -20,
            child: Icon(
              Icons.album_rounded,
              size: 220,
              color: AppColors.gold.withOpacity(0.06),
            ),
          ),

          const Positioned(
            left: 24,
            top: 24,
            child: Text(
              'NOW BUILDING',
              style: TextStyle(
                color: AppColors.silver,
                fontSize: 11,
                letterSpacing: 2.4,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Positioned(
            left: 24,
            top: 58,
            child: Text(
              'NIGHT\nPULSE',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 42,
                height: 0.95,
                letterSpacing: 1.5,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          const Positioned(
            left: 24,
            top: 150,
            child: Text(
              'Dark Pop  ·  92 BPM  ·  Demo Mix',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ),

          const Positioned(
            left: 24,
            right: 24,
            bottom: 62,
            child: _BigWaveform(),
          ),

          Positioned(
            left: 24,
            right: 24,
            bottom: 28,
            child: Row(
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(999),
                    child: const LinearProgressIndicator(
                      value: 0.75,
                      minHeight: 8,
                      backgroundColor: Colors.white10,
                      color: AppColors.gold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                const Text(
                  '75%',
                  style: TextStyle(
                    color: AppColors.gold,
                    fontWeight: FontWeight.bold,
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

class _BigWaveform extends StatelessWidget {
  const _BigWaveform();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 62,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          42,
          (index) {
            final h = 8 + ((index * 23) % 54).toDouble();

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.3),
                child: Container(
                  height: h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.neonPurple.withOpacity(0.55),
                        AppColors.gold,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.gold.withOpacity(0.25),
                        blurRadius: 8,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _TransportSection extends StatelessWidget {
  const _TransportSection();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _RoundControl(
          icon: Icons.skip_previous_rounded,
          small: true,
        ),
        SizedBox(width: 12),
        _RoundControl(
          icon: Icons.play_arrow_rounded,
          main: true,
        ),
        SizedBox(width: 12),
        _RoundControl(
          icon: Icons.stop_rounded,
          small: true,
        ),
        Spacer(),
        _LevelMeter(label: 'VOCAL', value: 0.72),
        SizedBox(width: 12),
        _LevelMeter(label: 'BEAT', value: 0.56),
      ],
    );
  }
}

class _RoundControl extends StatelessWidget {
  final IconData icon;
  final bool main;
  final bool small;

  const _RoundControl({
    required this.icon,
    this.main = false,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = main ? 66.0 : 48.0;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: main
            ? const LinearGradient(
                colors: [
                  AppColors.gold,
                  AppColors.neonPurple,
                ],
              )
            : null,
        color: main ? null : Colors.black.withOpacity(0.35),
        border: Border.all(
          color: main
              ? AppColors.gold.withOpacity(0.7)
              : AppColors.silver.withOpacity(0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: main
                ? AppColors.gold.withOpacity(0.35)
                : AppColors.neonPurple.withOpacity(0.16),
            blurRadius: main ? 30 : 18,
          ),
        ],
      ),
      child: Icon(
        icon,
        color: main ? Colors.black : AppColors.silver,
        size: main ? 38 : 27,
      ),
    );
  }
}

class _LevelMeter extends StatelessWidget {
  final String label;
  final double value;

  const _LevelMeter({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 72,
      height: 58,
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.black.withOpacity(0.32),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.22),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.textSecondary,
              fontSize: 10,
              letterSpacing: 1.2,
            ),
          ),
          const Spacer(),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 7,
              backgroundColor: Colors.white10,
              color: AppColors.gold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ModuleStrip extends StatelessWidget {
  const _ModuleStrip();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: _StudioModule(
            icon: Icons.edit_note_rounded,
            label: 'LYRICS',
            active: true,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StudioModule(
            icon: Icons.music_note_rounded,
            label: 'BEAT',
            active: true,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StudioModule(
            icon: Icons.mic_rounded,
            label: 'REC',
            active: true,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _StudioModule(
            icon: Icons.tune_rounded,
            label: 'MIX',
            active: false,
          ),
        ),
      ],
    );
  }
}

class _StudioModule extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;

  const _StudioModule({
    required this.icon,
    required this.label,
    required this.active,
  });

  @override
  Widget build(BuildContext context) {
    final color = active ? AppColors.gold : AppColors.silver;

    return Container(
      height: 96,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Colors.black.withOpacity(0.32),
        border: Border.all(
          color: color.withOpacity(active ? 0.45 : 0.18),
        ),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(active ? 0.20 : 0.06),
            blurRadius: 22,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 28,
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProjectStatusRail extends StatelessWidget {
  const _ProjectStatusRail();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 86,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: Colors.black.withOpacity(0.34),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.neonPurple.withOpacity(0.20),
            blurRadius: 28,
          ),
        ],
      ),
      child: Row(
        children: const [
          Icon(
            Icons.folder_rounded,
            color: AppColors.gold,
            size: 34,
          ),
          SizedBox(width: 14),
          Expanded(
            child: Text(
              '3 Projekte aktiv\nLetzter Export: night_pulse_demo.mp3',
              style: TextStyle(
                color: AppColors.textSecondary,
                height: 1.35,
              ),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios_rounded,
            color: AppColors.silver,
            size: 18,
          ),
        ],
      ),
    );
  }
}