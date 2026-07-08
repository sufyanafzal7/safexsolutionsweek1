enum CandidateStatus { shortlisted, interviewScheduled, rejected, pending }

class Candidate {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String university;
  final String degree;
  final List<String> skills;
  final String experience;
  final CandidateStatus status;

  const Candidate({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.university,
    required this.degree,
    required this.skills,
    required this.experience,
    required this.status,
  });

  String get initials =>
      name.isNotEmpty
          ? name.trim().split(' ').first.substring(0, 1).toUpperCase()
          : '';
}