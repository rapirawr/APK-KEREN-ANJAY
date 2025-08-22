import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile {
  String name;
  String email;
  String userClass;
  File? profileImage;
  Uint8List? webProfileImage; // Untuk menyimpan gambar di web
  String? imagePath; // Untuk menyimpan path gambar

  Profile({
    this.name = 'User Name',
    this.email = 'user@example.com',
    this.userClass = 'XII RPL 2',
    this.profileImage,
    this.webProfileImage,
    this.imagePath,
  });

  Profile copyWith({
    String? name,
    String? email,
    String? userClass,
    File? profileImage,
    Uint8List? webProfileImage,
    String? imagePath,
  }) {
    return Profile(
      name: name ?? this.name,
      email: email ?? this.email,
      userClass: userClass ?? this.userClass,
      profileImage: profileImage ?? this.profileImage,
      webProfileImage: webProfileImage ?? this.webProfileImage,
      imagePath: imagePath ?? this.imagePath,
    );
  }
}

class ProfileProvider with ChangeNotifier {
  Profile _profile = Profile();
  final String _imageKey = 'profile_image';
  final String _webImageKey = 'web_profile_image';

  Profile get profile => _profile;

  // Load profile data from shared preferences
  Future<void> loadProfile() async {
    final prefs = await SharedPreferences.getInstance();
    
    _profile = _profile.copyWith(
      name: prefs.getString('profile_name') ?? 'User Name',
      email: prefs.getString('profile_email') ?? 'user@example.com',
      userClass: prefs.getString('profile_class') ?? 'XII RPL 2',
      imagePath: prefs.getString('profile_image_path'),
    );
    
    // Load web image if exists
    final webImageBytes = prefs.getString(_webImageKey);
    if (webImageBytes != null) {
      _profile = _profile.copyWith(
        webProfileImage: Uint8List.fromList(webImageBytes.codeUnits),
      );
    }
    
    // Load file image if path exists
    if (_profile.imagePath != null) {
      final file = File(_profile.imagePath!);
      if (await file.exists()) {
        _profile = _profile.copyWith(profileImage: file);
      }
    }
    
    notifyListeners();
  }

  void updateProfile(Profile newProfile) {
    _profile = newProfile;
    _saveToPreferences();
    notifyListeners();
  }

  void updateName(String newName) {
    _profile = _profile.copyWith(name: newName);
    _saveToPreferences();
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _profile = _profile.copyWith(email: newEmail);
    _saveToPreferences();
    notifyListeners();
  }

  void updateClass(String newClass) {
    _profile = _profile.copyWith(userClass: newClass);
    _saveToPreferences();
    notifyListeners();
  }

  void updateProfileImage(File newImage, {String? imagePath}) {
    _profile = _profile.copyWith(
      profileImage: newImage,
      imagePath: imagePath,
      webProfileImage: null, // Clear web image when using file
    );
    _saveToPreferences();
    notifyListeners();
  }

  void updateWebProfileImage(Uint8List imageBytes) {
    _profile = _profile.copyWith(
      webProfileImage: imageBytes,
      profileImage: null, // Clear file image when using web
      imagePath: null,
    );
    _saveToPreferences();
    notifyListeners();
  }

  void clearProfileImage() {
    _profile = _profile.copyWith(
      profileImage: null,
      webProfileImage: null,
      imagePath: null,
    );
    _saveToPreferences();
    notifyListeners();
  }

  Future<void> _saveToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    
    await prefs.setString('profile_name', _profile.name);
    await prefs.setString('profile_email', _profile.email);
    await prefs.setString('profile_class', _profile.userClass);
    
    if (_profile.imagePath != null) {
      await prefs.setString('profile_image_path', _profile.imagePath!);
    } else {
      await prefs.remove('profile_image_path');
    }
    
    // Save web image as base64 string
    if (_profile.webProfileImage != null) {
      final imageString = String.fromCharCodes(_profile.webProfileImage!);
      await prefs.setString(_webImageKey, imageString);
    } else {
      await prefs.remove(_webImageKey);
    }
  }
}