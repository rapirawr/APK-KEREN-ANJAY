import 'package:flutter/material.dart';
import 'package:kelasku_app/screens/achievement_screen.dart';
import 'package:kelasku_app/screens/gallery_screen.dart';
import 'package:kelasku_app/screens/piket_screen.dart';
import 'package:provider/provider.dart';

// Impor provider
import 'providers/profile_provider.dart';
import 'providers/task_provider.dart';
import 'providers/theme_provider.dart';

// Impor semua screen yang akan digunakan
import 'screens/splash_screen.dart';
import 'screens/home_screen.dart';
import 'screens/task_screen.dart';
import 'screens/profile_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Inisialisasi awal data
  Future<void> _initializeApp() async {
    // Di sini kita bisa melakukan inisialisasi awal jika diperlukan
    // Untuk sekarang, kita biarkan kosong karena ProfileProvider akan di-load di SplashScreen
  }

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => ProfileProvider()),
        ChangeNotifierProvider(create: (_) => TaskProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Aplikasi Saya',
            debugShowCheckedModeBanner: false,
            theme: ThemeData.light(),
            darkTheme: ThemeData.dark(),
            themeMode: themeProvider.themeMode,
            initialRoute: '/',
            routes: {
              '/': (context) => const SplashScreen(),
              '/home': (context) => const HomeScreen(),
              '/gallery': (context) => const GalleryScreen(),
              '/achievement': (context) => const AchievementScreen(), // Perbaiki typo: acvhievment -> achievement
              '/task': (context) => const TaskScreen(),
              '/piket': (context) => const PiketScreen(),
              '/profile': (context) => const ProfileScreen(),
            },
          );
        },
      ),
    );
  }
}