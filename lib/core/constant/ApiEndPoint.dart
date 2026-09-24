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

  // Packages (Catalog & Enrollment)
  static const String packageCatalog = "$baseUrl/packages/catalog";
  static const String enrolledPackages = "$baseUrl/packages/enrolled";
  static const String liveExamsSummary = "$baseUrl/packages/live-exams-summary";
  static const String lockedCatalog = "$baseUrl/packages/locked-catalog";
  static const String packageAccessCounts = "$baseUrl/packages/access/counts";
  static const String packageAccess = "$baseUrl/packages/access";
  static String packageDetails(String id) => "$baseUrl/packages/$id";

  // --- Enrolled Package Specific Modules (User Content) ---

  // 1. Exams (Live/Archived/Past)
  static String liveExams(String packageId) => "$baseUrl/user/exams/package/$packageId/live";
  static String archivedExams(String packageId) => "$baseUrl/user/exams/package/$packageId/archived";
  static String pastExams(String packageId) => "$baseUrl/user/exams/package/mcq/$packageId/past-exams";

  // 2. Exam Attempts & Results
  static String examAttempts(String packageId) => "$baseUrl/user/exams/package/$packageId/attempts/paginated";
  static String submitExamAttempt(String attemptId) => "$baseUrl/user/exams/attempts/$attemptId/submit";
  static String examResults(String packageId) => "$baseUrl/user/exams/package/mcq/$packageId/results";

  // 3. Merit List
  static String meritList(String examId) => "$baseUrl/user/exams/package/mcq/exam/$examId/merit-list";

  // 4. Subject Breakdown
  static String subjectBreakdown(String packageId) => "$baseUrl/user/exams/package/mcq/$packageId/subject-breakdown";

  // 5. Routines
  static String routines(String packageId) => "$baseUrl/routines?packageId=$packageId";
  static String routineStats(String packageId) => "$baseUrl/routines/stats?packageId=$packageId";
  static String routinePinned(String packageId) => "$baseUrl/routines/pinned?packageId=$packageId";

  // 6. Syllabuses
  static String syllabuses(String packageId) => "$baseUrl/syllabuses?packageId=$packageId";
  static String syllabusDetails(String id) => "$baseUrl/syllabuses/$id";

  // 7. Announcements
  static String announcements(String packageId) => "$baseUrl/announcements/package/$packageId";

  // 8. Performance Analytics
  static String userPerformance(String packageId) => "$baseUrl/statistics/user/performance/$packageId";

  // --- Linked Contents (Notes, QBanks, References, Suggestions) ---

  // 9. Notes
  static String notesByPackage(String packageId) => "$baseUrl/notes?packageId=$packageId";
  static const String notes = "$baseUrl/notes";
  static String noteDetails(String id) => "$baseUrl/notes/$id";
  static String noteDownload(String id) => "$baseUrl/notes/$id/download";

  // 10. Question Banks
  static String questionBanksByPackage(String packageId) => "$baseUrl/question-banks?package_id=$packageId";
  static const String questionBanks = "$baseUrl/question-banks";
  static String questionBankDetails(String id) => "$baseUrl/question-banks/$id";
  static String questionBankDownload(String id) => "$baseUrl/question-banks/$id/download";
  static const String questionBankPrograms = "$baseUrl/question-banks/programs";
  static const String questionBankExams = "$baseUrl/question-banks/exams";
  static const String questionBankSubjects = "$baseUrl/question-banks/subjects";

  // 11. Book References
  static String bookReferences(String packageId) => "$baseUrl/book-references?packageId=$packageId";
  static String bookReferenceDetails(String id) => "$baseUrl/book-references/$id";

  // 12. Suggestions
  static String suggestionsByPackage(String packageId) => "$baseUrl/suggestions?packageId=$packageId";
  static const String suggestions = "$baseUrl/suggestions";
  static String suggestionDetails(String id) => "$baseUrl/suggestions/$id";

  // 13. Live Classes
  static String liveClasses(String packageId) => "$baseUrl/live-classes?packageId=$packageId";

  // --- General Library Items ---
  
  // Legal Research
  static const String legalResearch = "$baseUrl/legal-research";
  static String legalResearchDetails(String id) => "$baseUrl/legal-research/$id";

  // Articles
  static const String articles = "$baseUrl/articles";
  static const String articleTags = "$baseUrl/articles/tags";
  static String articleDetails(String slug) => "$baseUrl/articles/$slug";

  // Case References
  static const String caseReferences = "$baseUrl/case-references";
  static const String caseReferenceCategories = "$baseUrl/case-references/categories";
  static const String caseReferenceCourts = "$baseUrl/case-references/courts";
  static String caseReferenceDownload(String idOrSlug) => "$baseUrl/case-references/$idOrSlug/download";
}
