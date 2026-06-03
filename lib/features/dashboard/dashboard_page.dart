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
            center: Alignment.topCenter,
            radius: 1.25,
            colors: [
              AppColors.deepPurple,
              AppColors.midnightBlue,
              AppColors.background,
            ],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              children: const [
                _Header(),
                SizedBox(height: 20),
                Expanded(child: _MainStudio()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Icon(Icons.graphic_eq_rounded, color: AppColors.gold, size: 42),
        SizedBox(width: 14),
        Expanded(
          child: Text(
            'MIDNIGHT STUDIO',
            style: TextStyle(
              color: AppColors.gold,
              fontSize: 25,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _MainStudio extends StatelessWidget {
  const _MainStudio();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _StudioPainter(),
      child: Stack(
        children: const [
          Positioned(
            left: 22,
            top: 28,
            child: Text(
              'ACTIVE PROJECT',
              style: TextStyle(
                color: AppColors.silver,
                fontSize: 12,
                letterSpacing: 2,
              ),
            ),
          ),
          Positioned(
            left: 22,
            top: 70,
            child: Text(
              'NIGHT\nPULSE',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 48,
                height: 0.9,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Positioned(
            left: 22,
            top: 170,
            child: Text(
              'Dark Pop · 92 BPM · Demo Mix',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            top: 225,
            child: _Waveform(),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 130,
            child: _ModuleRow(),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 35,
            child: _StatusBar(),
          ),
        ],
      ),
    );
  }
}

class _Waveform extends StatelessWidget {
  const _Waveform();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(42, (index) {
          final h = 10 + ((index * 23) % 60).toDouble();

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 1),
              child: Container(
                height: h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(999),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      AppColors.neonPurple.withOpacity(0.45),
                      AppColors.gold,
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ModuleRow extends StatelessWidget {
  const _ModuleRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        _Module(icon: Icons.edit_note_rounded, label: 'LYRICS'),
        SizedBox(width: 10),
        _Module(icon: Icons.music_note_rounded, label: 'BEAT'),
        SizedBox(width: 10),
        _Module(icon: Icons.mic_rounded, label: 'REC'),
        SizedBox(width: 10),
        _Module(icon: Icons.tune_rounded, label: 'MIX'),
      ],
    );
  }
}

class _Module extends StatelessWidget {
  final IconData icon;
  final String label;

  const _Module({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: AppColors.gold, size: 30),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.gold,
              fontSize: 11,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusBar extends StatelessWidget {
  const _StatusBar();

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: 14),
        const Text(
          '75%',
          style: TextStyle(
            color: AppColors.gold,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}

class _StudioPainter extends CustomPainter {
  const _StudioPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final borderPaint = Paint()
      ..color = AppColors.gold.withOpacity(0.26)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.3;

    final glowPaint = Paint()
      ..color = AppColors.neonPurple.withOpacity(0.12)
      ..style = PaintingStyle.fill;

    final rect = RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      const Radius.circular(34),
    );

    canvas.drawRRect(rect, glowPaint);
    canvas.drawRRect(rect, borderPaint);

    final linePaint = Paint()
      ..color = AppColors.gold.withOpacity(0.055)
      ..strokeWidth = 1;

    for (double y = 30; y < size.height; y += 38) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), linePaint);
    }

    for (double x = 30; x < size.width; x += 38) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}