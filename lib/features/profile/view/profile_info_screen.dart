import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewModel/profileViewModel.dart';

class ProfileInfoScreen extends StatelessWidget {
  const ProfileInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
    final user = profileViewModel.userData;

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFF003B5C),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Profile', style: TextStyle(color: Colors.white)),
      ),
      body: profileViewModel.isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF003B5C),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildInfoRow('Name', user?.name ?? '—'),
                      _buildInfoRow('Email', user?.email ?? '—'),
                      _buildInfoRow('Phone', user?.phone ?? '—'),
                      _buildInfoRow('University', user?.university ?? '—'),
                      _buildInfoRow('Profession', user?.profession ?? '—'),
                      _buildInfoRow('Gender', user?.gender ?? '—'),
                      _buildInfoRow('Role', user?.role.toUpperCase() ?? '—'),
                    ],
                  ),
                ),
              ),
            ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600, color: Colors.black54)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w500, color: Color(0xFF003B5C)),
            ),
          ),
        ],
      ),
    );
  }
}
