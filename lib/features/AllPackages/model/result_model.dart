class ExamResultsResponse {
  final bool success;
  final String message;
  final List<ExamResultItem> items;

  ExamResultsResponse({required this.success, required this.message, required this.items});

  factory ExamResultsResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final itemsList = (data['items'] as List?)?.map((e) => ExamResultItem.fromJson(e)).toList() ?? [];
    return ExamResultsResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: itemsList,
    );
  }
}

class ExamResultItem {
  final String attemptId;
  final String examId;
  final String title;
  final String type;
  final String score;
  final String totalMarks;
  final String rank;
  final String totalParticipants;
  final String date;

  ExamResultItem({
    required this.attemptId,
    required this.examId,
    required this.title,
    required this.type,
    required this.score,
    required this.totalMarks,
    required this.rank,
    required this.totalParticipants,
    required this.date,
  });

  factory ExamResultItem.fromJson(Map<String, dynamic> json) {
    return ExamResultItem(
      attemptId: json['attempt_id'] ?? json['id'] ?? '',
      examId: json['exam_id'] ?? '',
      title: json['title'] ?? json['exam_title'] ?? '',
      type: json['type'] ?? 'mcq',
      score: (json['score'] ?? json['obtained_marks'] ?? '0').toString(),
      totalMarks: (json['total_marks'] ?? '100').toString(),
      rank: (json['rank'] ?? '0').toString(),
      totalParticipants: (json['total_participants'] ?? '0').toString(),
      date: json['date'] ?? json['submitted_at'] ?? '',
    );
  }
}

class MeritListResponse {
  final bool success;
  final String message;
  final List<MeritListItem> items;

  MeritListResponse({required this.success, required this.message, required this.items});

  factory MeritListResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    final itemsList = (data['items'] as List?)?.map((e) => MeritListItem.fromJson(e)).toList() ?? 
                      (json['data'] is List ? (json['data'] as List).map((e) => MeritListItem.fromJson(e)).toList() : []);
    return MeritListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: itemsList,
    );
  }
}

class MeritListItem {
  final String name;
  final String? image;
  final String? department;
  final String score;
  final int rank;

  MeritListItem({
    required this.name,
    this.image,
    this.department,
    required this.score,
    required this.rank,
  });

  factory MeritListItem.fromJson(Map<String, dynamic> json) {
    return MeritListItem(
      name: json['name'] ?? json['user_name'] ?? 'Unknown User',
      image: json['image'] ?? json['avatar_url'],
      department: json['department'] ?? json['dept'],
      score: (json['score'] ?? json['total_marks'] ?? '0').toString(),
      rank: json['rank'] ?? 0,
    );
  }
}

class SubjectBreakdownResponse {
  final bool success;
  final String message;
  final List<SubjectBreakdownItem> items;

  SubjectBreakdownResponse({required this.success, required this.message, required this.items});

  factory SubjectBreakdownResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? [];
    List<SubjectBreakdownItem> itemsList = [];
    if (data is List) {
      itemsList = data.map((e) => SubjectBreakdownItem.fromJson(e)).toList();
    }
    return SubjectBreakdownResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: itemsList,
    );
  }
}

class SubjectBreakdownItem {
  final String subject;
  final int correct;
  final int wrong;
  final int skipped;
  final String score;
  final String accuracy;

  SubjectBreakdownItem({
    required this.subject,
    required this.correct,
    required this.wrong,
    required this.skipped,
    required this.score,
    required this.accuracy,
  });

  factory SubjectBreakdownItem.fromJson(Map<String, dynamic> json) {
    return SubjectBreakdownItem(
      subject: json['subject'] ?? json['subject_name'] ?? '',
      correct: json['correct'] ?? 0,
      wrong: json['wrong'] ?? 0,
      skipped: json['skipped'] ?? 0,
      score: (json['score'] ?? '0').toString(),
      accuracy: json['accuracy'] ?? '0%',
    );
  }
}
