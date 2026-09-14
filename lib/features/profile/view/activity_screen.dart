import 'package:flutter/material.dart';

class ActivityScreen extends StatelessWidget {
  const ActivityScreen({super.key});

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
        title: const Text('Activity', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Activity timeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 10),
                // Filter chips
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildChip('All', true),
                      _buildChip('Quizzes', false),
                      _buildChip('Written', false),
                      _buildChip('LL.B Academy', false),
                      _buildChip('Mentor', false),
                      _buildChip('Discussions', false),
                      _buildChip('Tokens', false),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                _buildActivityItem('Penal Code, 1860', 'Day completed - 3/80 - 4%', '25/08/2026', Icons.check_circle, Colors.orange),
                _buildActivityItem('Penal Code, 1860', '3/14 - 21%', '25/08/2026', Icons.menu_book, Colors.blue),
                _buildActivityItem('Contract Act, 1872', '0/2 - 0%', '25/08/2026', Icons.menu_book, Colors.blue),
                _buildActivityItem('নারী ও শিশু নির্যাতন দমন আইন, ২০০০ - Special Powers Act, 1974', 'Day completed - 2/100 - 2%', '22/08/2026', Icons.check_circle, Colors.orange),
                _buildActivityItem('নারী ও শিশু নির্যাতন দমন আইন', '2/3 - 67%', '22/08/2026', Icons.menu_book, Colors.blue),
                _buildActivityItem('Unknown', '0/2 - 0%', '01/08/2026', Icons.help, Colors.grey),
                const SizedBox(height: 10),
                const Center(child: Text('Load more', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF003B5C)))),
              ],
            ),
          ),
        ),
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

  Widget _buildActivityItem(String title, String subtitle, String date, IconData icon, Color iconColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
          ),
          Text(date, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        ],
      ),
    );
  }
}