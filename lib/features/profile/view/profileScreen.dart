import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/routes/routesName.dart';
import '../viewModel/profileViewModel.dart';
import 'profile_info_screen.dart';
import 'favorites_screen.dart';
import 'activity_screen.dart';
import 'token_store_screen.dart';
import 'job_board_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ProfileViewModel>().fetchUserProfile();
    });
  }

  @override
  Widget build(BuildContext context) {
    final profileViewModel = context.watch<ProfileViewModel>();
    final user = profileViewModel.userData;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Header with profile image
            Container(
              height: 260,
              decoration: const BoxDecoration(
                color: Color(0xFF003B5C),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    right: -20,
                    top: 20,
                    child: Icon(Icons.brush, size: 150, color: Colors.white.withOpacity(0.05)),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          'My Profile',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(height: 15),
                        Stack(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundColor: Colors.grey[300],
                              backgroundImage: user?.avatarUrl != null && user!.avatarUrl!.isNotEmpty
                                  ? NetworkImage(user.avatarUrl!)
                                  : const NetworkImage('https://i.pravatar.cc/150?img=12'),
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
                                child: const Icon(Icons.edit, size: 14, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(
                          user?.name ?? 'Loading...',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          user?.email ?? '',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            if (profileViewModel.errorMessage != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  profileViewModel.errorMessage!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),

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

            _buildSectionTitle('Settings'),
            _buildMenuItemWithSwitch(Icons.notifications, 'Notifications', true),
            _buildMenuItem(Icons.help, 'Help & Support'),
            _buildMenuItem(Icons.delete, 'Delete Account', color: Colors.red),
            _buildMenuItem(Icons.logout, 'Logout', color: Colors.red, onTap: () async {
              await context.read<ProfileViewModel>().logout();
              if (mounted) {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  RouteName.loginScreen,
                  (route) => false,
                );
              }
            }),
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
