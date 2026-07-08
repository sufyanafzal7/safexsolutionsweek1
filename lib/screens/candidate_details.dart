import 'package:flutter/material.dart';
import '../models/candidate.dart';
import '../data/candidate_state.dart';
import '../utils/constants.dart';

class CandidateDetailsScreen extends StatelessWidget {
  final Candidate candidate;

  const CandidateDetailsScreen({super.key, required this.candidate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Candidate Profile', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.md),
            Hero(
              tag: 'candidate_avatar_${candidate.id}',
              child: CircleAvatar(
                radius: 50,
                backgroundColor: AppColors.primary.withOpacity(0.1),
                child: Text(
                  candidate.initials,
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary, fontSize: 36),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(candidate.name, style: Theme.of(context).textTheme.headlineMedium),
            Text(candidate.degree, style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w500)),
            Text(candidate.university, style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: AppSpacing.xl),

            _buildInfoSection(
              context,
              title: 'Contact Information',
              icon: Icons.contact_mail_outlined,
              children: [
                _buildInfoRow(Icons.email_outlined, 'Email', candidate.email),
                _buildInfoRow(Icons.phone_android_outlined, 'Phone', candidate.phone),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            _buildInfoSection(
              context,
              title: 'Professional Details',
              icon: Icons.work_outline,
              children: [
                _buildInfoRow(Icons.history_edu_outlined, 'Experience', candidate.experience),
              ],
            ),
            const SizedBox(height: AppSpacing.md),

            _buildInfoSection(
              context,
              title: 'Core Skills Matrix',
              icon: Icons.bolt_outlined,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: AppSpacing.sm),
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: candidate.skills.map((skill) {
                      return Chip(
                        label: Text(skill, style: const TextStyle(fontSize: 13)),
                        backgroundColor: AppColors.background,
                        side: BorderSide(color: Colors.grey.withOpacity(0.2)),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
            const SizedBox(height: AppSpacing.xl),

            // Locate the action buttons row near the bottom of your candidate_details.dart file and swap it with this:
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      CandidateStateManager.instance.updateStatus(candidate.id, CandidateStatus.rejected);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${candidate.name} marked as Rejected')),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.cancel_outlined, color: AppColors.error),
                    label: const Text('Reject', style: TextStyle(color: AppColors.error)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.error),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      CandidateStateManager.instance.updateStatus(candidate.id, CandidateStatus.interviewScheduled);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Interview scheduled with ${candidate.name}')),
                      );
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.calendar_today_outlined, color: AppColors.info),
                    label: const Text('Interview', style: TextStyle(color: AppColors.info)),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      side: const BorderSide(color: AppColors.info),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      CandidateStateManager.instance.updateStatus(candidate.id, CandidateStatus.shortlisted);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('${candidate.name} Shortlisted!')),
                      );
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.success,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    child: const Text('Shortlist'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context, {required String title, required IconData icon, required List<Widget> children}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 20, color: AppColors.primary),
                const SizedBox(width: AppSpacing.sm),
                Text(title, style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 15)),
              ],
            ),
            const Divider(height: 24),
            ...children
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textSecondary)),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
            ],
          )
        ],
      ),
    );
  }
}