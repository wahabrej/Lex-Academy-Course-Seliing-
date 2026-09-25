class ApiEndPoint {
  static const String baseUrl = "https://api.lexacademy.cloud/api";
  
  // Auth
  static const String register = "$baseUrl/auth/register";
  static const String login = "$baseUrl/auth/login";
  static const String me = "$baseUrl/auth/me";
  static const String refreshTokens = "$baseUrl/auth/refresh-tokens";
  static const String logout = "$baseUrl/auth/logout";
  static const String devices = "$baseUrl/auth/devices";
  static const String logoutAll = "$baseUrl/auth/logout-all";
  static const String updateProfile = "$baseUrl/auth/update";
  static const String verifyEmail = "$baseUrl/auth/verify-email";
  static const String resendVerificationEmail = "$baseUrl/auth/resend-verification-email";
  static const String forgotPassword = "$baseUrl/auth/forgot-password";
  static const String resetPassword = "$baseUrl/auth/reset-password";
  static const String changePassword = "$baseUrl/auth/change-password";

  // Legal Dictionary
  static const String legalDictionary = "$baseUrl/legal-dictionary";

  // Flashcards & Decks
  static const String flashcardDecks = "$baseUrl/flashcard-decks";
  static const String flashcardCategories = "$baseUrl/flashcard-decks/categories";
  static String flashcardDeckDetails(String id) => "$baseUrl/flashcard-decks/$id";

  // Bare Acts
  static const String bareActs = "$baseUrl/bare-acts";
  static const String bareActCategories = "$baseUrl/bare-acts/categories";
  static String bareActDownload(String id) => "$baseUrl/bare-acts/$id/download";

  // Question Banks
  static const String questionBanks = "$baseUrl/question-banks";
  static const String questionBankPrograms = "$baseUrl/question-banks/programs";
  static const String questionBankExams = "$baseUrl/question-banks/exams";
  static const String questionBankSubjects = "$baseUrl/question-banks/subjects";
  static String questionBankDownload(String id) => "$baseUrl/question-banks/$id/download";

  // Notes
  static const String notes = "$baseUrl/notes";
  static String noteDetails(String id) => "$baseUrl/notes/$id";
  static String noteDownload(String id) => "$baseUrl/notes/$id/download";

  // Packages (Catalog & Enrollment)
  static const String packageCatalog = "$baseUrl/packages/catalog";
  static const String enrolledPackages = "$baseUrl/packages/enrolled";
  static const String liveExamsSummary = "$baseUrl/packages/live-exams-summary";
  static const String lockedCatalog = "$baseUrl/packages/locked-catalog";
  static const String packageAccessCounts = "$baseUrl/packages/access/counts";
  static const String packageAccess = "$baseUrl/packages/access";
  static String packageDetails(String id) => "$baseUrl/packages/$id";

  // --- Enrolled Package Modules (User Specific) ---

  // 1. Exams
  static String liveExams(String packageId) => "$baseUrl/user/exams/package/$packageId/live";
  static String archivedExams(String packageId) => "$baseUrl/user/exams/package/$packageId/archived";
  static String pastExams(String packageId) => "$baseUrl/user/exams/package/mcq/$packageId/past-exams";
  
  static String startExam(String packageId, String examId) => "$baseUrl/user/exams/package/$packageId/exams/$examId/start";
  static String examDetailsWithAnswers(String packageId, String examId) => "$baseUrl/user/exams/package/$packageId/exams/$examId/details-with-answers";

  // 2. Exam Attempts & Results
  static String examAttempts(String packageId) => "$baseUrl/user/exams/package/$packageId/attempts/paginated";
  static String examStatsAggregate(String packageId) => "$baseUrl/user/exams/package/$packageId/statistics/aggregate";
  static String attemptDetails(String attemptId) => "$baseUrl/user/exams/attempts/$attemptId";
  static String submitAnswer(String attemptId) => "$baseUrl/user/exams/attempts/$attemptId/answers";
  static String submitExamAttempt(String attemptId) => "$baseUrl/user/exams/attempts/$attemptId/submit";
  
  static const String submitWrittenExam = "$baseUrl/user/exams/written/submit";
  static const String requestWrittenResubmission = "$baseUrl/user/exams/written/resubmission-request";

  static String examResults(String packageId) => "$baseUrl/user/exams/package/mcq/$packageId/results";

  // 3. Merit List & 4. Subject Breakdown
  static String meritList(String examId) => "$baseUrl/user/exams/package/mcq/exam/$examId/merit-list";
  static String subjectBreakdown(String packageId) => "$baseUrl/user/exams/package/mcq/$packageId/subject-breakdown";

  // 5. Routines
  static const String baseRoutines = "$baseUrl/routines";
  static const String routineStats = "$baseUrl/routines/stats";
  static const String routinePinned = "$baseUrl/routines/pinned";
  static String routineDetails(String id) => "$baseUrl/routines/$id";

  // 6. Syllabuses
  static const String baseSyllabuses = "$baseUrl/syllabuses";
  static String syllabuses(String packageId) => "$baseSyllabuses?packageId=$packageId";
  static String syllabusDetails(String id) => "$baseSyllabuses/$id";

  // 7. Announcements / Notice
  static String announcements(String packageId) => "$baseUrl/announcements/package/$packageId";

  // 8. Performance Analytics
  static String userPerformance(String packageId) => "$baseUrl/statistics/user/performance/$packageId";

  // 9. Notes & 10. Question Banks
  static String packageNotes(String packageId) => "$baseUrl/notes?packageId=$packageId";
  static String packageQuestionBanks(String packageId) => "$baseUrl/question-banks?package_id=$packageId";

  // 11. Book References & 12. Suggestions
  static String bookReferences(String packageId) => "$baseUrl/book-references?packageId=$packageId";
  static String suggestions(String packageId) => "$baseUrl/suggestions?packageId=$packageId";

  // --- General Library Items ---
  static const String legalResearch = "$baseUrl/legal-research";
  static String legalResearchDetails(String id) => "$baseUrl/legal-research/$id";
  static const String articles = "$baseUrl/articles";
  static const String articleTags = "$baseUrl/articles/tags";
  static String articleDetails(String slug) => "$baseUrl/articles/$slug";
  static const String caseReferences = "$baseUrl/case-references";
  static const String caseReferenceCategories = "$baseUrl/case-references/categories";
  static const String caseReferenceCourts = "$baseUrl/case-references/courts";
  static String caseReferenceDownload(String idOrSlug) => "$baseUrl/case-references/$idOrSlug/download";
}
