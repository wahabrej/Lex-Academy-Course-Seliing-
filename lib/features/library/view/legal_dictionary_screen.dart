import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/legal_dictionary_view_model.dart';
import '../model/legal_dictionary_model.dart';

class LegalDictionaryScreen extends StatefulWidget {
  final bool isTab;
  const LegalDictionaryScreen({super.key, this.isTab = false});

  @override
  State<LegalDictionaryScreen> createState() => _LegalDictionaryScreenState();
}

class _LegalDictionaryScreenState extends State<LegalDictionaryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<String> _alphabet = [
    'All', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
    'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'
  ];
  String _selectedLetter = 'All';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LegalDictionaryViewModel>().clearFilters();
      context.read<LegalDictionaryViewModel>().fetchDictionaryItems(isRefresh: true);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<LegalDictionaryViewModel>();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA),
      appBar: widget.isTab 
        ? null 
        : AppBar(
            backgroundColor: const Color(0xFF0C1D32),
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 18),
              onPressed: () => Navigator.pop(context),
            ),
            title: const Text(
              'Legal Dictionary',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
      body: Column(
        children: [
          // Search Bar Section
          Container(
            color: const Color(0xFF0C1D32),
            padding: const EdgeInsets.fromLTRB(16, 4, 16, 16),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: TextField(
                controller: _searchController,
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search legal terms (e.g. Affidavit)...',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 14),
                  prefixIcon: Icon(Icons.search_rounded, color: Colors.white.withOpacity(0.5), size: 22),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.clear, color: Colors.white70, size: 18),
                          onPressed: () {
                            _searchController.clear();
                            viewModel.updateFilters(search: '');
                            viewModel.fetchDictionaryItems(isRefresh: true);
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
                ),
                onChanged: (value) {
                  viewModel.updateFilters(search: value.trim());
                  viewModel.fetchDictionaryItems(isRefresh: true);
                },
              ),
            ),
          ),

          // Alphabet Filter list
          Container(
            height: 50,
            color: Colors.white,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              itemCount: _alphabet.length,
              itemBuilder: (context, index) {
                final letter = _alphabet[index];
                final isSelected = _selectedLetter == letter;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedLetter = letter;
                    });
                    viewModel.updateFilters(startsWith: letter == 'All' ? '' : letter);
                    viewModel.fetchDictionaryItems(isRefresh: true);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: isSelected ? const Color(0xFF16324F) : const Color(0xFFF0F2F8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      letter,
                      style: TextStyle(
                        color: isSelected ? Colors.white : const Color(0xFF6B7A99),
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                        fontSize: 13,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Sorting & Category Metadata indicators
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  viewModel.meta != null ? 'Total Terms: ${viewModel.meta!.total}' : 'Terms',
                  style: const TextStyle(color: Color(0xFF6B7A99), fontSize: 13, fontWeight: FontWeight.w500),
                ),
                Row(
                  children: [
                    const Icon(Icons.sort_by_alpha, size: 14, color: Color(0xFF6B7A99)),
                    const SizedBox(width: 4),
                    DropdownButton<String>(
                      value: viewModel.sortOrder,
                      items: const [
                        DropdownMenuItem(value: 'asc', child: Text('A-Z', style: TextStyle(fontSize: 12))),
                        DropdownMenuItem(value: 'desc', child: Text('Z-A', style: TextStyle(fontSize: 12))),
                      ],
                      onChanged: (val) {
                        if (val != null) {
                          viewModel.updateFilters(sortOrder: val);
                          viewModel.fetchDictionaryItems(isRefresh: true);
                        }
                      },
                      underline: const SizedBox(),
                      icon: const Icon(Icons.arrow_drop_down, size: 16),
                    )
                  ],
                )
              ],
            ),
          ),

          // Dictionary Items List
          Expanded(
            child: _buildMainContent(viewModel),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(LegalDictionaryViewModel viewModel) {
    if (viewModel.isLoading) {
      return const Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xFF0C1D32))));
    }

    if (viewModel.errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, color: Colors.red, size: 40),
              const SizedBox(height: 12),
              Text(
                viewModel.errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(color: Color(0xFF0F2137), fontSize: 14),
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () => viewModel.fetchDictionaryItems(isRefresh: true),
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF0C1D32)),
                child: const Text('Retry', style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      );
    }

    if (viewModel.items.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.gavel_rounded, color: Colors.grey, size: 48),
            SizedBox(height: 12),
            Text(
              'No dictionary definitions found',
              style: TextStyle(color: Color(0xFF6B7A99), fontSize: 14, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemCount: viewModel.items.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final entry = viewModel.items[index];
        return Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: Color(0xFFE8ECF5)),
          ),
          color: Colors.white,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            title: Text(
              entry.termEn,
              style: const TextStyle(color: Color(0xFF0F2137), fontSize: 16, fontWeight: FontWeight.bold),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: Text(
                entry.termBn,
                style: const TextStyle(color: Color(0xFF199A8E), fontSize: 14, fontWeight: FontWeight.w500),
              ),
            ),
            trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Colors.grey),
            onTap: () => _showTermDetails(context, entry.id),
          ),
        );
      },
    );
  }

  void _showTermDetails(BuildContext context, String id) {
    // Fetch individual definition by ID (GET /api/legal-dictionary/{id})
    context.read<LegalDictionaryViewModel>().fetchEntryDetail(id);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Consumer<LegalDictionaryViewModel>(
          builder: (context, vm, child) {
            return Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              ),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(color: Colors.grey[300], borderRadius: BorderRadius.circular(2)),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (vm.isDetailLoading)
                    const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Color(0xFF0C1D32))),
                      ),
                    )
                  else if (vm.selectedEntry == null)
                    Expanded(
                      child: Center(
                        child: Text(vm.errorMessage ?? 'Failed to load details'),
                      ),
                    )
                  else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            vm.selectedEntry!.termEn,
                            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF0C1D32)),
                          ),
                        ),
                        if (vm.selectedEntry!.category != null)
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF4D6),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              vm.selectedEntry!.category!,
                              style: const TextStyle(color: Color(0xFFD4A843), fontSize: 11, fontWeight: FontWeight.w600),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vm.selectedEntry!.termBn,
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Color(0xFF199A8E)),
                    ),
                    const Divider(height: 30, thickness: 1),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Definition (English)',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              vm.selectedEntry!.definitionEn ?? 'No English definition available.',
                              style: const TextStyle(fontSize: 15, color: Color(0xFF0F2137), height: 1.5),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'সংজ্ঞা (বাংলা)',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              vm.selectedEntry!.definitionBn ?? 'কোনো বাংলা সংজ্ঞা পাওয়া যায়নি।',
                              style: const TextStyle(fontSize: 15, color: Color(0xFF0F2137), height: 1.5),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            );
          },
        );
      },
    );
  }
}
