import 'package:flutter/material.dart';
import '../utils/constants.dart';
import '../models/candidate.dart';
import '../data/candidate_state.dart';
import '../widgets/stats_card.dart';
import '../widgets/candidate_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final int crossAxisCount = width > 900 ? 4 : (width > 600 ? 2 : 2);

    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder<List<Candidate>>(
          valueListenable: CandidateStateManager.instance,
          builder: (context, candidates, child) {

            // Calculate dynamic stats
            final total = candidates.length;
            final shortlisted = candidates.where((c) => c.status == CandidateStatus.shortlisted).length;
            final interviews = candidates.where((c) => c.status == CandidateStatus.interviewScheduled).length;
            final rejected = candidates.where((c) => c.status == CandidateStatus.rejected).length;

            // Filter data based on search
            final filteredCandidates = candidates.where((c) {
              final matchesName = c.name.toLowerCase().contains(_searchQuery.toLowerCase());
              final matchesSkill = c.skills.any((s) => s.toLowerCase().contains(_searchQuery.toLowerCase()));
              return matchesName || matchesSkill;
            }).toList();

            return ListView(
              padding: const EdgeInsets.all(AppSpacing.md),
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Welcome Back,', style: Theme.of(context).textTheme.bodyMedium),
                        Text('HR Manager', style: Theme.of(context).textTheme.headlineMedium),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.notifications_none_outlined, color: AppColors.textPrimary),
                      onPressed: () {},
                    )
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                // Search Bar
                TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  decoration: InputDecoration(
                    hintText: 'Search candidates, skills...',
                    prefixIcon: const Icon(Icons.search, size: 20),
                    filled: true,
                    fillColor: AppColors.cardBg,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.withOpacity(0.1)),
                    ),
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                // Dynamic Statistics Grid Layout
                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: AppSpacing.sm,
                  mainAxisSpacing: AppSpacing.sm,
                  childAspectRatio: width > 600 ? 2.0 : 1.4,
                  children: [
                    StatsCard(title: 'Total Tracked', count: '$total', icon: Icons.people, color: AppColors.primary),
                    StatsCard(title: 'Shortlisted', count: '$shortlisted', icon: Icons.check_circle, color: AppColors.success),
                    StatsCard(title: 'Interviews', count: '$interviews', icon: Icons.calendar_today, color: AppColors.info),
                    StatsCard(title: 'Rejected', count: '$rejected', icon: Icons.cancel, color: AppColors.error),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),

                Text('Candidate Direct Profiles', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: AppSpacing.md),

                // Responsive Candidate List
                filteredCandidates.isEmpty
                    ? const Center(child: Padding(padding: EdgeInsets.all(32), child: Text('No candidates match your query.')))
                    : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: filteredCandidates.length,
                  itemBuilder: (context, index) {
                    return CandidateCard(candidate: filteredCandidates[index]);
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}