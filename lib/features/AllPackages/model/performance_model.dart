class UserPerformanceAnalytics {
  final PerformanceOverview overview;
  final List<SubjectAccuracy> subjectWiseAccuracy;
  final ProgramWiseAttempts? programWiseAttempts;

  const UserPerformanceAnalytics({
    required this.overview,
    required this.subjectWiseAccuracy,
    this.programWiseAttempts,
  });

  factory UserPerformanceAnalytics.fromJson(Map<String, dynamic> json) =>
      UserPerformanceAnalytics(
        overview: PerformanceOverview.fromJson(
          _performanceMap(json['overview']),
        ),
        subjectWiseAccuracy: _performanceItems(
          json['subjectWiseAccuracy'],
          SubjectAccuracy.fromJson,
        ),
        programWiseAttempts: json['programWiseAttempts'] is Map<String, dynamic>
            ? ProgramWiseAttempts.fromJson(
                json['programWiseAttempts'] as Map<String, dynamic>,
              )
            : null,
      );
}

class PerformanceOverview {
  final int questionsAnswered;
  final double correctAverage;
  final List<ScoreHistoryPoint> topPerformanceGraph;
  final List<SubjectAccuracy> weakAreas;
  final List<TopicPerformance> topicPerformance;

  const PerformanceOverview({
    required this.questionsAnswered,
    required this.correctAverage,
    required this.topPerformanceGraph,
    required this.weakAreas,
    required this.topicPerformance,
  });

  factory PerformanceOverview.fromJson(Map<String, dynamic> json) =>
      PerformanceOverview(
        questionsAnswered: _performanceInt(json['questionsAnswered']),
        correctAverage: _performanceDouble(json['correctAverage']),
        topPerformanceGraph: _performanceItems(
          json['topPerformanceGraph'],
          ScoreHistoryPoint.fromJson,
        ),
        weakAreas: _performanceItems(
          json['weakAreas'],
          SubjectAccuracy.fromJson,
        ),
        topicPerformance: _performanceItems(
          json['topicPerformance'],
          TopicPerformance.fromJson,
        ),
      );
}

class SubjectAccuracy {
  final String subjectName;
  final int right;
  final int wrong;
  final int unanswered;
  final double accuracy;

  const SubjectAccuracy({
    required this.subjectName,
    required this.right,
    required this.wrong,
    required this.unanswered,
    required this.accuracy,
  });

  factory SubjectAccuracy.fromJson(Map<String, dynamic> json) =>
      SubjectAccuracy(
        subjectName: json['subject_name']?.toString() ?? 'Subject',
        right: _performanceInt(json['right'] ?? json['right_count']),
        wrong: _performanceInt(json['wrong'] ?? json['wrong_count']),
        unanswered: _performanceInt(json['unanswered']),
        accuracy: _performanceDouble(
          json['accuracy'] ?? json['accuracy_percentage'],
        ),
      );
}

class ScoreHistoryPoint {
  final DateTime? date;
  final double score;
  final double accuracy;

  const ScoreHistoryPoint({
    this.date,
    required this.score,
    required this.accuracy,
  });

  factory ScoreHistoryPoint.fromJson(Map<String, dynamic> json) =>
      ScoreHistoryPoint(
        date: DateTime.tryParse(json['date']?.toString() ?? ''),
        score: _performanceDouble(json['score']),
        accuracy: _performanceDouble(json['accuracy']),
      );
}

class TopicPerformance {
  final String topic;
  final int wrongCount;
  final int totalQuestions;

  const TopicPerformance({
    required this.topic,
    required this.wrongCount,
    required this.totalQuestions,
  });

  factory TopicPerformance.fromJson(Map<String, dynamic> json) =>
      TopicPerformance(
        topic: json['topic']?.toString() ?? '',
        wrongCount: _performanceInt(json['wrongCount']),
        totalQuestions: _performanceInt(json['totalQuestions']),
      );
}

class ProgramWiseAttempts {
  final double userOverallAverage;
  final double platformOverallAverage;
  final List<ExamPerformanceComparison> examComparisonTable;

  const ProgramWiseAttempts({
    required this.userOverallAverage,
    required this.platformOverallAverage,
    required this.examComparisonTable,
  });

  factory ProgramWiseAttempts.fromJson(Map<String, dynamic> json) =>
      ProgramWiseAttempts(
        userOverallAverage: _performanceDouble(json['userOverallAverage']),
        platformOverallAverage: _performanceDouble(
          json['platformOverallAverage'],
        ),
        examComparisonTable: _performanceItems(
          json['examComparisonTable'],
          ExamPerformanceComparison.fromJson,
        ),
      );
}

class ExamPerformanceComparison {
  final String examId;
  final String examTitle;
  final String type;
  final double userScore;
  final double platformAverage;

  const ExamPerformanceComparison({
    required this.examId,
    required this.examTitle,
    required this.type,
    required this.userScore,
    required this.platformAverage,
  });

  factory ExamPerformanceComparison.fromJson(Map<String, dynamic> json) =>
      ExamPerformanceComparison(
        examId: json['exam_id']?.toString() ?? '',
        examTitle: json['exam_title']?.toString() ?? 'Exam',
        type: json['type']?.toString() ?? '',
        userScore: _performanceDouble(json['userScore']),
        platformAverage: _performanceDouble(json['platformAverage']),
      );
}

Map<String, dynamic> _performanceMap(dynamic value) =>
    value is Map<String, dynamic> ? value : <String, dynamic>{};

List<T> _performanceItems<T>(
  dynamic value,
  T Function(Map<String, dynamic>) fromJson,
) {
  if (value is! List) return [];
  return value.whereType<Map<String, dynamic>>().map(fromJson).toList();
}

int _performanceInt(dynamic value) {
  if (value is num) return value.toInt();
  return int.tryParse(value?.toString() ?? '') ?? 0;
}

double _performanceDouble(dynamic value) {
  if (value is num) return value.toDouble();
  return double.tryParse(value?.toString() ?? '') ?? 0;
}
