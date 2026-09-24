import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;
import 'legal_dictionary_screen.dart';
import '../viewModel/flashcard_view_model.dart';
import '../model/flashcard_model.dart';
import '../viewModel/bare_acts_view_model.dart';
import '../model/bare_acts_model.dart';
import '../viewModel/legal_research_view_model.dart';
import '../model/legal_research_model.dart';
import '../viewModel/case_reference_view_model.dart';
import '../model/case_reference_model.dart';
import '../viewModel/question_bank_view_model.dart';
import '../model/question_bank_model.dart';
import '../viewModel/article_view_model.dart';
import '../model/article_model.dart';
import '../viewModel/note_view_model.dart';
import '../model/note_model.dart';
import '../../parentScreen/viewModel/parentScreenProvider.dart';

// ─── Color Palette ──────────────────────────────────────────────────────────
const Color _bg = Color(0xFFF5F7FA);
const Color _white = Color(0xFFFFFFFF);
const Color _navy = Color(0xFF072B3E); 
const Color _navyLight = Color(0xFF16324F);
const Color _textPrimary = Color(0xFF0F2137);
const Color _textSecondary = Color(0xFF6B7A99);
const Color _gold = Color(0xFFF5B301);
const Color _goldLight = Color(0xFFFFF4D6);
const Color _teal = Color(0xFF199A8E);
const Color _cardBorder = Color(0xFFE8ECF5);
const Color _tabBg = Color(0xFFF0F2F8);

enum ContentType { notes, books, articles }

