import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class MiniWaveform extends StatelessWidget {
  final int bars;
  final double height;
  final Color color;

  const MiniWaveform({
    super.key,
    this.bars = 32,
    this.height = 54,
    this.color = AppColors.neonPurple,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          bars,
          (index) {
            final barHeight = 8 + ((index * 19) % (height.toInt() - 8)).toDouble();

            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 1.2),
                child: Container(
                  height: barHeight,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        color.withOpacity(0.45),
                        AppColors.gold,
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: color.withOpacity(0.35),
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