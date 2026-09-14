import 'package:flutter/material.dart';

class JobDetailsScreen extends StatelessWidget {
  const JobDetailsScreen({super.key});

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
        title: const Text('Job Details', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Legal Intern — Cyril Amarchand Mangaldas', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 5),
            const Text('Legal Intern — Cyril Amarchand Mangaldas',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF003B5C))),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text('Internship', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 12)),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                const Text('Mumbai', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                Icon(Icons.calendar_today, size: 16, color: Colors.red),
                SizedBox(width: 5),
                Text('Deadline: 15/05/2026 (Deadline passed)', style: TextStyle(color: Colors.red)),
              ],
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Description', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF003B5C))),
                    const SizedBox(height: 10),
                    const Text(
                      'Join India\'s leading law firm as a summer intern. Work on corporate transactions, M&A deals, and regulatory compliance matters. Gain hands-on experience with senior partners.',
                      style: TextStyle(height: 1.5),
                    ),
                    const SizedBox(height: 20),
                    const Text('Requirements', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF003B5C))),
                    const SizedBox(height: 10),
                    _buildRequirement('LLB 3rd year or above'),
                    _buildRequirement('Strong research skills'),
                    _buildRequirement('Good academic record'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text('Apply Now', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF003B5C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.open_in_new, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Apply / Open Link', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.favorite, color: Colors.white),
                    SizedBox(width: 8),
                    Text('Saved', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRequirement(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          Text(text, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}