// ─── Main Library Screen Entry ──────────────────────────────────────────────
class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  final List<String> _tabs = ['Hub', 'Library', 'Flashcards', 'QBank', 'Bare Acts', 'Research', 'Cases', 'Dictionary'];

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ParentScreenProvider>();
    final currentTab = provider.libraryTabIndex;

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(_tabs[currentTab]),
            _buildTopTabs(currentTab, provider),
            Expanded(
              child: IndexedStack(
                index: currentTab,
                children: [
                  _HubPage(onTabSwitch: (idx) => provider.setLibraryTab(idx)),
                  _LibraryMainPage(),
                  _FlashcardsTabPage(),
                  _QuestionBankTabPage(),
                  _BareActsTabPage(),
                  _LegalResearchTabPage(),
                  _CaseReferencesTabPage(),
                  const LegalDictionaryScreen(isTab: true),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar(String title) {
    return Container(
      color: _white,
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: _bg, borderRadius: BorderRadius.circular(12), border: Border.all(color: _cardBorder),
            ),
            child: IconButton(
              padding: EdgeInsets.zero,
              icon: const Icon(Icons.arrow_back_ios_new_rounded, color: _textPrimary, size: 16),
              onPressed: () => Navigator.maybePop(context),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title == 'Hub' ? 'Study Hub' : title,
            style: const TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }

  Widget _buildTopTabs(int currentTab, ParentScreenProvider provider) {
    return Container(
      color: _white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: _tabs.asMap().entries.map((e) {
            final active = e.key == currentTab;
            return GestureDetector(
              onTap: () => provider.setLibraryTab(e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: active ? _navy : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: active ? _navy : _cardBorder),
                ),
                child: Row(
                  children: [
                    Icon(_tabIcon(e.key), size: 14, color: active ? _white : _textSecondary),
                    const SizedBox(width: 6),
                    Text(
                      e.value,
                      style: TextStyle(
                        fontSize: 12, 
                        fontWeight: active ? FontWeight.w700 : FontWeight.w500, 
                        color: active ? _white : _textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  IconData _tabIcon(int i) {
    switch (i) {
      case 0: return Icons.home_rounded;
      case 1: return Icons.local_library_rounded;
      case 2: return Icons.style_rounded;
      case 3: return Icons.quiz_rounded;
      case 4: return Icons.gavel_rounded;
      case 5: return Icons.border_inner_outlined;
      case 6: return Icons.account_balance_rounded;
      default: return Icons.menu_book_outlined;
    }
  }
}

// ─── Hub Page Content ────────────────────────────────────────────────────────
class _HubPage extends StatelessWidget {
  final Function(int) onTabSwitch;
  const _HubPage({super.key, required this.onTabSwitch});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            decoration: const BoxDecoration(color: _navy),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Study Materials', style: TextStyle(color: _white, fontSize: 24, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                const Text('Your single hub for reading, practising and reference –\nacross BJS, BAR and LL.B.', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 13, height: 1.5)),
                const SizedBox(height: 20),
                _SearchFieldPlaceholder(hint: 'Search materials, acts...', light: false),
              ],
            ),
          ),
          const SizedBox(height: 12),
          _buildSectionHeader('Read', '3'),
          _HubCard(icon: Icons.local_library_rounded, iconBg: _navyLight, title: 'Study Library', subtitle: 'Books, notes & curated articles.', onTap: () => onTabSwitch(1)),
          const SizedBox(height: 12),
          _HubCard(icon: Icons.school_rounded, iconBg: _teal, title: 'Courses', subtitle: 'Structured video lessons & syllabi.', actionLabel: 'Open'),
          const SizedBox(height: 12),
          _HubCard(icon: Icons.trending_up_rounded, iconBg: const Color(0xFF2ECC71), title: 'Exam Trends', subtitle: 'Past-paper analytics by subject & year.', badge: '0 Items'),
          const SizedBox(height: 24),
          _buildSectionHeader('Practice', '2'),
          _HubCard(icon: Icons.style_rounded, iconBg: const Color(0xFF9B59B6), title: 'Flashcards', subtitle: 'Active recall decks for quick revision.', badge: 'Active', onTap: () => onTabSwitch(2)),
          const SizedBox(height: 12),
          _HubCard(icon: Icons.quiz_rounded, iconBg: _gold, title: 'Question Bank', subtitle: 'BJS / BAR past papers & subject sets.', badge: 'Active', onTap: () => onTabSwitch(3)),
          const SizedBox(height: 24),
          _buildSectionHeader('Reference', '4'),
          _HubCard(icon: Icons.gavel_rounded, iconBg: _navyLight, title: 'Bare Acts', subtitle: 'Searchable statutes with explanations.', onTap: () => onTabSwitch(4)),
          const SizedBox(height: 12),
          _HubCard(icon: Icons.border_inner, iconBg: _navyLight, title: 'Legal Research', subtitle: 'Articles, papers and analyses.', onTap: () => onTabSwitch(5)),
          const SizedBox(height: 12),
          _HubCard(icon: Icons.account_balance_rounded, iconBg: _navyLight, title: 'Case References', subtitle: 'Landmark judgments & summaries.', badge: 'Active', onTap: () => onTabSwitch(6)),
          const SizedBox(height: 12),
          _HubCard(icon: Icons.menu_book_outlined, iconBg: _navyLight, title: 'Legal Dictionary', subtitle: 'Bilingual EN/BN legal terminology.', badge: 'Active', onTap: () => onTabSwitch(7)),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, String count) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
      child: Row(
        children: [
          Text(title, style: const TextStyle(color: _textPrimary, fontSize: 18, fontWeight: FontWeight.w700)),
          const SizedBox(width: 10),
          Container(width: 24, height: 24, decoration: const BoxDecoration(color: _gold, shape: BoxShape.circle), alignment: Alignment.center, child: Text(count, style: const TextStyle(color: _textPrimary, fontSize: 12, fontWeight: FontWeight.w700))),
        ],
      ),
    );
  }
}

// ─── Unified Library Main Page (Notes, Books, Articles Sub-Tabs) ───────────────
class _LibraryMainPage extends StatefulWidget {
  @override
  State<_LibraryMainPage> createState() => _LibraryMainPageState();
}

class _LibraryMainPageState extends State<_LibraryMainPage> {
  ContentType _selectedType = ContentType.articles;
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ArticleViewModel>().fetchArticles(isRefresh: true);
      context.read<ArticleViewModel>().fetchTags();
      context.read<NoteViewModel>().fetchNotes(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final articleVm = context.watch<ArticleViewModel>();
    final noteVm = context.watch<NoteViewModel>();

    return Column(
      children: [
        Container(
          color: _white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: ContentType.values.map((type) {
              final active = _selectedType == type;
              String label = type.name[0].toUpperCase() + type.name.substring(1);
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _selectedType = type),
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(color: active ? _navy : _tabBg, borderRadius: BorderRadius.circular(8)),
                    alignment: Alignment.center,
                    child: Text(label, style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: active ? _white : _textSecondary)),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          color: _white,
          child: _SearchFieldPlaceholder(
            hint: 'Search ${_selectedType.name}...',
            light: true,
            onChanged: (v) {
              if (_selectedType == ContentType.articles) {
                articleVm.updateFilters(search: v);
                articleVm.fetchArticles(isRefresh: true);
              } else if (_selectedType == ContentType.notes) {
                noteVm.updateFilters(search: v);
                noteVm.fetchNotes(isRefresh: true);
              }
            },
          ),
        ),
        if (_selectedType == ContentType.articles && articleVm.tags.isNotEmpty)
          Container(
            height: 40,
            color: _white,
            padding: const EdgeInsets.only(bottom: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: articleVm.tags.length + 1,
              itemBuilder: (context, index) {
                final isAll = index == 0;
                final tag = isAll ? 'All Tags' : articleVm.tags[index - 1];
                final active = isAll ? articleVm.selectedTag.isEmpty : articleVm.selectedTag == tag;
                return GestureDetector(
                  onTap: () {
                    articleVm.updateFilters(tag: isAll ? '' : tag);
                    articleVm.fetchArticles(isRefresh: true);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(color: active ? _gold : _white, borderRadius: BorderRadius.circular(16), border: Border.all(color: active ? _gold : _cardBorder)),
                    alignment: Alignment.center,
                    child: Text(tag, style: TextStyle(color: active ? _navy : _textSecondary, fontSize: 12, fontWeight: active ? FontWeight.bold : FontWeight.w500)),
                  ),
                );
              },
            ),
          ),
        Expanded(
          child: Builder(
            builder: (context) {
              if (_selectedType == ContentType.articles) {
                return articleVm.isLoading && articleVm.articles.isEmpty
                    ? const Center(child: CircularProgressIndicator(color: _navy))
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: articleVm.articles.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 16),
                        itemBuilder: (context, idx) => _buildArticleCard(context, articleVm.articles[idx]),
                      );
              } else if (_selectedType == ContentType.notes) {
                return noteVm.isLoading && noteVm.notes.isEmpty
                    ? const Center(child: CircularProgressIndicator(color: _navy))
                    : ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: noteVm.notes.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 12),
                        itemBuilder: (context, idx) => _buildNoteCard(context, noteVm.notes[idx]),
                      );
              } else {
                return const Center(child: Text('No books available.'));
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildNoteCard(BuildContext context, Note note) {
    return _buildLibraryItemCard(
      context: context,
      title: note.title,
      subtitle: note.description,
      tag: note.subject,
      icon: Icons.note_alt_rounded,
      onTap: () => _viewNoteDetails(context, note.id),
    );
  }

  void _viewNoteDetails(BuildContext context, String id) async {
    final vm = context.read<NoteViewModel>();
    showDialog(context: context, barrierDismissible: false, builder: (ctx) => const Center(child: CircularProgressIndicator(color: _navy)));
    bool success = await vm.fetchNoteDetail(id);
    if (!mounted) return;
    Navigator.pop(context);
    if (success && vm.selectedNote != null) {
      final n = vm.selectedNote!;
      _showDetailSheet(context, n.title, "Subject: ${n.subject}\n\nDescription: ${n.description}", downloadUrl: vm.getNoteDownloadUrl(n.id));
    }
  }

  Widget _buildArticleCard(BuildContext context, Article article) {
    return Container(
      decoration: BoxDecoration(color: _white, borderRadius: BorderRadius.circular(16), border: Border.all(color: _cardBorder), boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 8, offset: const Offset(0, 4))]),
      child: InkWell(
        onTap: () => _viewArticleDetails(context, article.slug),
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (article.coverImage != null)
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: Image.network(article.coverImage!, height: 160, width: double.infinity, fit: BoxFit.cover, errorBuilder: (_, __, ___) => Container(height: 160, color: _tabBg, child: const Icon(Icons.image_not_supported))),
              ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: _goldLight, borderRadius: BorderRadius.circular(6)),
                    child: Text(article.category.toUpperCase(), style: const TextStyle(color: _gold, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  Text(article.title, style: const TextStyle(color: _textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 6),
                  Text(article.excerpt, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _textSecondary, fontSize: 13, height: 1.5)),
                  const SizedBox(height: 12),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Read More', style: TextStyle(color: _navy, fontWeight: FontWeight.bold, fontSize: 13)),
                      SizedBox(width: 4),
                      Icon(Icons.arrow_forward_rounded, size: 16, color: _navy),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _viewArticleDetails(BuildContext context, String slug) async {
    final vm = context.read<ArticleViewModel>();
    showDialog(context: context, barrierDismissible: false, builder: (ctx) => const Center(child: CircularProgressIndicator(color: _navy)));
    bool success = await vm.fetchArticleDetail(slug);
    if (!mounted) return;
    Navigator.pop(context);
    if (success && vm.selectedArticle != null) {
      final art = vm.selectedArticle!;
      _showDetailSheet(context, art.title, art.content?.replaceAll(RegExp(r'<[^>]*>'), '') ?? art.excerpt);
    }
  }
}

// ─── Flashcards Tab Content (Screen 1) ──────────────────────────────────────────────────
class _FlashcardsTabPage extends StatefulWidget {
  @override State<_FlashcardsTabPage> createState() => _FlashcardsTabPageState();
}
class _FlashcardsTabPageState extends State<_FlashcardsTabPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<FlashcardViewModel>();
      vm.fetchCategories();
      vm.fetchDecks(isRefresh: true);
    });
  }
  @override Widget build(BuildContext context) {
    final vm = context.watch<FlashcardViewModel>();
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
          decoration: const BoxDecoration(color: _navy),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Flashcards', style: TextStyle(color: _white, fontSize: 24, fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              const Text('Study with interactive flashcards', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 13)),
              const SizedBox(height: 20),
              _SearchFieldPlaceholder(
                hint: 'Search decks...',
                light: false,
                onChanged: (v) {
                  vm.updateFilters(search: v);
                  vm.fetchDecks(isRefresh: true);
                },
              ),
            ],
          ),
        ),
        if (vm.categories.isNotEmpty)
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: vm.categories.length + 1,
              itemBuilder: (context, i) {
                final isAll = i == 0;
                final cat = isAll ? 'All' : vm.categories[i-1];
                final active = isAll ? vm.selectedCategory.isEmpty : vm.selectedCategory == cat;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: active,
                    onSelected: (val) {
                      vm.updateFilters(category: isAll ? '' : cat);
                      vm.fetchDecks(isRefresh: true);
                    },
                    selectedColor: _gold,
                    labelStyle: TextStyle(color: active ? _navy : _textSecondary, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                );
              },
            ),
          ),
        Expanded(
          child: vm.isLoading 
            ? const Center(child: CircularProgressIndicator(color: _navy)) 
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: vm.decks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final deck = vm.decks[i];
                  return _buildDeckCard(context, deck);
                },
              ),
        ),
      ],
    );
  }

  Widget _buildDeckCard(BuildContext context, FlashcardDeck deck) {
    return Container(
      decoration: BoxDecoration(
        color: _navy,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20, top: -20,
            child: Icon(Icons.style_rounded, size: 100, color: Colors.white.withOpacity(0.05)),
          ),
          InkWell(
            onTap: () async {
              showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator(color: _gold)));
              bool ok = await context.read<FlashcardViewModel>().fetchDeckDetail(deck.id);
              if (mounted) Navigator.pop(context);
              if (ok) {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const FlashcardStudyScreen()));
              }
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(Icons.folder_open_rounded, color: _gold, size: 24),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                        child: Text("${deck.flashcardCount} cards", style: const TextStyle(color: _white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Text(deck.title, style: const TextStyle(color: _white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(deck.category, style: TextStyle(color: Colors.white.withOpacity(0.6), fontSize: 13)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Flashcard Study Screen (Screen 2 - Full Screen) ──────────────────────────────────
class FlashcardStudyScreen extends StatelessWidget {
  const FlashcardStudyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FlashcardViewModel>();
    final deck = vm.selectedDeck;
    if (deck == null || vm.studyCards.isEmpty) return const Scaffold(body: Center(child: Text("No cards found")));

    final currentCard = vm.studyCards[vm.currentCardIndex];
    final total = vm.studyCards.length;

    return Scaffold(
      backgroundColor: _navy,
      appBar: AppBar(
        backgroundColor: _navy, elevation: 0,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios, color: _white), onPressed: () => Navigator.pop(context)),
        title: const Text("Flashcards", style: TextStyle(color: _white, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Question ${vm.currentCardIndex + 1}/$total", style: const TextStyle(color: Color(0xB3FFFFFF), fontWeight: FontWeight.bold)),
                Text(deck.category, style: const TextStyle(color: _gold, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GestureDetector(
              onTap: () => vm.flipCard(),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 400),
                  tween: Tween<double>(begin: 0, end: vm.isFlipped ? 180 : 0),
                  builder: (context, double value, child) {
                    return Transform(
                      transform: Matrix4.identity()..setEntry(3, 2, 0.001)..rotateY(value * math.pi / 180),
                      alignment: Alignment.center,
                      child: value < 90 
                        ? _buildCardSide(currentCard.frontText, "Tap to flip", currentCard.frontImage)
                        : Transform(
                            transform: Matrix4.identity()..rotateY(math.pi),
                            alignment: Alignment.center,
                            child: _buildCardSide(currentCard.backText, "Tap to see question", currentCard.backImage),
                          ),
                    );
                  },
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _circleBtn(Icons.arrow_back, vm.currentCardIndex > 0 ? () => vm.previousCard() : null),
                    const SizedBox(width: 16),
                    _circleBtn(Icons.shuffle, () => vm.shuffleCards()),
                    const SizedBox(width: 16),
                    _circleBtn(Icons.refresh, () => vm.resetDeck()),
                    const SizedBox(width: 16),
                    _circleBtn(Icons.arrow_forward, vm.currentCardIndex < total - 1 ? () => vm.nextCard() : null),
                  ],
                ),
                const SizedBox(height: 20),
                const Text("Use ← → to navigate  •  Click card to flip", style: TextStyle(color: Color(0x80FFFFFF), fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardSide(String text, String hint, String? imageUrl) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: _white, borderRadius: BorderRadius.circular(24),
        border: const Border(bottom: BorderSide(color: _gold, width: 8)),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, offset: const Offset(0, 10))],
      ),
      padding: const EdgeInsets.all(32),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageUrl != null && imageUrl.isNotEmpty)
             Expanded(child: ClipRRect(borderRadius: BorderRadius.circular(12), child: Image.network(imageUrl, fit: BoxFit.contain, errorBuilder: (_,__,___) => const SizedBox()))),
          const SizedBox(height: 20),
          Text(text, textAlign: TextAlign.center, style: const TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold, height: 1.4)),
          const SizedBox(height: 40),
          Text(hint.toUpperCase(), style: const TextStyle(color: _gold, fontSize: 11, fontWeight: FontWeight.w800, letterSpacing: 1.2)),
        ],
      ),
    );
  }

  Widget _circleBtn(IconData icon, VoidCallback? onTap) {
    return Opacity(
      opacity: onTap == null ? 0.3 : 1.0,
      child: InkWell(
        onTap: onTap, borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 56, height: 56,
          decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), shape: BoxShape.circle),
          child: Icon(icon, color: _white, size: 24),
        ),
      ),
    );
  }
}

