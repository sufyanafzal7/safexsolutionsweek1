import 'package:flutter/material.dart';
import '../models/candidate.dart';
import '../utils/constants.dart';
import '../screens/candidate_details.dart';

class CandidateCard extends StatelessWidget {
  final Candidate candidate;

  const CandidateCard({super.key, required this.candidate});

  Color _getStatusColor(CandidateStatus status) {
    switch (status) {
      case CandidateStatus.shortlisted: return AppColors.success;
      case CandidateStatus.interviewScheduled: return AppColors.info;
      case CandidateStatus.rejected: return AppColors.error;
      case CandidateStatus.pending: return AppColors.warning;
    }
  }

  String _getStatusText(CandidateStatus status) {
    switch (status) {
      case CandidateStatus.shortlisted: return 'Shortlisted';
      case CandidateStatus.interviewScheduled: return 'Interview Scheduled';
      case CandidateStatus.rejected: return 'Rejected';
      case CandidateStatus.pending: return 'Pending';
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(candidate.status);

    return Hero(
      tag: 'candidate_avatar_${candidate.id}',
      child: Card(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CandidateDetailsScreen(candidate: candidate),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: AppColors.primary.withOpacity(0.1),
                  child: Text(
                    candidate.initials,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                      fontSize: 18,
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              candidate.name,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: 16),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              _getStatusText(candidate.status),
                              style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.xs),
                      Text(candidate.degree, style: Theme.of(context).textTheme.bodyMedium),
                      Text(candidate.university, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 12)),
                      const SizedBox(height: AppSpacing.sm),
                      Wrap(
                        spacing: 6,
                        runSpacing: 4,
                        children: candidate.skills.take(3).map((skill) {
                          return Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(skill, style: const TextStyle(fontSize: 11, color: AppColors.textPrimary)),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}