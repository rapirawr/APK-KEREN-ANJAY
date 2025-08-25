import 'dart:io';
import 'dart:typed_data';

class Profile {
  final String name;
  final String email;
  final String userClass;
  final File? profileImage;
  final String? profileImagePath;
  final Uint8List? webProfileImage;

  const Profile({
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

  // Factory constructor untuk membuat profile kosong
  factory Profile.empty() {
    return const Profile(
      name: '',
      email: '',
      userClass: '',
    );
  }

  // Factory constructor untuk membuat profile default
  factory Profile.defaultProfile() {
    return const Profile(
      name: 'Pengguna',
      email: 'user@example.com',
      userClass: '11 RPL 2',
    );
  }

  // Method untuk mengecek apakah profile kosong
  bool get isEmpty {
    return name.isEmpty && email.isEmpty && userClass.isEmpty;
  }

  // Method untuk mengecek apakah profile sudah lengkap
  bool get isComplete {
    return name.isNotEmpty && 
           name != 'Pengguna' &&
           email.isNotEmpty && 
           email != 'user@example.com' &&
           userClass.isNotEmpty &&
           isValidEmail(email);
  }

  // Method untuk validasi email
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Method untuk mendapatkan inisial nama
  String get initials {
    if (name.isEmpty || name == 'Pengguna') {
      return 'U';
    }
    
    final names = name.trim().split(' ');
    if (names.length >= 2) {
      return '${names.first[0]}${names.last[0]}'.toUpperCase();
    } else {
      return name[0].toUpperCase();
    }
  }

  // Method untuk mengecek apakah ada profile image
  bool get hasProfileImage {
    return profileImage != null || webProfileImage != null;
  }

  // Method untuk mendapatkan display name
  String get displayName {
    return name.isEmpty || name == 'Pengguna' ? 'Pengguna Baru' : name;
  }

  // Method untuk convert ke Map (untuk serialization)
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'userClass': userClass,
      'profileImagePath': profileImagePath,
      'hasProfileImage': hasProfileImage,
      'isComplete': isComplete,
      'initials': initials,
      'displayName': displayName,
    };
  }

  // Factory constructor dari Map (untuk deserialization)
  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      userClass: map['userClass'] ?? '',
      profileImagePath: map['profileImagePath'],
    );
  }

  // Override toString untuk debugging
  @override
  String toString() {
    return 'Profile(name: $name, email: $email, class: $userClass, hasImage: $hasProfileImage)';
  }

  // Override equality operators
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    
    return other is Profile &&
      other.name == name &&
      other.email == email &&
      other.userClass == userClass &&
      other.profileImagePath == profileImagePath;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      userClass.hashCode ^
      profileImagePath.hashCode;
  }
}