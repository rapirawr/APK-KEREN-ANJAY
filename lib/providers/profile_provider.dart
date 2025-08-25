import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  final String name;
  final String email;
  final String userClass;
  final File? profileImage;
  final String? profileImagePath;
  final Uint8List? webProfileImage;

  Profile({
    required this.name,
    required this.email,
    required this.userClass,
    this.profileImage,
    this.profileImagePath,
    this.webProfileImage,
  });

  // Copy method untuk membuat instance baru dengan perubahan
  Profile copyWith({
    String? name,
    String? email,
    String? userClass,
    File? profileImage,
    String? profileImagePath,
    Uint8List? webProfileImage,
    bool clearProfileImage = false,
    bool clearWebProfileImage = false,
  }) {
    return Profile(
      name: name ?? this.name,
      email: email ?? this.email,
      userClass: userClass ?? this.userClass,
      profileImage: clearProfileImage ? null : profileImage ?? this.profileImage,
      profileImagePath: clearProfileImage ? null : profileImagePath ?? this.profileImagePath,
      webProfileImage: clearWebProfileImage ? null : webProfileImage ?? this.webProfileImage,
    );
  }
}

class ProfileProvider extends ChangeNotifier {
  Profile _profile = Profile(
    name: '',
    email: '',
    userClass: '',
  );
  
  bool _isLoaded = false;
  
  Profile get profile => _profile;
  bool get isLoaded => _isLoaded;
  
  Future<void> loadProfile() async {
    if (_isLoaded) return; // Jika sudah loaded, tidak perlu load ulang
    
    try {
      // Simulasi loading dari SharedPreferences atau database
      await Future.delayed(const Duration(milliseconds: 300));
      
      // Load data dari SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      
      // Create base profile
      _profile = Profile(
        name: prefs.getString('profile_name') ?? 'Pengguna',
        email: prefs.getString('profile_email') ?? 'user@example.com',
        userClass: prefs.getString('profile_class') ?? '11 RPL 2',
        profileImagePath: prefs.getString('profile_image_path'),
      );
      
      // Load profile image jika ada (untuk mobile)
      if (_profile.profileImagePath != null && _profile.profileImagePath!.isNotEmpty) {
        final file = File(_profile.profileImagePath!);
        if (await file.exists()) {
          _profile = _profile.copyWith(
            profileImage: file,
          );
        }
      }
      
      // Load web profile image (untuk web)
      final webImageBytes = prefs.getString('profile_web_image');
      if (webImageBytes != null && webImageBytes.isNotEmpty) {
        try {
          final bytes = base64Decode(webImageBytes);
          _profile = _profile.copyWith(
            webProfileImage: bytes,
          );
        } catch (e) {
          print('Error decoding web profile image: $e');
        }
      }
      
      _isLoaded = true;
      notifyListeners();
    } catch (e) {
      print('Error loading profile: $e');
      // Meski error, tetap set sebagai loaded dengan default values
      _profile = Profile(
        name: 'Pengguna',
        email: 'user@example.com',
        userClass: '11 RPL 2',
      );
      _isLoaded = true;
      notifyListeners();
    }
  }
  
  Future<void> updateName(String name) async {
    try {
      _profile = _profile.copyWith(name: name);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_name', name);
      notifyListeners();
    } catch (e) {
      print('Error updating name: $e');
    }
  }
  
  Future<void> updateEmail(String email) async {
    try {
      _profile = _profile.copyWith(email: email);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_email', email);
      notifyListeners();
    } catch (e) {
      print('Error updating email: $e');
    }
  }
  
  Future<void> updateClass(String userClass) async {
    try {
      _profile = _profile.copyWith(userClass: userClass);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_class', userClass);
      notifyListeners();
    } catch (e) {
      print('Error updating class: $e');
    }
  }
  
  Future<void> updateProfileImage(File imageFile, {String? imagePath}) async {
    try {
      _profile = _profile.copyWith(
        profileImage: imageFile,
        profileImagePath: imagePath ?? imageFile.path,
        clearWebProfileImage: true, // Clear web image when setting mobile image
      );
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image_path', imagePath ?? imageFile.path);
      await prefs.remove('profile_web_image'); // Remove web image
      
      notifyListeners();
    } catch (e) {
      print('Error updating profile image: $e');
    }
  }
  
  Future<void> updateWebProfileImage(Uint8List imageBytes) async {
    try {
      _profile = _profile.copyWith(
        webProfileImage: imageBytes,
        clearProfileImage: true, // Clear mobile image when setting web image
      );
      
      final prefs = await SharedPreferences.getInstance();
      final base64String = base64Encode(imageBytes);
      await prefs.setString('profile_web_image', base64String);
      await prefs.remove('profile_image_path'); // Remove mobile image path
      
      notifyListeners();
    } catch (e) {
      print('Error updating web profile image: $e');
    }
  }
  
  Future<void> removeProfileImage() async {
    try {
      _profile = _profile.copyWith(
        clearProfileImage: true,
        clearWebProfileImage: true,
      );
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('profile_image_path');
      await prefs.remove('profile_web_image');
      
      notifyListeners();
    } catch (e) {
      print('Error removing profile image: $e');
    }
  }
  
  Future<void> resetProfile() async {
    try {
      _profile = Profile(
        name: 'Pengguna',
        email: 'user@example.com',
        userClass: '11 RPL 2',
      );
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('profile_name');
      await prefs.remove('profile_email');
      await prefs.remove('profile_class');
      await prefs.remove('profile_image_path');
      await prefs.remove('profile_web_image');
      
      notifyListeners();
    } catch (e) {
      print('Error resetting profile: $e');
    }
  }
  
  // Method untuk reset loading state jika diperlukan
  void resetLoadingState() {
    _isLoaded = false;
    notifyListeners();
  }
  
  // Method untuk force reload profile
  Future<void> reloadProfile() async {
    _isLoaded = false;
    await loadProfile();
  }
  
  // Method untuk check apakah profile sudah lengkap
  bool get isProfileComplete {
    return _profile.name.isNotEmpty && 
           _profile.name != 'Pengguna' &&
           _profile.email.isNotEmpty && 
           _profile.email != 'user@example.com' &&
           _profile.userClass.isNotEmpty;
  }
  
  // Method untuk mendapatkan inisial nama untuk avatar
  String get nameInitials {
    if (_profile.name.isEmpty || _profile.name == 'Pengguna') {
      return 'U';
    }
    
    final names = _profile.name.trim().split(' ');
    if (names.length >= 2) {
      return '${names.first[0]}${names.last[0]}'.toUpperCase();
    } else {
      return _profile.name[0].toUpperCase();
    }
  }
  
  // Method untuk validasi email
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
  
  // Method untuk mendapatkan info singkat profile
  Map<String, dynamic> get profileSummary {
    return {
      'name': _profile.name,
      'email': _profile.email,
      'class': _profile.userClass,
      'hasProfileImage': (_profile.profileImage != null || _profile.webProfileImage != null),
      'isComplete': isProfileComplete,
      'initials': nameInitials,
    };
  }
}