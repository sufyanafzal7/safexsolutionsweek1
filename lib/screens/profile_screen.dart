import 'package:flutter/material.dart';
import '../utils/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Column(
            children: [
              const SizedBox(height: AppSpacing.lg),
              const CircleAvatar(
                radius: 46,
                backgroundColor: AppColors.primary,
                child: Text('HR', style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: AppSpacing.md),
              Text('SafeX Administrator', style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: 22)),
              Text('recruitment@safex.solutions', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: AppSpacing.xl),

              _buildTile(Icons.settings_outlined, 'System Settings'),
              _buildTile(Icons.notifications_none_outlined, 'Notification Channels'),
              _buildTile(Icons.info_outline, 'About SafeX Solutions Platform'),
              const Divider(height: 32),
              _buildTile(Icons.logout, 'Sign Out', color: AppColors.error),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, {Color color = AppColors.textPrimary}) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: ListTile(
        leading: Icon(icon, color: color, size: 22),
        title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500, fontSize: 14)),
        trailing: const Icon(Icons.chevron_right, size: 18, color: AppColors.textSecondary),
        onTap: () {},
      ),
    );
  }
}