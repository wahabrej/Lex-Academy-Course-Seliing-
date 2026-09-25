class ExamListResponse {
  final bool success;
  final String message;
  final List<ExamItem> items;

  ExamListResponse({required this.success, required this.message, required this.items});

  factory ExamListResponse.fromJson(Map<String, dynamic> json) {
    return ExamListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: (json['data'] as List?)?.map((e) => ExamItem.fromJson(e)).toList() ?? [],
    );
  }
}

class ExamItem {
  final String id;
  final String title;
  final String? description;
  final String type; // mcq, written
  final int? duration;
  final int? totalQuestions;
  final int? totalMarks;
  final DateTime? startTime;
  final DateTime? endTime;
  final bool isLive;

  ExamItem({
    required this.id,
    required this.title,
    this.description,
    required this.type,
    this.duration,
    this.totalQuestions,
    this.totalMarks,
    this.startTime,
    this.endTime,
    required this.isLive,
  });

  factory ExamItem.fromJson(Map<String, dynamic> json) {
    return ExamItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'],
      type: json['type'] ?? 'mcq',
      duration: json['duration'],
      totalQuestions: json['total_questions'],
      totalMarks: json['total_marks'],
      startTime: json['start_time'] != null ? DateTime.tryParse(json['start_time']) : null,
      endTime: json['end_time'] != null ? DateTime.tryParse(json['end_time']) : null,
      isLive: json['is_live'] ?? false,
    );
  }
}

class ExamAttemptResponse {
  final bool success;
  final String message;
  final ExamAttempt? data;

  ExamAttemptResponse({required this.success, required this.message, this.data});

  factory ExamAttemptResponse.fromJson(Map<String, dynamic> json) {
    return ExamAttemptResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null ? ExamAttempt.fromJson(json['data']) : null,
    );
  }
}

class ExamAttempt {
  final String id;
  final String examId;
  final String status; // in-progress, completed
  final int? score;
  final DateTime? startedAt;
  final DateTime? submittedAt;
  final List<ExamQuestion>? questions;

  ExamAttempt({
    required this.id,
    required this.examId,
    required this.status,
    this.score,
    this.startedAt,
    this.submittedAt,
    this.questions,
  });

  factory ExamAttempt.fromJson(Map<String, dynamic> json) {
    return ExamAttempt(
      id: json['id'] ?? '',
      examId: json['exam_id'] ?? '',
      status: json['status'] ?? '',
      score: json['score'],
      startedAt: json['started_at'] != null ? DateTime.tryParse(json['started_at']) : null,
      submittedAt: json['submitted_at'] != null ? DateTime.tryParse(json['submitted_at']) : null,
      questions: (json['questions'] as List?)?.map((e) => ExamQuestion.fromJson(e)).toList(),
    );
  }
}

class ExamQuestion {
  final String id;
  final String text;
  final List<ExamOption> options;
  final String? selectedOptionId;
  final String? correctOptionId;
  final String? explanation;

  ExamQuestion({
    required this.id,
    required this.text,
    required this.options,
    this.selectedOptionId,
    this.correctOptionId,
    this.explanation,
  });

  factory ExamQuestion.fromJson(Map<String, dynamic> json) {
    return ExamQuestion(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
      options: (json['options'] as List?)?.map((e) => ExamOption.fromJson(e)).toList() ?? [],
      selectedOptionId: json['selected_option_id'],
      correctOptionId: json['correct_option_id'],
      explanation: json['explanation'],
    );
  }
}

class ExamOption {
  final String id;
  final String text;

  ExamOption({required this.id, required this.text});

  factory ExamOption.fromJson(Map<String, dynamic> json) {
    return ExamOption(
      id: json['id'] ?? '',
      text: json['text'] ?? '',
    );
  }
}

class AttemptListResponse {
  final bool success;
  final String message;
  final List<ExamAttempt> items;
  final int total;

  AttemptListResponse({
    required this.success,
    required this.message,
    required this.items,
    required this.total,
  });

  factory AttemptListResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AttemptListResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      items: (data['items'] as List?)?.map((e) => ExamAttempt.fromJson(e)).toList() ?? [],
      total: data['total'] ?? 0,
    );
  }
}