class _QuestionBankTabPage extends StatefulWidget {
  @override State<_QuestionBankTabPage> createState() => _QuestionBankTabPageState();
}
class _QuestionBankTabPageState extends State<_QuestionBankTabPage> {
  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<QuestionBankViewModel>().fetchQuestionBanks(isRefresh: true);
    });
  }
  @override Widget build(BuildContext context) {
    final vm = context.watch<QuestionBankViewModel>();
    return vm.isLoading 
      ? const Center(child: CircularProgressIndicator(color: _navy)) 
      : ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: vm.items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final item = vm.items[i];
            return _buildLibraryItemCard(
              context: context,
              title: item.title,
              subtitle: "${item.subject} • ${item.year}",
              tag: item.programType,
              icon: Icons.quiz_rounded,
              onTap: () async {
                showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator(color: _navy)));
                bool ok = await vm.fetchBankDetail(item.id);
                if (mounted) Navigator.pop(context);
                if (ok) _showDetailSheet(context, item.title, "Subject: ${item.subject}\nYear: ${item.year}\nProgram: ${item.programType}\n\nDescription: ${vm.selectedBank?.description ?? ''}");
              },
            );
          },
        );
  }
}

class _BareActsTabPage extends StatefulWidget {
  @override State<_BareActsTabPage> createState() => _BareActsTabPageState();
}
class _BareActsTabPageState extends State<_BareActsTabPage> {
  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<BareActsViewModel>().fetchBareActs(isRefresh: true);
    });
  }
  @override Widget build(BuildContext context) {
    final vm = context.watch<BareActsViewModel>();
    return vm.isLoading 
      ? const Center(child: CircularProgressIndicator(color: _navy)) 
      : ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: vm.bareActs.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final act = vm.bareActs[i];
            return _buildLibraryItemCard(
              context: context,
              title: act.title,
              subtitle: "Click to read full statute",
              tag: act.category,
              icon: Icons.gavel_rounded,
              onTap: () async {
                showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator(color: _navy)));
                bool ok = await vm.fetchBareActDetail(act.id);
                if (mounted) Navigator.pop(context);
                if (ok && vm.selectedBareAct != null) {
                  _showDetailSheet(context, vm.selectedBareAct!.title, vm.selectedBareAct!.contentPlain);
                }
              },
            );
          },
        );
  }
}

