class Job {
  final String id; // Firestore doc ID
  final String title;
  final String description;
  final String company;
  final String userId;

  Job({
    required this.id,
    required this.title,
    required this.description,
    required this.company,
    required this.userId,
  });

  /// Convert Job to Firestore map
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'company': company,
      'userId': userId,
    };
  }

  /// Create Job from Firestore map + document ID
  factory Job.fromMap(Map<String, dynamic> map, String id) {
    return Job(
      id: id,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      company: map['company'] ?? '',
      userId: map['userId'] ?? '', // 👈 fallback if missing
    );
  }
}
