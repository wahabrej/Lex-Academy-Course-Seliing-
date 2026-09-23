import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
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

// ─── Shared Models ──────────────────────────────────────────────────────────
enum ContentType { notes, books, articles }
enum AccessType { free, premium }

class StudyItem {
  final String title;
  final AccessType access;
  final int? price;
  final ContentType type;
  const StudyItem({required this.title, required this.access, this.price, required this.type});
}

class SubjectCategory {
  final String name;
  final String description;
  final int count;
  final Color cardColor;
  final List<StudyItem> items;
  const SubjectCategory({required this.name, required this.description, required this.count, required this.cardColor, required this.items});
}

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
                  const _LibraryPlaceholderPage(),
                  const _FlashcardsTabPage(),
                  const _QuestionBankTabPage(),
                  const _BareActsTabPage(),
                  const _LegalResearchTabPage(),
                  const _CaseReferencesTabPage(),
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
              color: _bg, 
              borderRadius: BorderRadius.circular(12), 
              border: Border.all(color: _cardBorder),
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
  const _HubPage({required this.onTabSwitch});

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
                const _SearchFieldPlaceholder(hint: 'Search materials, decks, acts...', light: false),
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

// ─── Flashcards Tab Content ──────────────────────────────────────────────────
class _FlashcardsTabPage extends StatefulWidget {
  const _FlashcardsTabPage();
  @override
  State<_FlashcardsTabPage> createState() => _FlashcardsTabPageState();
}

