import 'package:flutter/material.dart';
import '../models/candidate.dart';
import 'dummy_data.dart';

class CandidateStateManager extends ValueNotifier<List<Candidate>> {
  CandidateStateManager._internal() : super(mockCandidates);

  static final CandidateStateManager instance = CandidateStateManager._internal();

  // Update Status (Shortlist / Reject / Schedule Interview)
  void updateStatus(String id, CandidateStatus newStatus) {
    value = value.map((candidate) {
      if (candidate.id == id) {
        return Candidate(
          id: candidate.id,
          name: candidate.name,
          email: candidate.email,
          phone: candidate.phone,
          university: candidate.university,
          degree: candidate.degree,
          skills: candidate.skills,
          experience: candidate.experience,
          status: newStatus,
        );
      }
      return candidate;
    }).toList();
  }
}