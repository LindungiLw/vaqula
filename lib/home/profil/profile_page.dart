import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../provider/user_provider.dart';
import '../../services/database_service.dart';
import '../../untils/theme_provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  // ===================================================================
  // 1. DEKLARASI VARIABEL & CONTROLLER
  // ===================================================================
  final DatabaseService _databaseService = DatabaseService();
  bool _isLoading = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String? _selectedGender;
  final List<String> _genders = ['Male', 'Female', 'Other'];

  // ===================================================================
  // 2. LIFECYCLE & LOGIC METHODS
  // ===================================================================

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  void _loadUserData() {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    if (userProvider.userData != null) {
      final userData = userProvider.userData!;
      setState(() {
        _nameController.text = userData['displayName'] ?? '';
        _emailController.text = userData['email'] ?? '';
        _phoneController.text = userData['phoneNumber'] ?? '';
        String? genderFromDb = userData['gender'];
        if (genderFromDb != null && _genders.contains(genderFromDb)) {
          _selectedGender = genderFromDb;
        }
      });
    }
  }

  void _updateProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);
    try {
      final Map<String, dynamic> updatedData = {
        'displayName': _nameController.text.trim(),
        'phoneNumber': _phoneController.text.trim(),
        'gender': _selectedGender,
      };
      await _databaseService.updateUserData(user.uid, updatedData);
      await Provider.of<UserProvider>(context, listen: false).fetchUserData(user.uid);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Profile updated successfully!')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Failed to update profile: $e')));
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  // PENAMBAHAN BARU: Fungsi lengkap untuk ganti foto profil
  void _changeProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);

    try {
      final file = File(image.path);
      final ref = FirebaseStorage.instance
          .ref()
          .child('profile_pictures')
          .child('${user.uid}.jpg');

      await ref.putFile(file);
      final photoURL = await ref.getDownloadURL();
      await _databaseService.updateUserData(user.uid, {'photoURL': photoURL});
      await Provider.of<UserProvider>(context, listen: false).fetchUserData(user.uid);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Foto profil berhasil diperbarui!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal mengupload foto: $e')),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }


  // ===================================================================
  // 3. UI BUILD METHOD
  // ===================================================================

  @override
  Widget build(BuildContext context) {
    final Color mainColor = const Color(0xFFA05E1A);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        elevation: 0,
        title: Text('Your Profile', style: TextStyle(color: Theme.of(context).appBarTheme.titleTextStyle?.color, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Consumer<UserProvider>(
                    builder: (context, userProvider, child) {
                      final photoURL = userProvider.userData?['photoURL'];
                      return CircleAvatar(
                        radius: 60,
                        backgroundImage: (photoURL != null && photoURL.isNotEmpty)
                            ? NetworkImage(photoURL)
                            : const AssetImage('assets/profile/lindungi_profile.jpg') as ImageProvider,
                        onBackgroundImageError: (exception, stackTrace) => const Icon(Icons.person, size: 60, color: Colors.grey),
                      );
                    }
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    // PENYESUAIAN: Hubungkan ke fungsi yang benar
                    onTap: _changeProfilePicture,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: mainColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Theme.of(context).scaffoldBackgroundColor, width: 2),
                      ),
                      child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  final displayName = userProvider.userData?['displayName'] ?? 'Loading...';
                  return Text(displayName, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold));
                }
            ),
            const SizedBox(height: 30),
            _buildProfileInputField(context, label: 'profile name', controller: _nameController, icon: Icons.person_outline),
            _buildProfileInputField(context, label: 'phone number', controller: _phoneController, icon: Icons.phone_android, keyboardType: TextInputType.phone),
            _buildProfileInputField(context, label: 'email', controller: _emailController, icon: Icons.email_outlined, keyboardType: TextInputType.emailAddress, isReadOnly: true),
            _buildGenderDropdown(context),
            const SizedBox(height: 20),
            SwitchListTile(
              title: Text('Dark Mode', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
              secondary: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode, color: mainColor),
              value: themeProvider.isDarkMode,
              onChanged: (bool value) => themeProvider.toggleTheme(value),
              activeColor: mainColor,
              tileColor: Theme.of(context).cardColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: BorderSide(color: Colors.grey.withOpacity(0.5)),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            const SizedBox(height: 40),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
              onPressed: _updateProfile,
              style: ElevatedButton.styleFrom(
                backgroundColor: mainColor,
                padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                elevation: 8,
              ),
              child: const Text('Update', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  // ===================================================================
  // 4. UI HELPER WIDGETS
  // ===================================================================
  Widget _buildProfileInputField(BuildContext context, {
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool isReadOnly = false,// Properti untuk membuat field tidak bisa diedit
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        readOnly: isReadOnly,
        style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
          prefixIcon: Icon(icon, color: Theme.of(context).iconTheme.color),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: const Color(0xFFA05E1A), width: 2)),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
      ),
    );
  }

  Widget _buildGenderDropdown(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        value: _selectedGender,
        decoration: InputDecoration(
          labelText: 'gender',
          labelStyle: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color),
          prefixIcon: Icon(Icons.person_outline, color: Theme.of(context).iconTheme.color),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.grey.withOpacity(0.5))),
          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: const Color(0xFFA05E1A), width: 2)),
          filled: true,
          fillColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        ),
        hint: Text('Select Gender', style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
        items: _genders.map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender, style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)),
          );
        }).toList(),
        onChanged: (String? newValue) {
          setState(() {
            _selectedGender = newValue;
          });
        },
        dropdownColor: Theme.of(context).cardColor,
      ),
    );
  }
}