class _LegalResearchTabPage extends StatefulWidget {
  @override State<_LegalResearchTabPage> createState() => _LegalResearchTabPageState();
}
class _LegalResearchTabPageState extends State<_LegalResearchTabPage> {
  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LegalResearchViewModel>().fetchResearchPapers(isRefresh: true);
    });
  }
  @override Widget build(BuildContext context) {
    final vm = context.watch<LegalResearchViewModel>();
    return vm.isLoading 
      ? const Center(child: CircularProgressIndicator(color: _navy)) 
      : ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: vm.papers.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final paper = vm.papers[i];
            return _buildLibraryItemCard(
              context: context,
              title: paper.title,
              subtitle: "By ${paper.author}",
              tag: "Research Paper",
              icon: Icons.description_rounded,
              onTap: () async {
                showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator(color: _navy)));
                bool ok = await vm.fetchPaperDetail(paper.id);
                if (mounted) Navigator.pop(context);
                if (ok && vm.selectedPaper != null) {
                  _showDetailSheet(context, vm.selectedPaper!.title, "Author: ${vm.selectedPaper!.author}\n\nAbstract: ${vm.selectedPaper!.abstract}\n\n${vm.selectedPaper!.bodyMd.replaceAll(RegExp(r'<[^>]*>'), '')}");
                }
              },
            );
          },
        );
  }
}

