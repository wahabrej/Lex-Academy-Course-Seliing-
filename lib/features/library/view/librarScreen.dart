import 'package:flutter/material.dart';

// ─── Color Tokens (Figma Exact) ──────────────────────────────────────────────
const _bg = Color(0xFFF5F7FA);
const _white = Color(0xFFFFFFFF);
const _navy = Color(0xFF0C1D32);
const _navyLight = Color(0xFF16324F);
const _textPrimary = Color(0xFF0F2137);
const _textSecondary = Color(0xFF6B7A99);
const _textMuted = Color(0xFF9BA8BB);
const _gold = Color(0xFFD4A843);
const _goldLight = Color(0xFFFFF4D6);
const _teal = Color(0xFF199A8E);
const _green = Color(0xFF2ECC71);
const _greenLight = Color(0xFFE8F8F0);
const _red = Color(0xFFEF5350);
const _redLight = Color(0xFFFFEBEB);
const _buyYellow = Color(0xFFF5C542);
const _cardBorder = Color(0xFFE8ECF5);
const _tabBg = Color(0xFFF0F2F8);
const _lawCard = Color(0xFF16324F);
const _generalCard = Color(0xFF9A7420);

// ─── Models ──────────────────────────────────────────────────────────────────
enum ContentType { notes, books, articles }

enum AccessType { free, premium }

class StudyItem {
  final String title;
  final AccessType access;
  final int? price;
  final ContentType type;
  const StudyItem({
    required this.title,
    required this.access,
    this.price,
    required this.type,
  });
}

class SubjectCategory {
  final String name;
  final String description;
  final int count;
  final Color cardColor;
  final List<StudyItem> items;
  const SubjectCategory({
    required this.name,
    required this.description,
    required this.count,
    required this.cardColor,
    required this.items,
  });
}

// ─── Mock Data ────────────────────────────────────────────────────────────────
final _lawItems = [
  const StudyItem(
    title: 'সংবিধান - ১৬ অনুচ্ছেদ - Lex Academy',
    access: AccessType.free,
    type: ContentType.notes,
  ),
  const StudyItem(
    title: 'মাদকদ্রব্য নিয়ন্ত্রণ আইন, ২০১৮ (বিলি ও ব)',
    access: AccessType.premium,
    price: 50,
    type: ContentType.notes,
  ),
  const StudyItem(
    title: 'মুসলিম উত্তরাধিকার আইন - অধ্যায় - ভূমিকা',
    access: AccessType.premium,
    price: 40,
    type: ContentType.notes,
  ),
  const StudyItem(
    title: 'মানব পাচার ও অভিবাসী চোরাচালান প্রতিরোধ ও দমন আইন ২০২৬ - Lex',
    access: AccessType.premium,
    price: 60,
    type: ContentType.notes,
  ),
];

final _articleTags = [
  'সংবিধান',
  'আ্যাক্টিং প্রেসিডেন্ট',
  'অনুচ্ছেদ ৫৪',
  'Acting President',
  'চতুর্থ সংশোধনী',
  'স্পিকার',
  'তুলনামূলক সাংবিধানিক আইন',
  'বাংলাদেশ সংবিধান',
  'Constitutional Law',
];

final _categories = [
  SubjectCategory(
    name: 'Law Subject',
    description: 'সকল বিজেএস ও বার এর বিষয়াবলিসহ অন্যান্য আইনসমূহ',
    count: 14,
    cardColor: _lawCard,
    items: _lawItems,
  ),
  SubjectCategory(
    name: 'General Subject',
    description:
        'বাংলা, ইংরেজি, সাধারণ গণিত ও বিজ্ঞান, সাধারণ জ্ঞান ও অন্যান্য',
    count: 14,
    cardColor: _generalCard,
    items: [],
  ),
];

// ─── Entry Point ──────────────────────────────────────────────────────────────
void main() {
  runApp(const StudyApp());
}

