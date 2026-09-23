class ApiEndPoint {
  static const String baseUrl = "https://api.lexacademy.cloud/api";
  
  // Auth
  static const String register = "$baseUrl/auth/register";
  static const String login = "$baseUrl/auth/login";
  static const String me = "$baseUrl/auth/me";

  // Legal Dictionary
  static const String legalDictionary = "$baseUrl/legal-dictionary";

  // Flashcards & Decks
  static const String flashcardDecks = "$baseUrl/flashcard-decks";
  static const String flashcardCategories = "$baseUrl/flashcard-decks/categories";

  // Bare Acts
  static const String bareActs = "$baseUrl/bare-acts";
  static const String bareActCategories = "$baseUrl/bare-acts/categories";
  static String bareActDownload(String id) => "$baseUrl/bare-acts/$id/download";

  // Packages
  static const String packageCatalog = "$baseUrl/packages/catalog";
  static const String enrolledPackages = "$baseUrl/packages/enrolled";
  static const String liveExamsSummary = "$baseUrl/packages/live-exams-summary";
  static const String lockedCatalog = "$baseUrl/packages/locked-catalog";
  static const String packageAccessCounts = "$baseUrl/packages/access/counts";
  static const String packageAccess = "$baseUrl/packages/access";
  static String packageDetails(String id) => "$baseUrl/packages/$id";

  // Legal Research
  static const String legalResearch = "$baseUrl/legal-research";

  // Case References
  static const String caseReferences = "$baseUrl/case-references";
  static const String caseReferenceCategories = "$baseUrl/case-references/categories";
  static const String caseReferenceCourts = "$baseUrl/case-references/courts";
  static String caseReferenceDownload(String idOrSlug) => "$baseUrl/case-references/$idOrSlug/download";

  // Question Banks
  static const String questionBanks = "$baseUrl/question-banks";
  static const String questionBankPrograms = "$baseUrl/question-banks/programs";
  static const String questionBankExams = "$baseUrl/question-banks/exams";
  static const String questionBankSubjects = "$baseUrl/question-banks/subjects";
  static String questionBankDownload(String id) => "$baseUrl/question-banks/$id/download";
}
