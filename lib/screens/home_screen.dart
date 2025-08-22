import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// --- PERUBAHAN 1: Tambahkan impor yang dibutuhkan ---
import 'package:kelasku_app/screens/profile_screen.dart';
import 'package:kelasku_app/screens/task_screen.dart'; // Pastikan path ini benar
import '../providers/theme_provider.dart';

// Impor untuk halaman dari HomeContent
import 'schedule_screen.dart';
import 'gallery_screen.dart';
import 'achievement_screen.dart';
import 'piket_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0; // Indeks untuk navigasi

  // --- PERUBAHAN 2: Sesuaikan daftar _screens untuk navigasi utama ---
  final List<Widget> _screens = [
    const HomeContent(),      // Indeks 0: Beranda
    const TaskScreen(),       // Indeks 1: Tugas
    const ProfileScreen(),    // Indeks 2: Profil
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      appBar: _currentIndex == 0 // Hanya tampilkan AppBar di beranda
          ? AppBar(
              title: const Text('Beranda'),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: themeProvider.toggleTheme,
                  icon: Icon(
                    themeProvider.themeMode == ThemeMode.dark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.search_rounded,
                      color: theme.colorScheme.onPrimary),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('Fitur pencarian segera hadir.'),
                        behavior: SnackBarBehavior.floating,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    );
                  },
                ),
              ],
            )
          : null,
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: theme.colorScheme.surface,
        elevation: 8,
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            // --- PERUBAHAN 3: Perbaiki item navigasi ---
            _buildBottomAppBarItem(
              context: context,
              icon: Icons.home_rounded,
              label: 'Beranda',
              index: 0, // <-- Indeks untuk HomeContent
            ),
            _buildBottomAppBarItem(
              context: context,
              icon: Icons.assignment_rounded, // Icon untuk Tugas
              label: 'Tugas',
              index: 1, // <-- Indeks untuk TaskScreen
            ),
            _buildBottomAppBarItem(
              context: context,
              icon: Icons.person_rounded, // Icon untuk Profil
              label: 'Profil',
              index: 2, // <-- Indeks untuk ProfileScreen
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk item bottom navigation
  Widget _buildBottomAppBarItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required int index,
  }) {
    final theme = Theme.of(context);
    final isActive = _currentIndex == index;
    final color = isActive
        ? theme.colorScheme.primary
        : theme.colorScheme.onSurface.withOpacity(0.6);

    return InkWell(
      onTap: () => setState(() => _currentIndex = index),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(color: color, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget untuk konten beranda (KODE INI TIDAK BERUBAH)
class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return RefreshIndicator(
      onRefresh: () async {
        await Future.delayed(const Duration(seconds: 2));
      },
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome',
                    style: theme.textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: theme.colorScheme.onBackground,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'XI RPL 2 ANJAY😝',
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onBackground.withOpacity(0.7),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 0.9,
              ),
              delegate: SliverChildListDelegate([
                _buildFeatureCard(
                  context,
                  title: 'Jadwal',
                  icon: Icons.calendar_month_rounded,
                  color: const Color(0xFFA64D79),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFFA64D79), Color(0xFFD291BC)],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ScheduleScreen()));
                  },
                ),
                _buildFeatureCard(
                  context,
                  title: 'Galeri',
                  icon: Icons.photo_library_rounded,
                  color: const Color(0xFF6A1E55),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF6A1E55), Color(0xFF9B59B6)],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const GalleryScreen()));
                  },
                ),
                _buildFeatureCard(
                  context,
                  title: 'Prestasi',
                  icon: Icons.emoji_events_rounded,
                  color: const Color(0xFF3B1C32),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF3B1C32), Color(0xFF6A1E55)],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const AchievementScreen()));
                  },
                ),
               _buildFeatureCard(
                  context,
                  title: 'Jadwal Piket',
                  icon: Icons.cleaning_services_rounded,
                  color: const Color(0xFF7A1CAC),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color.fromARGB(255, 62, 29, 80),
                      Color(0xFF7A1CAC)
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PiketScreen()));
                  },
                ),
              ]),
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(height: 20),
          ),
        ],
      ),
    );
  }

  // Fungsi untuk membangun kartu fitur
  Widget _buildFeatureCard(BuildContext context, {
    required String title, 
    required IconData icon, 
    required Color color, 
    required Gradient gradient,
    required VoidCallback onTap
  }) {
    final theme = Theme.of(context);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(20),
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(20),
              splashColor: Colors.white.withOpacity(0.2),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(icon, size: 32, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}