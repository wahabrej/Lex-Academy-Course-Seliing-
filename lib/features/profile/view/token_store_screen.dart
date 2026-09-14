import 'package:flutter/material.dart';

class TokenStoreScreen extends StatelessWidget {
  const TokenStoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF003B5C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Token Store', style: TextStyle(color: Colors.white)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Token banner
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFF5B301),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(Icons.emoji_events, color: Colors.white),
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text('0 tokens', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Text('Token Store', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 5),
                const Text('Spend the tokens you earned from quizzes & daily tasks to unlock premium books, notes and courses.',
                    style: TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Filter chips
          Row(
            children: [
              _buildChip('All', true),
              _buildChip('Books', false),
              _buildChip('Notes', false),
              _buildChip('Courses', false),
            ],
          ),
          const SizedBox(height: 16),
          // Items
          _buildTokenItem('সংবিধান - ২৬ অনুচ্ছেদ - Lex Academy', 'Included', 'PDF', '13 Token'),
          _buildTokenItem('সংবিধান - ২৬ অনুচ্ছেদ - Lex Academy', 'Included', 'PDF', '13 Token'),
          _buildTokenItem('সংবিধান - ২৬ অনুচ্ছেদ - Lex Academy', 'Included', 'PDF', '13 Token'),
        ],
      ),
    );
  }

  Widget _buildChip(String label, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: Chip(
        label: Text(label, style: TextStyle(color: isSelected ? Colors.white : Colors.black)),
        backgroundColor: isSelected ? const Color(0xFF003B5C) : Colors.grey.shade200,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _buildTokenItem(String title, String tag, String type, String price) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.picture_as_pdf, color: Colors.red),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF003B5C))),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Included', style: TextStyle(color: Colors.green, fontSize: 12)),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('PDF', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003B5C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                ),
                child: Text('Buy $price', style: const TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}