class _CaseReferencesTabPage extends StatefulWidget {
  @override State<_CaseReferencesTabPage> createState() => _CaseReferencesTabPageState();
}
class _CaseReferencesTabPageState extends State<_CaseReferencesTabPage> {
  @override void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CaseReferenceViewModel>().fetchCaseReferences(isRefresh: true);
    });
  }
  @override Widget build(BuildContext context) {
    final vm = context.watch<CaseReferenceViewModel>();
    return vm.isLoading 
      ? const Center(child: CircularProgressIndicator(color: _navy)) 
      : ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: vm.items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, i) {
            final item = vm.items[i];
            return _buildLibraryItemCard(
              context: context,
              title: item.title,
              subtitle: "${item.court} • ${item.year}",
              tag: item.category,
              icon: Icons.account_balance_rounded,
              onTap: () async {
                showDialog(context: context, barrierDismissible: false, builder: (_) => const Center(child: CircularProgressIndicator(color: _navy)));
                bool ok = await vm.fetchCaseDetail(item.id);
                if (mounted) Navigator.pop(context);
                if (ok && vm.selectedCase != null) {
                  _showDetailSheet(context, vm.selectedCase!.title, "Court: ${vm.selectedCase!.court}\nCitation: ${vm.selectedCase!.citation}\nYear: ${vm.selectedCase!.year}\n\nSummary: ${vm.selectedCase!.summary}");
                }
              },
            );
          },
        );
  }
}

