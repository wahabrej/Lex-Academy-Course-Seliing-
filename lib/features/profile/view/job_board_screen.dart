import 'package:flutter/material.dart';
import 'job_details_screen.dart';

class JobBoardScreen extends StatelessWidget {
  const JobBoardScreen({super.key});

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
        title: const Text('Job Board', style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Career Resources', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 5),
            const Text('Internships, jobs, and workshops for law students', style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 15),
            // Search bar
            TextField(
              decoration: InputDecoration(
                hintText: 'Search opportunities...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  _buildJobCard(
                    context,
                    'Internship',
                    'Legal Intern — Cyril Amarchand Mangaldas',
                    'Join India\'s leading law firm as a summer intern. Work on corporate transactions, M&A deals, and regulatory compliance matters...',
                    'Mumbai',
                    'Deadline passed',
                    Colors.blue,
                  ),
                  _buildJobCard(
                    context,
                    'Job',
                    'Associate — AZB & Partners',
                    'Full-time associate position in the litigation team. Handle civil and commercial disputes, arbitration proceedings...',
                    'New Delhi',
                    'Deadline passed',
                    Colors.green,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJobCard(BuildContext context, String type, String title, String description, String location, String deadline, Color typeColor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: typeColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(type, style: TextStyle(color: typeColor, fontWeight: FontWeight.bold, fontSize: 12)),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF003B5C))),
            const SizedBox(height: 8),
            Text(description, style: const TextStyle(color: Colors.grey, fontSize: 13), maxLines: 3, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(Icons.location_on, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(location, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.red),
                const SizedBox(width: 4),
                Text(deadline, style: const TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const JobDetailsScreen()));
              },
              child: const Row(
                children: [
                  Text('View Details', style: TextStyle(color: Color(0xFF003B5C), fontWeight: FontWeight.bold)),
                  SizedBox(width: 5),
                  Icon(Icons.arrow_forward, size: 16, color: Color(0xFF003B5C)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}