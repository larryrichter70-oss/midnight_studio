import 'package:flutter/material.dart';
import 'app/app_shell.dart';
import 'core/controllers/project_controller.dart';
import 'core/theme/app_theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await ProjectController.loadProjects();

  runApp(const MidnightStudioApp());
}

class MidnightStudioApp extends StatelessWidget {
  const MidnightStudioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Midnight Studio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const AppShell(),
    );
  }
}