// ─── Helper Widgets ──────────────────────────────────────────────────────────

Widget _buildLibraryItemCard({required BuildContext context, required String title, required String subtitle, required String tag, required IconData icon, required VoidCallback onTap}) {
  return Container(
    decoration: BoxDecoration(
      color: _white, borderRadius: BorderRadius.circular(16),
      border: Border.all(color: _cardBorder),
      boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10, offset: const Offset(0, 4))],
    ),
    child: InkWell(
      onTap: onTap, borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(color: _tabBg, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: _navy, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(color: _goldLight, borderRadius: BorderRadius.circular(6)),
                    child: Text(tag.toUpperCase(), style: const TextStyle(color: _gold, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(height: 8),
                  Text(title, style: const TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.bold), maxLines: 2, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(subtitle, style: const TextStyle(color: _textSecondary, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: _textSecondary),
          ],
        ),
      ),
    ),
  );
}

void _showDetailSheet(BuildContext context, String title, String body, {String? downloadUrl}) {
  showModalBottomSheet(
    context: context, isScrollControlled: true, backgroundColor: Colors.transparent,
    builder: (context) => Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(color: _white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _navy))),
              IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
            ],
          ),
          const Divider(),
          const SizedBox(height: 16),
          Expanded(child: SingleChildScrollView(child: Text(body, style: const TextStyle(fontSize: 14, height: 1.6, color: _textPrimary)))),
          const SizedBox(height: 24),
          Row(
            children: [
              if (downloadUrl != null) ...[
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      final url = Uri.parse(downloadUrl);
                      if (!await launchUrl(url, mode: LaunchMode.externalApplication)) debugPrint("Could not launch $url");
                    },
                    icon: const Icon(Icons.download, color: _white),
                    style: ElevatedButton.styleFrom(backgroundColor: _teal, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), minimumSize: const Size(0, 48)),
                    label: const Text("Download PDF", style: TextStyle(color: _white, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(backgroundColor: _navy, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), minimumSize: const Size(0, 48)),
                  child: const Text("Close", style: TextStyle(color: _white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          )
        ],
      ),
    ),
  );
}

