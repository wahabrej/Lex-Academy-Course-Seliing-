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
}