class StudyApp extends StatelessWidget {
  const StudyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Study App',
      theme: ThemeData(
        scaffoldBackgroundColor: _bg,
        primarySwatch: Colors.blue,
      ),
      home: const LibraryScreen(),
    );
  }
}

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});
  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  int _tab = 0;
  final _tabs = ['Hub', 'Library', 'Flashcards', 'Bare Acts'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            _buildTopTabs(),
            Expanded(
              child: IndexedStack(
                index: _tab,
                children: const [
                  _HubPage(),
                  _LibraryPage(),
                  _ComingSoonPage(label: 'Flashcards'),
                  _ComingSoonPage(label: 'Bare Acts'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
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
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: _textPrimary,
              size: 16,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            _tabs[_tab] == 'Hub' ? 'Study' : _tabs[_tab],
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopTabs() {
    return Container(
      color: _white,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Row(
        children: _tabs.asMap().entries.map((e) {
          final active = e.key == _tab;
          return Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _tab = e.key),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ), // Padding কমানো হয়েছে যাতে ফিট হয়
                decoration: BoxDecoration(
                  color: active ? _navyLight : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: active ? _navyLight : _cardBorder),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      _tabIcon(e.key),
                      size: 14,
                      color: active ? _white : _textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: Text(
                        e.value,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: active
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: active ? _white : _textSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  IconData _tabIcon(int i) {
    switch (i) {
      case 0:
        return Icons.home_rounded;
      case 1:
        return Icons.local_library_rounded;
      case 2:
        return Icons.style_rounded;
      default:
        return Icons.gavel_rounded;
    }
  }
}

// ─── Hub Page (Updated to match exact new image) ─────────────────────────────
class _HubPage extends StatelessWidget {
  const _HubPage();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hero banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
            decoration: const BoxDecoration(color: _navy),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Study Materials',
                  style: TextStyle(
                    color: _white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your single hub for reading, practising and reference –\nacross BJS, BAR and LL.B.',
                  style: TextStyle(
                    color: Color(0xB3FFFFFF),
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),


                const SizedBox(height: 20),
                _SearchField(
                  hint: 'Search materials, decks, acts...',
                  light: false,
                ),
              ],
            ),
          ),
          // Filter chips
          Container(
            color: _white,
            padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
            child: const _FilterRow(),
          ),
          const SizedBox(height: 8),

          // ─── Read Section ───
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Row(
              children: [
                const Text(
                  'Read',
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _gold,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _HubCard(
                  icon: Icons.local_library_rounded,
                  iconBg: _navyLight,
                  title: 'Study Library',
                  subtitle: 'Books, notes & curated articles.',
                  badge: '0 Items',
                ),
                const SizedBox(height: 12),
                _HubCard(
                  icon: Icons.school_rounded,
                  iconBg: _teal,
                  title: 'Courses',
                  subtitle: 'Structured video lessons & syllabi.',
                  actionLabel: 'Open',
                ),
                const SizedBox(height: 12),
                _HubCard(
                  icon: Icons.trending_up_rounded,
                  iconBg: const Color(0xFF2ECC71),
                  title: 'Exam Trends',
                  subtitle: 'Past-paper analytics by subject & year.',
                  badge: '0 Items',
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ─── Practice Section ───
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                const Text(
                  'Practice',
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _gold,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '2',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                _HubCard(
                  icon: Icons.style_rounded,
                  iconBg: const Color(0xFF9B59B6),
                  title: 'Flashcards',
                  subtitle: 'Active recall decks for quick revision.',
                  badge: '2 Items',
                ),
                const SizedBox(height: 12),
                _HubCard(
                  icon: Icons.quiz_rounded,
                  iconBg: _gold,
                  title: 'Question Bank',
                  subtitle: 'BJS / BAR past papers & subject sets.',
                  actionLabel: 'Open',
                  isPremium: true,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          // ─── Reference Section (NEW - Added per image) ───
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Row(
              children: [
                const Text(
                  'Reference',
                  style: TextStyle(
                    color: _textPrimary,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: _gold,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    '3',
                    style: TextStyle(
                      color: _textPrimary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
            child: Column(
              children: [
                _HubCard(
                  icon: Icons.gavel_rounded,
                  iconBg: _navyLight,
                  title: 'Bare Acts',
                  subtitle: 'Searchable statutes with explanations.',
                  badge: '0 Items',
                ),
                const SizedBox(height: 12),
                _HubCard(
                  icon: Icons.account_balance_rounded,
                  iconBg: _navyLight,
                  title: 'Case References',
                  subtitle: 'Landmark judgments with summaries.',
                  actionLabel: 'Open',
                ),
                const SizedBox(height: 12),
                _HubCard(
                  icon: Icons.menu_book_rounded,
                  iconBg: _navyLight,
                  title: 'Legal Research',
                  subtitle: 'Articles, papers and analyses.',
                  badge: '0 Items',
                ),
                const SizedBox(height: 12),
                // Legal Dictionary (With Lock Icon)
                _HubCard(
                  icon: Icons.menu_book_outlined,
                  iconBg: _navyLight,
                  title: 'Legal Dictionary',
                  subtitle: 'Bilingual EN/BN legal terminology.',
                  badge: '1 Items',
                  isLocked: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRow extends StatefulWidget {
  const _FilterRow();
  @override
  State<_FilterRow> createState() => _FilterRowState();
}

class _FilterRowState extends State<_FilterRow> {
  int _sel = 0;
  final _filters = ['All', 'Read', 'Practice', 'Reference'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: _filters.asMap().entries.map((e) {
          final active = e.key == _sel;
          return GestureDetector(
            onTap: () => setState(() => _sel = e.key),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
              decoration: BoxDecoration(
                color: active ? _navy : _white,
                borderRadius: BorderRadius.circular(20),
                border: active ? null : Border.all(color: _cardBorder),
              ),
              child: Text(
                e.value,
                style: TextStyle(
                  color: active ? _white : _textSecondary,
                  fontSize: 13,
                  fontWeight: active ? FontWeight.w700 : FontWeight.w500,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _HubCard extends StatelessWidget {
  final IconData icon;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String? badge;
  final String? actionLabel;
  final bool isPremium;
  final bool isLocked;

  const _HubCard({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    this.badge,
    this.actionLabel,
    this.isPremium = false,
    this.isLocked = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPremium
              ? const Color(0xFFF5C542)
              : _cardBorder, // Gold Border for Premium
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: _white, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (isLocked) ...[
                      const SizedBox(width: 8),
                      const Icon(
                        Icons.lock_outline_rounded,
                        color: _textSecondary,
                        size: 16,
                      ),
                    ] else if (isPremium) ...[
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: _goldLight,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.workspace_premium,
                              color: _gold,
                              size: 12,
                            ),
                            SizedBox(width: 4),
                            Text(
                              'Premium',
                              style: TextStyle(
                                color: _gold,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(color: _textSecondary, fontSize: 13),
                ),
                if (badge != null) ...[
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _tabBg,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      badge!,
                      style: const TextStyle(
                        color: _textMuted,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (actionLabel != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: _tabBg,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: _cardBorder),
              ),
              child: Text(
                actionLabel!,
                style: const TextStyle(
                  color: _textPrimary,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            )
          else
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: _goldLight,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(
                Icons.arrow_forward_rounded,
                color: _gold,
                size: 18,
              ),
            ),
        ],
      ),
    );
  }
}

// ─── Library Page (List View) ─────────────────────────────────────────────────
class _LibraryPage extends StatelessWidget {
  const _LibraryPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
          decoration: const BoxDecoration(color: _navy),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Study Library',
                style: TextStyle(
                  color: _white,
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const SizedBox(height: 6),
              const Text(
                'Browse books, notes, and articles organized by topic',
                style: TextStyle(color: Color(0xB3FFFFFF), fontSize: 13),
              ),
              const SizedBox(height: 16),
              _SearchField(hint: 'Search by title or topic...', light: false),
            ],
          ),
        ),
        Container(
          color: _white,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
          child: Row(
            children: ContentType.values.map((t) {
              return _ContentPill(type: t, selected: false, onTap: () {});
            }).toList(),
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (ctx, i) => _CategoryCard(
              category: _categories[i],
              onTap: () => Navigator.push(
                ctx,
                MaterialPageRoute(
                  builder: (_) => _SubjectScreen(category: _categories[i]),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ContentPill extends StatelessWidget {
  final ContentType type;
  final bool selected;
  final VoidCallback onTap;
  const _ContentPill({
    required this.type,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    String label;
    IconData icon;
    switch (type) {
      case ContentType.notes:
        label = 'Notes';
        icon = Icons.description_rounded;
        break;
      case ContentType.books:
        label = 'Books';
        icon = Icons.menu_book_rounded;
        break;
      case ContentType.articles:
        label = 'Articles';
        icon = Icons.article_rounded;
        break;
    }
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: selected ? _navy : _white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: selected ? _navy : _cardBorder),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: selected ? _white : _textSecondary),
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                color: selected ? _white : _textSecondary,
                fontSize: 14,
                fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final SubjectCategory category;
  final VoidCallback onTap;
  const _CategoryCard({required this.category, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: category.cardColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: category.cardColor.withOpacity(0.2),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.gavel_rounded,
                    color: _gold,
                    size: 24,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${category.count} notes',
                    style: const TextStyle(
                      color: _white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              category.name,
              style: const TextStyle(
                color: _white,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.description,
              style: const TextStyle(
                color: Color(0xB3FFFFFF),
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Subject Screen (Exact Figma 3 Screen Flow) ──────────────────────────────
class _SubjectScreen extends StatefulWidget {
  final SubjectCategory category;
  const _SubjectScreen({required this.category});
  @override
  State<_SubjectScreen> createState() => _SubjectScreenState();
}

class _SubjectScreenState extends State<_SubjectScreen> {
  ContentType _tab = ContentType.notes;
  final _ctrl = TextEditingController();
  String _q = '';

  @override
  Widget build(BuildContext context) {
    final items = widget.category.items
        .where((i) => i.type == _tab)
        .where(
          (i) => _q.isEmpty || i.title.toLowerCase().contains(_q.toLowerCase()),
        )
        .toList();

    return Scaffold(
      backgroundColor: _bg,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              color: _navy,
              padding: const EdgeInsets.only(bottom: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: _white,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          _tab == ContentType.books
                              ? 'Books'
                              : _tab == ContentType.articles
                              ? 'articles'
                              : widget.category.name,
                          style: const TextStyle(
                            color: _white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: ContentType.values.map((t) {
                        final active = t == _tab;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: GestureDetector(
                              onTap: () => setState(() => _tab = t),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 10,
                                ),
                                decoration: BoxDecoration(
                                  color: active ? _navyLight : _white,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: _cardBorder),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      t == ContentType.notes
                                          ? Icons.description_rounded
                                          : t == ContentType.books
                                          ? Icons.menu_book_rounded
                                          : Icons.article_rounded,
                                      size: 16,
                                      color: active ? _white : _textSecondary,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      t == ContentType.notes
                                          ? 'Notes'
                                          : t == ContentType.books
                                          ? 'Books'
                                          : 'Articles',
                                      style: TextStyle(
                                        color: active ? _white : _textSecondary,
                                        fontSize: 14,
                                        fontWeight: active
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: _white,
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
              child: _SearchField(
                hint: _tab == ContentType.notes
                    ? 'Search notes...'
                    : 'Search topics...',
                controller: _ctrl,
                onChanged: (v) => setState(() => _q = v),
                light: true,
              ),
            ),
            Expanded(
              child: _tab == ContentType.books
                  ? const _BooksComingSoon()
                  : _tab == ContentType.articles
                  ? const _ArticlesView()
                  : items.isEmpty
                  ? const _EmptyView()
                  : ListView.separated(
                      padding: const EdgeInsets.all(16),
                      itemCount: items.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 12),
                      itemBuilder: (_, i) => _StudyItemCard(item: items[i]),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Study Item Card (Notes) ──────────────────────────────────────────────────
class _StudyItemCard extends StatelessWidget {
  final StudyItem item;
  const _StudyItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final isFree = item.access == AccessType.free;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: _redLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.picture_as_pdf_rounded,
                  color: _red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(
                        color: _textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        if (isFree)
                          const _Badge(
                            label: 'Free',
                            bg: _greenLight,
                            fg: _green,
                          )
                        else
                          _Badge(
                            label: 'Premium · ৳${item.price}',
                            bg: _goldLight,
                            fg: _gold,
                          ),
                        const SizedBox(width: 8),
                        const _Badge(
                          label: 'PDF',
                          bg: _tabBg,
                          fg: _textSecondary,
                          bordered: true,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (isFree)
            _ActionButton(
              label: '⬇  Download',
              color: _navyLight,
              textColor: _white,
              onTap: () {},
            )
          else
            _ActionButton(
              label: '🔒  Buy · ৳${item.price}',
              color: _buyYellow,
              textColor: _textPrimary,
              onTap: () {},
            ),
        ],
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  final String label;
  final Color bg;
  final Color fg;
  final bool bordered;
  const _Badge({
    required this.label,
    required this.bg,
    required this.fg,
    this.bordered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(6),
        border: bordered ? Border.all(color: fg.withOpacity(0.3)) : null,
      ),
      child: Text(
        label,
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final String label;
  final Color color;
  final Color textColor;
  final VoidCallback onTap;
  const _ActionButton({
    required this.label,
    required this.color,
    required this.textColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

// ─── Books Coming Soon (Figma Exact) ──────────────────────────────────────────
class _BooksComingSoon extends StatelessWidget {
  const _BooksComingSoon();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: _goldLight,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.menu_book_rounded,
                color: _gold,
                size: 30,
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Coming Soon',
              style: TextStyle(
                color: _textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Books are on the way',
              style: TextStyle(
                color: _textPrimary,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Curated study books will be available\nhere soon. Stay tuned!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _textSecondary,
                fontSize: 13,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Articles View (Figma Exact) ──────────────────────────────────────────────
class _ArticlesView extends StatelessWidget {
  const _ArticlesView();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _articleTags.map((t) {
              return GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: _white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: _cardBorder),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.article_rounded,
                        color: _navyLight,
                        size: 14,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        t,
                        style: const TextStyle(
                          color: _textPrimary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24),
          const _ArticleCard(
            imageIcon: Icons.gavel_rounded,
            tag: 'Case Law',
            title:
                'রাষ্ট্রপতির অবর্তমানে স্পিকারের আইনগত মর্যাদা: \'অ্যাক্টিং প্রেসিডেন্ট\' নাকি',
            excerpt:
                'বাংলাদেশের সাংবিধানিক আইনে গুরুত্বপূর্ণ মামলার সারসংক্ষেপ ও বিশ্লেষণ।',
            author: 'Md. Moatasin Billah',
            time: '4m',
          ),
        ],
      ),
    );
  }
}

class _ArticleCard extends StatelessWidget {
  final IconData imageIcon;
  final String tag;
  final String title;
  final String excerpt;
  final String author;
  final String time;

  const _ArticleCard({
    required this.imageIcon,
    required this.tag,
    required this.title,
    required this.excerpt,
    required this.author,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _cardBorder),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 160,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [_lawCard, _navy],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            ),
            child: Stack(
              children: [
                Center(
                  child: Icon(
                    imageIcon,
                    color: _gold.withOpacity(0.2),
                    size: 80,
                  ),
                ),
                Positioned(
                  top: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: _white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      tag,
                      style: const TextStyle(
                        color: _navyLight,
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 12,
                  right: 12,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.favorite_border_rounded,
                      color: _white,
                      size: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: _textPrimary,
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  excerpt,
                  style: const TextStyle(
                    color: _textSecondary,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: _navyLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.person_rounded,
                        color: _white,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        author,
                        style: const TextStyle(
                          color: _textSecondary,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Text(
                      '© $time',
                      style: const TextStyle(color: _textMuted, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared Widgets ───────────────────────────────────────────────────────────
class _SearchField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final bool light;

  const _SearchField({
    required this.hint,
    this.controller,
    this.onChanged,
    required this.light,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: light ? _white : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: light ? _cardBorder : Colors.white.withOpacity(0.1),
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(color: light ? _textPrimary : _white, fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
            color: light ? _textMuted : Colors.white.withOpacity(0.5),
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: light ? _textMuted : Colors.white.withOpacity(0.5),
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  const _EmptyView();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded, color: _textMuted, size: 48),
          const SizedBox(height: 12),
          const Text(
            'No items found',
            style: TextStyle(
              color: _textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _ComingSoonPage extends StatelessWidget {
  final String label;
  const _ComingSoonPage({required this.label});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(color: _tabBg, shape: BoxShape.circle),
            child: const Icon(
              Icons.construction_rounded,
              color: _textMuted,
              size: 32,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            '$label — Coming Soon',
            style: const TextStyle(
              color: _textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'This section is under development.',
            style: TextStyle(color: _textSecondary, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
