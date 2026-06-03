import 'package:flutter/material.dart';
import '../core/theme/app_colors.dart';
import '../features/dashboard/dashboard_page.dart';
import '../features/projects/projects_page.dart';
import '../features/settings/settings_page.dart';
import '../features/studio/studio_page.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int selectedIndex = 0;

  final pages = const [
    DashboardPage(),
    StudioPage(),
    ProjectsPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.background.withOpacity(0.96),
          border: Border(
            top: BorderSide(
              color: AppColors.gold.withOpacity(0.22),
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.neonPurple.withOpacity(0.25),
              blurRadius: 24,
              spreadRadius: 2,
            ),
          ],
        ),
        child: NavigationBar(
          selectedIndex: selectedIndex,
          backgroundColor: Colors.transparent,
          indicatorColor: AppColors.gold.withOpacity(0.22),
          labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
          onDestinationSelected: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_rounded),
              selectedIcon: Icon(Icons.home_rounded, color: AppColors.gold),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.graphic_eq_rounded),
              selectedIcon:
                  Icon(Icons.graphic_eq_rounded, color: AppColors.gold),
              label: 'Studio',
            ),
            NavigationDestination(
              icon: Icon(Icons.folder_rounded),
              selectedIcon: Icon(Icons.folder_rounded, color: AppColors.gold),
              label: 'Projekte',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_rounded),
              selectedIcon:
                  Icon(Icons.settings_rounded, color: AppColors.gold),
              label: 'Settings',
            ),
          ],
        ),
      ),
    );
  }
}