class _FlashcardsTabPageState extends State<_FlashcardsTabPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<FlashcardViewModel>();
      vm.fetchCategories();
      vm.fetchDecks(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<FlashcardViewModel>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          color: _white,
          child: Container(
            height: 44,
            decoration: BoxDecoration(color: _tabBg, borderRadius: BorderRadius.circular(12)),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) {
                vm.updateFilters(search: v);
                vm.fetchDecks(isRefresh: true);
              },
              decoration: const InputDecoration(
                hintText: 'Search decks...',
                hintStyle: TextStyle(color: _textSecondary, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: _textSecondary, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        if (vm.categories.isNotEmpty)
          Container(
            height: 48,
            color: _white,
            padding: const EdgeInsets.only(bottom: 12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: vm.categories.length + 1,
              itemBuilder: (context, index) {
                final isAll = index == 0;
                final cat = isAll ? 'All' : vm.categories[index - 1];
                final active = isAll ? vm.selectedCategory.isEmpty : vm.selectedCategory == cat;
                return GestureDetector(
                  onTap: () {
                    vm.updateFilters(category: isAll ? '' : cat);
                    vm.fetchDecks(isRefresh: true);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: active ? _navy : _white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: active ? _navy : _cardBorder),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: active ? _white : _textSecondary, 
                        fontSize: 13, 
                        fontWeight: active ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        Expanded(
          child: vm.isLoading 
              ? const Center(child: CircularProgressIndicator(color: _navy))
              : vm.decks.isEmpty 
                  ? const Center(child: Text('No decks found'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: vm.decks.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final deck = vm.decks[i];
                        return Material(
                          color: _navy,
                          borderRadius: BorderRadius.circular(16),
                          clipBehavior: Clip.antiAlias,
                          child: InkWell(
                            onTap: () => _startSession(context, deck),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Row(
                                children: [
                                  Container(
                                    width: 44,
                                    height: 44,
                                    decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
                                    child: const Icon(Icons.style_rounded, color: _gold, size: 24),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(deck.title, style: const TextStyle(color: _white, fontSize: 16, fontWeight: FontWeight.bold)),
                                        const SizedBox(height: 4),
                                        Text('${deck.flashcardCount} cards', style: TextStyle(color: _white.withOpacity(0.7), fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                  const Icon(Icons.arrow_forward_ios_rounded, color: Colors.white54, size: 16),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  void _startSession(BuildContext context, FlashcardDeck deck) async {
    final vm = context.read<FlashcardViewModel>();
    final navigator = Navigator.of(context);
    final scaffoldMessenger = ScaffoldMessenger.of(context);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator(color: _gold)),
    );

    bool success = await vm.fetchDeckDetail(deck.id);
    
    if (!context.mounted) return;
    navigator.pop(); // Close dialog

    if (success && vm.selectedDeck != null && vm.selectedDeck!.flashcards.isNotEmpty) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => _FlashcardViewerScreen(deck: vm.selectedDeck!)));
    } else {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(vm.errorMessage ?? 'This deck has no cards.')),
      );
    }
  }
}

// ─── Question Bank Tab Content ───────────────────────────────────────────────
class _QuestionBankTabPage extends StatefulWidget {
  const _QuestionBankTabPage();
  @override
  State<_QuestionBankTabPage> createState() => _QuestionBankTabPageState();
}

class _QuestionBankTabPageState extends State<_QuestionBankTabPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<QuestionBankViewModel>();
      vm.fetchFilterData();
      vm.fetchQuestionBanks(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<QuestionBankViewModel>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          color: _white,
          child: Column(
            children: [
              Container(
                height: 44,
                decoration: BoxDecoration(color: _tabBg, borderRadius: BorderRadius.circular(12)),
                child: TextField(
                  controller: _searchCtrl,
                  onChanged: (v) {
                    vm.updateFilters(search: v);
                    vm.fetchQuestionBanks(isRefresh: true);
                  },
                  decoration: const InputDecoration(
                    hintText: 'Search title, subject, or year...',
                    hintStyle: TextStyle(color: _textSecondary, fontSize: 13),
                    prefixIcon: Icon(Icons.search, color: _textSecondary, size: 20),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 10),
                  ),
                ),
              ),
              if (vm.programs.isNotEmpty) ...[
                const SizedBox(height: 12),
                SizedBox(
                  height: 36,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: vm.programs.length + 1,
                    itemBuilder: (context, index) {
                      final isAll = index == 0;
                      final prog = isAll ? 'All' : vm.programs[index - 1];
                      final active = isAll ? vm.selectedProgram.isEmpty : vm.selectedProgram == prog;
                      return GestureDetector(
                        onTap: () {
                          vm.updateFilters(program: isAll ? '' : prog);
                          vm.fetchQuestionBanks(isRefresh: true);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(right: 8),
                          padding: const EdgeInsets.symmetric(horizontal: 14),
                          decoration: BoxDecoration(
                            color: active ? _gold : _white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(color: active ? _gold : _cardBorder),
                          ),
                          alignment: Alignment.center,
                          child: Text(prog, style: TextStyle(color: active ? _navy : _textSecondary, fontSize: 12, fontWeight: active ? FontWeight.bold : FontWeight.w500)),
                        ),
                      );
                    },
                  ),
                ),
              ]
            ],
          ),
        ),

        Expanded(
          child: vm.isLoading 
              ? const Center(child: CircularProgressIndicator(color: _navy))
              : vm.items.isEmpty 
                  ? const Center(child: Text('No question banks found.'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: vm.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final item = vm.items[i];
                        return _buildBankCard(context, item);
                      },
                    ),
        ),
      ],
    );
  }

  Widget _buildBankCard(BuildContext context, QuestionBank item) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _white, 
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(color: _navy.withOpacity(0.05), borderRadius: BorderRadius.circular(6)),
                child: Text("${item.programType} - ${item.examType}", style: const TextStyle(color: _navy, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
              const Spacer(),
              if (item.tier == 'premium')
                const Icon(Icons.workspace_premium, color: _gold, size: 18)
              else
                const Text("FREE", style: TextStyle(color: _teal, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 12),
          Text(item.title, style: const TextStyle(color: _textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(item.subject, style: const TextStyle(color: _textSecondary, fontSize: 13)),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Year: ${item.year}", style: const TextStyle(color: _textPrimary, fontSize: 12, fontWeight: FontWeight.w600)),
              ElevatedButton(
                onPressed: () => _viewBankDetails(context, item),
                style: ElevatedButton.styleFrom(
                  backgroundColor: item.isUnlocked ? _teal : _navy, 
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: Text(
                  item.isUnlocked ? 'Open Bank' : 'Unlock Now', 
                  style: const TextStyle(color: _white, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void _viewBankDetails(BuildContext context, QuestionBank item) async {
    final vm = context.read<QuestionBankViewModel>();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator(color: _navy)),
    );

    bool success = await vm.fetchBankDetail(item.id);
    if (!context.mounted) return;
    Navigator.pop(context);

    if (success && vm.selectedBank != null) {
      final b = vm.selectedBank!;
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.75,
          decoration: const BoxDecoration(color: _white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(b.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _navy)),
                        Text(b.subject, style: const TextStyle(fontSize: 13, color: _textSecondary)),
                      ],
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const Divider(height: 32),
              const Text("Description", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _textPrimary)),
              const SizedBox(height: 8),
              Text(b.description, style: const TextStyle(fontSize: 14, color: _textSecondary, height: 1.6)),
              const Spacer(),
              if (!b.isUnlocked && b.associatedPackages.isNotEmpty) ...[
                const Text("Associated Packages", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _textPrimary)),
                const SizedBox(height: 8),
                Expanded(
                  child: ListView.builder(
                    itemCount: b.associatedPackages.length,
                    itemBuilder: (context, index) {
                      final pkg = b.associatedPackages[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(pkg.title, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                        trailing: Text("৳${pkg.discountPrice}", style: const TextStyle(color: _gold, fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
                ),
              ],
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: b.isUnlocked ? _teal : _gold, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                  child: Text(
                    b.isUnlocked ? "Continue to Questions" : "Buy Now", 
                    style: const TextStyle(color: _navy, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}

// ─── Bare Acts Tab Content ───────────────────────────────────────────────────
class _BareActsTabPage extends StatefulWidget {
  const _BareActsTabPage();
  @override
  State<_BareActsTabPage> createState() => _BareActsTabPageState();
}

class _BareActsTabPageState extends State<_BareActsTabPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<BareActsViewModel>();
      vm.fetchCategories();
      vm.fetchBareActs(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<BareActsViewModel>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          color: _white,
          child: Container(
            height: 44,
            decoration: BoxDecoration(color: _tabBg, borderRadius: BorderRadius.circular(12)),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) {
                vm.updateFilters(search: v);
                vm.fetchBareActs(isRefresh: true);
              },
              decoration: const InputDecoration(
                hintText: 'Search Bare Acts...',
                hintStyle: TextStyle(color: _textSecondary, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: _textSecondary, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        if (vm.categories.isNotEmpty)
          Container(
            height: 48,
            color: _white,
            padding: const EdgeInsets.only(bottom: 12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: vm.categories.length + 1,
              itemBuilder: (context, index) {
                final isAll = index == 0;
                final cat = isAll ? 'All' : vm.categories[index - 1];
                final active = isAll ? vm.selectedCategory.isEmpty : vm.selectedCategory == cat;
                return GestureDetector(
                  onTap: () {
                    vm.updateFilters(category: isAll ? '' : cat);
                    vm.fetchBareActs(isRefresh: true);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: active ? _navy : _white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: active ? _navy : _cardBorder),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      cat,
                      style: TextStyle(
                        color: active ? _white : _textSecondary, 
                        fontSize: 13, 
                        fontWeight: active ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

        Expanded(
          child: vm.isLoading 
              ? const Center(child: CircularProgressIndicator(color: _navy))
              : vm.bareActs.isEmpty 
                  ? const Center(child: Text('No Bare Acts found.'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: vm.bareActs.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final act = vm.bareActs[i];
                        return Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: _white, 
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: _cardBorder),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(color: _goldLight, borderRadius: BorderRadius.circular(6)),
                                    child: Text(act.category, style: const TextStyle(color: _gold, fontSize: 10, fontWeight: FontWeight.bold)),
                                  ),
                                  const Spacer(),
                                  const Icon(Icons.more_vert, color: _textSecondary, size: 18),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Text(act.title, style: const TextStyle(color: _textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
                              const SizedBox(height: 8),
                              Text(act.contentPlain, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: _textSecondary, fontSize: 13, height: 1.5)),
                              const SizedBox(height: 16),
                              Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () => _viewBareAct(context, act),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: _navy, 
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      child: const Text('Read Now', style: TextStyle(color: _white, fontSize: 13)),
                                    ),
                                  ),
                                  if (act.allowDownload) ...[
                                    const SizedBox(width: 12),
                                    Container(
                                      decoration: BoxDecoration(color: _bg, borderRadius: BorderRadius.circular(8), border: Border.all(color: _cardBorder)),
                                      child: IconButton(
                                        icon: const Icon(Icons.file_download_outlined, color: _navy, size: 20),
                                        onPressed: () => _downloadAct(act),
                                      ),
                                    ),
                                  ]
                                ],
                              )
                            ],
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  Future<void> _downloadAct(BareAct act) async {
    final url = Uri.parse("https://api.lexacademy.cloud/api/bare-acts/${act.id}/download");
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
       debugPrint("Could not launch $url");
    }
  }

  void _viewBareAct(BuildContext context, BareAct act) async {
    final vm = context.read<BareActsViewModel>();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator(color: _navy)),
    );

    bool success = await vm.fetchBareActDetail(act.id);
    if (!context.mounted) return;
    Navigator.pop(context);

    if (success && vm.selectedBareAct != null) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(color: _white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(vm.selectedBareAct!.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _navy))),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const Divider(),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(vm.selectedBareAct!.contentPlain, style: const TextStyle(fontSize: 15, color: _textPrimary, height: 1.6)),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}

// ─── Legal Research Tab Content ──────────────────────────────────────────────
class _LegalResearchTabPage extends StatefulWidget {
  const _LegalResearchTabPage();
  @override
  State<_LegalResearchTabPage> createState() => _LegalResearchTabPageState();
}

class _LegalResearchTabPageState extends State<_LegalResearchTabPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<LegalResearchViewModel>();
      vm.fetchResearchPapers(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<LegalResearchViewModel>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          color: _white,
          child: Container(
            height: 44,
            decoration: BoxDecoration(color: _tabBg, borderRadius: BorderRadius.circular(12)),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) {
                vm.updateFilters(search: v);
                vm.fetchResearchPapers(isRefresh: true);
              },
              decoration: const InputDecoration(
                hintText: 'Search research papers...',
                hintStyle: TextStyle(color: _textSecondary, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: _textSecondary, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        Expanded(
          child: vm.isLoading 
              ? const Center(child: CircularProgressIndicator(color: _navy))
              : vm.papers.isEmpty 
                  ? const Center(child: Text('No research papers found.'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: vm.papers.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final paper = vm.papers[i];
                        return GestureDetector(
                          onTap: () => _viewPaperDetails(context, paper),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _white, 
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: _cardBorder),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        paper.title, 
                                        style: const TextStyle(color: _textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: _textSecondary),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  "By ${paper.author}", 
                                  style: const TextStyle(color: _teal, fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  paper.abstract, 
                                  maxLines: 3, 
                                  overflow: TextOverflow.ellipsis, 
                                  style: const TextStyle(color: _textSecondary, fontSize: 13, height: 1.5),
                                ),
                                const SizedBox(height: 12),
                                Wrap(
                                  spacing: 8,
                                  children: paper.tags.map((tag) => Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                    decoration: BoxDecoration(color: _tabBg, borderRadius: BorderRadius.circular(6)),
                                    child: Text(tag, style: const TextStyle(color: _textSecondary, fontSize: 10)),
                                  )).toList(),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  void _viewPaperDetails(BuildContext context, LegalResearchPaper paper) async {
    final vm = context.read<LegalResearchViewModel>();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator(color: _navy)),
    );

    bool success = await vm.fetchPaperDetail(paper.id);
    if (!context.mounted) return;
    Navigator.pop(context);

    if (success && vm.selectedPaper != null) {
      final p = vm.selectedPaper!;
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(color: _white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(p.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _navy)),
                        const SizedBox(height: 4),
                        Text("Author: ${p.author}", style: const TextStyle(fontSize: 13, color: _teal, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const Divider(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Abstract", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _textPrimary)),
                      const SizedBox(height: 8),
                      Text(p.abstract, style: const TextStyle(fontSize: 14, color: _textSecondary, height: 1.6)),
                      const SizedBox(height: 24),
                      const Text("Full Paper Content", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _textPrimary)),
                      const SizedBox(height: 12),
                      Text(p.bodyMd, style: const TextStyle(fontSize: 14, color: _textPrimary, height: 1.6)),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              if (p.pdfUrl != null && p.pdfUrl!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final url = Uri.parse(p.pdfUrl!);
                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                          debugPrint("Could not launch $url");
                        }
                      },
                      icon: const Icon(Icons.picture_as_pdf, color: _white),
                      label: const Text("Download PDF Paper", style: TextStyle(color: _white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: _navy, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    }
  }
}

// ─── Case References Tab Content ───────────────────────────────────────
class _CaseReferencesTabPage extends StatefulWidget {
  const _CaseReferencesTabPage();
  @override
  State<_CaseReferencesTabPage> createState() => _CaseReferencesTabPageState();
}

class _CaseReferencesTabPageState extends State<_CaseReferencesTabPage> {
  final TextEditingController _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final vm = context.read<CaseReferenceViewModel>();
      vm.fetchCategories();
      vm.fetchCourts();
      vm.fetchCaseReferences(isRefresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<CaseReferenceViewModel>();

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          color: _white,
          child: Container(
            height: 44,
            decoration: BoxDecoration(color: _tabBg, borderRadius: BorderRadius.circular(12)),
            child: TextField(
              controller: _searchCtrl,
              onChanged: (v) {
                vm.updateFilters(search: v);
                vm.fetchCaseReferences(isRefresh: true);
              },
              decoration: const InputDecoration(
                hintText: 'Search cases, citation, court...',
                hintStyle: TextStyle(color: _textSecondary, fontSize: 14),
                prefixIcon: Icon(Icons.search, color: _textSecondary, size: 20),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ),

        if (vm.categories.isNotEmpty)
          Container(
            height: 48,
            color: _white,
            padding: const EdgeInsets.only(bottom: 12),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: vm.categories.length + 1,
              itemBuilder: (context, index) {
                final isAll = index == 0;
                final cat = isAll ? 'All Categories' : vm.categories[index - 1];
                final active = isAll ? vm.selectedCategory.isEmpty : vm.selectedCategory == cat;
                return GestureDetector(
                  onTap: () {
                    vm.updateFilters(category: isAll ? '' : cat);
                    vm.fetchCaseReferences(isRefresh: true);
                  },
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    decoration: BoxDecoration(
                      color: active ? _navy : _white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: active ? _navy : _cardBorder),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      cat,
                      style: TextStyle(color: active ? _white : _textSecondary, fontSize: 13, fontWeight: active ? FontWeight.bold : FontWeight.w500),
                    ),
                  ),
                );
              },
            ),
          ),

        Expanded(
          child: vm.isLoading 
              ? const Center(child: CircularProgressIndicator(color: _navy))
              : vm.items.isEmpty 
                  ? const Center(child: Text('No case references found.'))
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: vm.items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (context, i) {
                        final item = vm.items[i];
                        return GestureDetector(
                          onTap: () => _viewCaseDetails(context, item),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: _white, 
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(color: _cardBorder),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(color: _goldLight, borderRadius: BorderRadius.circular(6)),
                                      child: Text(item.category, style: const TextStyle(color: _gold, fontSize: 10, fontWeight: FontWeight.bold)),
                                    ),
                                    const Spacer(),
                                    Text("${item.year}", style: const TextStyle(color: _textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
                                  ],
                                ),
                                const SizedBox(height: 12),
                                Text(
                                  item.title, 
                                  style: const TextStyle(color: _textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item.citation, 
                                  style: const TextStyle(color: _teal, fontSize: 13, fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  item.summary, 
                                  maxLines: 2, 
                                  overflow: TextOverflow.ellipsis, 
                                  style: const TextStyle(color: _textSecondary, fontSize: 13, height: 1.5),
                                ),
                                const SizedBox(height: 12),
                                Row(
                                  children: [
                                    const Icon(Icons.account_balance, size: 14, color: _textSecondary),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        item.court, 
                                        style: const TextStyle(color: _textSecondary, fontSize: 12),
                                        maxLines: 1, overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  void _viewCaseDetails(BuildContext context, CaseReference item) async {
    final vm = context.read<CaseReferenceViewModel>();
    
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => const Center(child: CircularProgressIndicator(color: _navy)),
    );

    bool success = await vm.fetchCaseDetail(item.id);
    if (!context.mounted) return;
    Navigator.pop(context);

    if (success && vm.selectedCase != null) {
      final c = vm.selectedCase!;
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => Container(
          height: MediaQuery.of(context).size.height * 0.9,
          decoration: const BoxDecoration(color: _white, borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(c.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: _navy)),
                        const SizedBox(height: 4),
                        Text(c.citation, style: const TextStyle(fontSize: 13, color: _teal, fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.pop(context)),
                ],
              ),
              const Divider(height: 32),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDetailRow("Court", c.court),
                      _buildDetailRow("Year", "${c.year}"),
                      _buildDetailRow("Category", c.category),
                      const SizedBox(height: 20),
                      const Text("Summary", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _textPrimary)),
                      const SizedBox(height: 8),
                      Text(c.summary, style: const TextStyle(fontSize: 14, color: _textSecondary, height: 1.6)),
                      const SizedBox(height: 24),
                      if (c.contentPlain != null) ...[
                        const Text("Judgment Content", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _textPrimary)),
                        const SizedBox(height: 12),
                        Text(c.contentPlain!, style: const TextStyle(fontSize: 14, color: _textPrimary, height: 1.6)),
                      ],
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              if (c.pdfUrl != null && c.pdfUrl!.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        final url = Uri.parse(c.pdfUrl!);
                        if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
                          debugPrint("Could not launch $url");
                        }
                      },
                      icon: const Icon(Icons.file_download, color: _white),
                      label: const Text("Download Full Judgment", style: TextStyle(color: _white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(backgroundColor: _navy, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                )
            ],
          ),
        ),
      );
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Text("$label: ", style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: _textSecondary)),
          Text(value, style: const TextStyle(fontSize: 13, color: _textPrimary)),
        ],
      ),
    );
  }
}

// ─── Flashcard Viewer Screen (Interactive) ───────────────────────────────────
class _FlashcardViewerScreen extends StatefulWidget {
  final FlashcardDeck deck;
  const _FlashcardViewerScreen({required this.deck});
  @override
  State<_FlashcardViewerScreen> createState() => _FlashcardViewerScreenState();
}

class _FlashcardViewerScreenState extends State<_FlashcardViewerScreen> {
  int _idx = 0;
  bool _revealed = false;

  @override
  Widget build(BuildContext context) {
    final card = widget.deck.flashcards[_idx];
    final total = widget.deck.flashcards.length;

    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: _navy,
        elevation: 0,
        leading: IconButton(icon: const Icon(Icons.close, color: _white), onPressed: () => Navigator.pop(context)),
        title: const Text('Flashcards', style: TextStyle(color: _white, fontSize: 18, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Text('Question ${_idx + 1}/$total', style: const TextStyle(color: _textSecondary, fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Text(widget.deck.category, style: const TextStyle(color: _navy, fontSize: 16, fontWeight: FontWeight.bold)),
          
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: GestureDetector(
                onTap: () => setState(() => _revealed = !_revealed),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: _white,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: _revealed ? _gold : _cardBorder, width: 2),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 20, offset: const Offset(0, 10))],
                  ),
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _revealed ? card.backText : card.frontText,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: _textPrimary, fontSize: 20, fontWeight: FontWeight.bold, height: 1.5),
                      ),
                      const SizedBox(height: 40),
                      Text(_revealed ? 'Tap to see question' : 'Tap to flip', style: TextStyle(color: _gold, fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ),
          ),

          Container(
            padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _navBtn(Icons.arrow_back_rounded, _idx > 0 ? () => _move(-1) : null),
                    _navBtn(Icons.close, () => Navigator.pop(context), color: Colors.red.shade100, iconColor: Colors.red),
                    _navBtn(Icons.refresh_rounded, () => setState(() => _revealed = !_revealed), color: _goldLight, iconColor: _gold),
                    _navBtn(Icons.arrow_forward_rounded, _idx < total - 1 ? () => _move(1) : null),
                  ],
                ),
                const SizedBox(height: 24),
                const Text('Use ← → to navigate  •  Click card to flip', style: TextStyle(color: _textSecondary, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _move(int step) => setState(() { _idx += step; _revealed = false; });

  Widget _navBtn(IconData icon, VoidCallback? onTap, {Color? color, Color? iconColor}) {
    return GestureDetector(
      onTap: onTap,
      child: Opacity(
        opacity: onTap == null ? 0.3 : 1.0,
        child: Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(color: color ?? _white, borderRadius: BorderRadius.circular(16), border: Border.all(color: _cardBorder)),
          child: Icon(icon, color: iconColor ?? _navy, size: 24),
        ),
      ),
    );
  }
}

// ─── Shared & Placeholder Pages ─────────────────────────────────────────────
class _LibraryPlaceholderPage extends StatelessWidget {
  const _LibraryPlaceholderPage();
  @override
  Widget build(BuildContext context) {
    // Legacy categories mock for Library tab
    final List<SubjectCategory> categories = [
      SubjectCategory(name: 'Law Subject', description: 'সকল বিজেএস ও বার এর বিষয়াবলিসহ অন্যান্য আইনসমূহ', count: 14, cardColor: const Color(0xFF16324F), items: []),
      SubjectCategory(name: 'General Subject', description: 'বাংলা, ইংরেজি, সাধারণ গণিত ও বিজ্ঞান, সাধারণ জ্ঞান ও অন্যান্য', count: 14, cardColor: const Color(0xFF9A7420), items: []),
    ];

    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(color: _navy),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Study Library', style: TextStyle(color: _white, fontSize: 22, fontWeight: FontWeight.w800)),
              SizedBox(height: 6),
              Text('Browse books, notes, and articles organized by topic', style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 13)),
              SizedBox(height: 16),
              _SearchFieldPlaceholder(hint: 'Search by title or topic...', light: false),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: categories.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (ctx, i) => _CategoryCard(category: categories[i]),
          ),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final SubjectCategory category;
  const _CategoryCard({required this.category});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: category.cardColor, borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(width: 44, height: 44, decoration: BoxDecoration(color: Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12)), child: const Icon(Icons.gavel_rounded, color: _gold, size: 24)),
              Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6), decoration: BoxDecoration(color: Colors.black.withOpacity(0.2), borderRadius: BorderRadius.circular(20)), child: Text('${category.count} items', style: const TextStyle(color: _white, fontSize: 12, fontWeight: FontWeight.w600))),
            ],
          ),
          const SizedBox(height: 20),
          Text(category.name, style: const TextStyle(color: _white, fontSize: 20, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(category.description, style: const TextStyle(color: Color(0xB3FFFFFF), fontSize: 13, height: 1.5)),
        ],
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  final IconData icon; final Color iconBg; final String title; final String subtitle; final String? badge; final String? actionLabel; final VoidCallback? onTap;
  const _HubCard({required this.icon, required this.iconBg, required this.title, required this.subtitle, this.badge, this.actionLabel, this.onTap});
  @override
  Widget build(BuildContext context) {
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
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(color: _textPrimary, fontSize: 15, fontWeight: FontWeight.w700)),
              Text(subtitle, style: const TextStyle(color: _textSecondary, fontSize: 12)),
            ])),
            const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: _textSecondary),
          ],
        ),
      ),
    );
  }
}

class _SearchFieldPlaceholder extends StatelessWidget {
  final String hint; final bool light;
  const _SearchFieldPlaceholder({required this.hint, required this.light});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      decoration: BoxDecoration(color: light ? _white : Colors.white.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: light ? _cardBorder : Colors.transparent)),
      child: Row(children: [const SizedBox(width: 12), const Icon(Icons.search, color: _textSecondary, size: 20), const SizedBox(width: 10), Text(hint, style: TextStyle(color: light ? _textSecondary : Colors.white.withOpacity(0.5), fontSize: 13))]),
    );
  }
}

class _ComingSoonPage extends StatelessWidget {
  final String label;
  const _ComingSoonPage({required this.label});
  @override
  Widget build(BuildContext context) {
    return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Icon(Icons.construction, size: 48, color: _textSecondary),
      const SizedBox(height: 16),
      Text('$label - Coming Soon', style: const TextStyle(color: _textPrimary, fontSize: 16, fontWeight: FontWeight.bold)),
      const Text('This section is under development.', style: TextStyle(color: _textSecondary, fontSize: 13)),
    ]));
  }
}
