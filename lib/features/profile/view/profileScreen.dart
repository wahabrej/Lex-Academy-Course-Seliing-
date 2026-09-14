import 'package:flutter/material.dart';
import 'profile_info_screen.dart';
import 'favorites_screen.dart';
import 'activity_screen.dart';
import 'token_store_screen.dart';
import 'job_board_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with profile image
            Container(
              height: 240,
              decoration: const BoxDecoration(
                color: Color(0xFF003B5C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  // Background pattern (optional)
                  Positioned(
                    right: -20,
                    top: 20,
                    child: Icon(Icons.brush, size: 150, color: Colors.white.withOpacity(0.05)),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'My Profile',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 20),
                        Stack(
                          children: [
                            const CircleAvatar(
                              radius: 45,
                              backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=12'),
                            ),
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.edit, size: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Personal Information Section
            _buildSectionTitle('Personal Information'),
            _buildMenuItem(Icons.person, 'Profile Info', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ProfileInfoScreen()));
            }),
            _buildMenuItem(Icons.favorite, 'Favourites', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FavoritesScreen()));
            }),

            _buildSectionTitle('General'),
            _buildMenuItem(Icons.language, 'Activity', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const ActivityScreen()));
            }),
            _buildMenuItem(Icons.monetization_on, 'Token Store', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const TokenStoreScreen()));
            }),
            _buildMenuItem(Icons.help_outline, 'Job Board', onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const JobBoardScreen()));
            }),

            _buildSectionTitle('General'),
            _buildMenuItemWithSwitch(Icons.notifications, 'Notifications', true),
            _buildMenuItem(Icons.help, 'Help & Support'),
            _buildMenuItem(Icons.delete, 'Delete Account', color: Colors.red),
            _buildMenuItem(Icons.logout, 'Logout', color: Colors.red),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey)),
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {Color color = Colors.black, VoidCallback? onTap}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(color: color, fontWeight: FontWeight.w500)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildMenuItemWithSwitch(IconData icon, String title, bool value) {
    return ListTile(
      leading: Icon(icon, color: Colors.black),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Switch(value: value, onChanged: (v) {}, activeColor: Colors.orange),
    );
  }
}