class _HubCard extends StatelessWidget {
  final IconData icon; final Color iconBg; final String title; final String subtitle; final String? badge; final String? actionLabel; final VoidCallback? onTap;
  const _HubCard({required this.icon, required this.iconBg, required this.title, required this.subtitle, this.badge, this.actionLabel, this.onTap});
  @override Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: _white, borderRadius: BorderRadius.circular(16), border: Border.all(color: _cardBorder)),
        child: Row(
          children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: iconBg, borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: _white, size: 22)),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(title, style: const TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.w700)), Text(subtitle, style: const TextStyle(color: _textSecondary, fontSize: 12))])),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: _textSecondary),
          ],
        ),
      ),
    );
  }
}

class _SearchFieldPlaceholder extends StatelessWidget {
  final String hint; final bool light; final ValueChanged<String>? onChanged;
  const _SearchFieldPlaceholder({required this.hint, required this.light, this.onChanged});
  @override Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(color: light ? _tabBg : Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
      child: TextField(
        onChanged: onChanged,
        style: TextStyle(color: light ? _textPrimary : _white),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: light ? _textSecondary : Colors.white.withOpacity(0.5), fontSize: 13),
          prefixIcon: Icon(Icons.search, color: light ? _textSecondary : Colors.white.withOpacity(0.5), size: 20),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 11),
        ),
      ),
    );
  }
}
