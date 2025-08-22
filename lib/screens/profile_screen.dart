import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../providers/profile_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _classController;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller di sini
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _classController = TextEditingController();
  }

  // --- PERBAIKAN: Gunakan didChangeDependencies untuk memuat data dari Provider ---
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Hanya muat data sekali, saat pertama kali widget dibangun
    if (_isLoading) {
      _loadProfileData();
    }
  }

  Future<void> _loadProfileData() async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    await profileProvider.loadProfile();

    // Set controllers setelah data di-load
    _nameController.text = profileProvider.profile.name;
    _emailController.text = profileProvider.profile.email;
    _classController.text = profileProvider.profile.userClass;

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _classController.dispose();
    super.dispose();
  }

  bool get isWeb => kIsWeb;

  Future<void> _pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? pickedFile = await picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );
      
      if (pickedFile != null) {
        final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
        
        if (isWeb) {
          final bytes = await pickedFile.readAsBytes();
          profileProvider.updateWebProfileImage(bytes);
        } else {
          final File imageFile = File(pickedFile.path);
          profileProvider.updateProfileImage(imageFile, imagePath: pickedFile.path);
        }
        
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Foto profil berhasil diubah'),
            backgroundColor: Colors.green.shade700,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            margin: const EdgeInsets.all(16),
            duration: const Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('Error picking image: $e');
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal memilih gambar: ${e.toString()}'),
          backgroundColor: Colors.red.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void _showImagePickerDialog() {
    if (isWeb) {
      _pickImage(ImageSource.gallery);
      return;
    }
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: SafeArea(
            child: Wrap(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Pilih Sumber Foto',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.photo_camera, color: Theme.of(context).colorScheme.primary),
                  title: Text('Ambil dari Kamera', style: Theme.of(context).textTheme.bodyLarge),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library, color: Theme.of(context).colorScheme.primary),
                  title: Text('Pilih dari Galeri', style: Theme.of(context).textTheme.bodyLarge),
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
      profileProvider.updateName(_nameController.text);
      profileProvider.updateEmail(_emailController.text);
      profileProvider.updateClass(_classController.text);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Profil berhasil disimpan'),
          backgroundColor: Colors.green.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.all(16),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Widget _buildProfileImage() {
    final profileProvider = Provider.of<ProfileProvider>(context);
    
    if (isWeb) {
      return profileProvider.profile.webProfileImage != null
          ? Image.memory(
              profileProvider.profile.webProfileImage!,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
            )
          : Icon(
              Icons.person,
              size: 60,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
            );
    } else {
      return profileProvider.profile.profileImage != null
          ? Image.file(
              profileProvider.profile.profileImage!,
              width: 120,
              height: 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.person,
                  size: 60,
                  color: Theme.of(context).colorScheme.primary,
                );
              },
            )
          : Icon(
              Icons.person,
              size: 60,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.6),
            );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    if (_isLoading) {
      return Scaffold(
        backgroundColor: colorScheme.background,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(colorScheme.primary),
              ),
              const SizedBox(height: 16),
              Text(
                'Memuat profil...',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
      );
    }
    
    return Scaffold(
      backgroundColor: colorScheme.background,
      appBar: AppBar(
        title: const Text('Profil Saya'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: colorScheme.onBackground,
      ),
      body: Consumer<ProfileProvider>(
        builder: (context, profileProvider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Bagian Foto Profil
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: LinearGradient(
                            colors: [
                              colorScheme.primary.withOpacity(0.2),
                              colorScheme.primary.withOpacity(0.05),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          border: Border.all(
                            color: colorScheme.primary.withOpacity(0.3),
                            width: 2,
                          ),
                        ),
                        child: ClipOval(
                          child: _buildProfileImage(),
                        ),
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: colorScheme.primary,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.camera_alt, size: 20),
                          color: Colors.white,
                          onPressed: _showImagePickerDialog,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32),
                  
                  // Form Data Profil
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: colorScheme.surface,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          style: theme.textTheme.bodyLarge,
                          decoration: InputDecoration(
                            labelText: 'Nama Lengkap',
                            labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                            prefixIcon: Icon(Icons.person, color: colorScheme.primary),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceVariant.withOpacity(0.4),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nama tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        
                        TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          style: theme.textTheme.bodyLarge,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                            prefixIcon: Icon(Icons.email, color: colorScheme.primary),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceVariant.withOpacity(0.4),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email tidak boleh kosong';
                            }
                            if (!value.contains('@') || !value.contains('.')) {
                              return 'Format email tidak valid';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),
                        
                        TextFormField(
                          controller: _classController,
                          style: theme.textTheme.bodyLarge,
                          decoration: InputDecoration(
                            labelText: 'Kelas',
                            labelStyle: TextStyle(color: colorScheme.onSurface.withOpacity(0.6)),
                            prefixIcon: Icon(Icons.school, color: colorScheme.primary),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colorScheme.outline.withOpacity(0.3)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: colorScheme.primary, width: 1.5),
                            ),
                            filled: true,
                            fillColor: colorScheme.surfaceVariant.withOpacity(0.4),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kelas tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  
                  // Tombol Simpan
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveProfile,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        backgroundColor: colorScheme.primary,
                        foregroundColor: colorScheme.onPrimary,
                        elevation: 4,
                        shadowColor: Colors.black.withOpacity(0.2),
                      ),
                      child: Text(
                        'Simpan Perubahan',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}