import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadDataAndNavigate();
  }

  Future<void> _loadDataAndNavigate() async {
    try {
      // Load data profile - gunakan Future.delayed untuk memberi waktu widget tree terbangun
      await Future.delayed(const Duration(milliseconds: 300));
      
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      await profileProvider.loadProfile();

      // Tunggu sebentar untuk animasi splash screen
      await Future.delayed(const Duration(seconds: 2));

      // Navigasi ke home screen
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    } catch (e) {
      // Jika ada error, tetap lanjut ke home screen setelah delay
      print('Error in splash screen: $e');
      if (mounted) {
        await Future.delayed(const Duration(seconds: 2));
        Navigator.of(context).pushReplacementNamed('/home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo atau icon aplikasi
            Icon(
              Icons.school,
              size: 80,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            const SizedBox(height: 20),
            // Teks loading
            Text(
              '11 RPL 2',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            const SizedBox(height: 20),
            // Circular progress indicator
            CircularProgressIndicator(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
          ],
        ),
      ),
    );
  }
}