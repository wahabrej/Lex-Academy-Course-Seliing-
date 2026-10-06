import 'package:flutter_test/flutter_test.dart';
import 'package:lexverse/features/AllPackages/model/package_content_models.dart';
import 'package:lexverse/features/AllPackages/model/performance_model.dart';
import 'package:lexverse/features/AllPackages/model/routine_model.dart';
import 'package:lexverse/features/AllPackages/model/syllabus_model.dart';
import 'package:lexverse/features/library/model/note_model.dart';
import 'package:lexverse/features/library/model/question_bank_model.dart';

void main() {
  group('Routine response models', () {
    test('parses routine stats and nested routine metadata', () {
      final stats = RoutineStatsResponse.fromJson({
        'success': true,
        'message': 'ok',
        'data': {
          'total_routine': 3,
          'done': 1,
          'remaining': 2,
          'next_exam_date': '2026-10-15T15:55:04.441Z',
        },
      });
      final routines = RoutineListResponse.fromJson({
        'success': true,
        'data': {
          'items': [
            {
              'id': 'routine-id',
              'program_type': 'bjs',
              'track': 'written',
              'routine_type': 'Exam',
              'routine_number': 'Routine #02',
              'exam_date': '2026-10-15T15:55:04.441Z',
              'academic_year': 2026,
              'session_label': 'Session 2026',
              'title': 'Mock Test',
              'description': 'Routine details',
              'file_mime_type': 'application/pdf',
              'file_path': '/routines/test.pdf',
              'file_url': 'https://example.test/test.pdf',
              'is_published': true,
              'package_id': 'package-id',
              'package': {'id': 'package-id', 'title': 'BJS Written'},
            },
          ],
          'meta': {'total': 1, 'page': 1, 'limit': 10, 'total_pages': 1},
        },
      });

      expect(stats.data?.totalRoutine, 3);
      expect(stats.data?.nextExamDate, '2026-10-15T15:55:04.441Z');
      expect(routines.items.single.routineType, 'Exam');
      expect(routines.items.single.routineNumber, 'Routine #02');
      expect(routines.items.single.package?.title, 'BJS Written');
      expect(routines.items.single.fileUrl, 'https://example.test/test.pdf');
      expect(routines.items.single.isPublished, isTrue);
    });
  });

  group('Syllabus response models', () {
    test('parses published syllabus, packages and file metadata', () {
      final response = SyllabusListResponse.fromJson({
        'success': true,
        'message': 'ok',
        'data': {
          'items': [
            {
              'id': 'syllabus-id',
              'created_at': '2026-10-01T14:24:17.466Z',
              'updated_at': '2026-10-01T14:24:17.466Z',
              'title': 'BJS syllabus',
              'track': 'preliminary',
              'content': 'Syllabus details',
              'file_path': '/syllabus/test.pdf',
              'file_mime_type': 'application/pdf',
              'is_published': true,
              'packages': [
                {'id': 'package-id', 'title': 'BJS Preliminary'},
              ],
            },
          ],
          'meta': {'total': 1, 'page': 1, 'limit': 10, 'total_pages': 1},
        },
      });

      expect(response.items.single.title, 'BJS syllabus');
      expect(response.items.single.track, 'preliminary');
      expect(response.items.single.packages.single.title, 'BJS Preliminary');
      expect(response.items.single.fileMimeType, 'application/pdf');
      expect(response.items.single.isPublished, isTrue);
    });
  });

  group('Note response models', () {
    test('parses price, lock state and associated packages', () {
      final response = NoteResponse.fromJson({
        'success': true,
        'message': 'ok',
        'data': {
          'items': [
            {
              'id': 'note-id',
              'title': 'General Knowledge Notes',
              'description': 'Preparation guide',
              'subject': 'general',
              'tier': 'premium',
              'price': 500,
              'discount_price': 400,
              'file_mime': 'application/pdf',
              'preview_file_path': '/notes/preview.pdf',
              'preview_file_mime': 'application/pdf',
              'packages': [
                {'id': 'package-id', 'title': 'BJS Written'},
              ],
              'download_count': 8,
              'is_locked': true,
              'created_at': '2026-10-01T14:48:08.027Z',
            },
          ],
          'meta': {'total': 1, 'page': 1, 'limit': 10, 'total_pages': 1},
        },
      });

      expect(response.data?.items.single.title, 'General Knowledge Notes');
      expect(response.data?.items.single.discountPrice, 400);
      expect(response.data?.items.single.packages.single.title, 'BJS Written');
      expect(response.data?.items.single.isLocked, isTrue);
      expect(response.data?.items.single.downloadCount, 8);
    });
  });

  group('Package content response models', () {
    test('parses announcement fields and package pagination', () {
      final response = AnnouncementListResponse.fromJson({
        'success': true,
        'message': 'ok',
        'data': {
          'items': [
            {
              'id': 'announcement-id',
              'title': 'Exam schedule update',
              'body': 'The exam starts at 10 AM.',
              'target_audience': 'students',
              'program': 'bjs',
              'priority_or_badge': 'urgent',
              'link': 'https://example.test/details',
              'is_pinned': true,
              'created_at': '2026-10-01T14:48:08.027Z',
            },
          ],
          'meta': {'total': 1, 'page': 1, 'limit': 10, 'total_pages': 1},
        },
      });

      expect(response.items.single.title, 'Exam schedule update');
      expect(response.items.single.isPinned, isTrue);
      expect(response.items.single.badge, 'urgent');
      expect(response.meta?.total, 1);
    });

    test('parses performance overview, accuracy and comparisons', () {
      final performance = UserPerformanceAnalytics.fromJson({
        'overview': {
          'questionsAnswered': 20,
          'correctAverage': 0.75,
          'topPerformanceGraph': [
            {'date': '2026-10-01', 'score': 15, 'accuracy': 0.75},
          ],
          'weakAreas': [
            {
              'subject_name': 'Evidence',
              'right': 2,
              'wrong': 3,
              'accuracy': 0.4,
            },
          ],
          'topicPerformance': [
            {'topic': 'Contracts', 'wrongCount': 2, 'totalQuestions': 5},
          ],
        },
        'subjectWiseAccuracy': [
          {'subject_name': 'Evidence', 'right': 2, 'wrong': 3, 'accuracy': 0.4},
        ],
        'programWiseAttempts': {
          'userOverallAverage': 15,
          'platformOverallAverage': 12,
          'examComparisonTable': [
            {
              'exam_id': 'exam-id',
              'exam_title': 'Model Test 1',
              'type': 'mock',
              'userScore': 15,
              'platformAverage': 12,
            },
          ],
        },
      });

      expect(performance.overview.questionsAnswered, 20);
      expect(performance.subjectWiseAccuracy.single.subjectName, 'Evidence');
      expect(performance.overview.topPerformanceGraph.single.score, 15);
      expect(
        performance.programWiseAttempts?.examComparisonTable.single.examTitle,
        'Model Test 1',
      );
    });

    test('parses question bank download count and nested package', () {
      final bank = QuestionBank.fromJson({
        'id': 'bank-id',
        'title': 'Previous Questions',
        'download_count': 7,
        'package_question_banks': [
          {
            'package': {
              'id': 'package-id',
              'title': 'BJS Preliminary',
              'price': '2500',
              'discount_price': '1999',
            },
          },
        ],
      });

      expect(bank.downloadCount, 7);
      expect(bank.associatedPackages.single.title, 'BJS Preliminary');
    });
  });
}
