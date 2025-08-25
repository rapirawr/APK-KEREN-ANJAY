import 'package:flutter/material.dart';

class SiswaScreen extends StatelessWidget {
  const SiswaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // data siswa dengan foto berbeda
    final List<Map<String, String>> siswa = [
      {"nama": "Achmad Cholil Shofiyullah", "absen": "Absen 1", "foto": "assets/images/img-12.jpg"},
      {"nama": "Agnes Angleline Grace Lau", "absen": "Absen 2", "foto": "assets/images/img-12.jpg"},
      {"nama": "Andrean Agustiar Saputra", "absen": "Absen 3", "foto": "assets/images/img-12.jpg"},
      {"nama": "Cheryl Azzahra Van Cassan Suswandi", "absen": "Absen 4", "foto": "assets/images/img-12.jpg"},
      {"nama": "Dika Maulana Ramadani", "absen": "Absen 5", "foto": "assets/images/img-12.jpg"},
      {"nama": "Faiz Adhyasta Pratama", "absen": "Absen 6", "foto": "assets/images/img-12.jpg"},
      {"nama": "Fiyo Ridhani Agus Kurniawan", "absen": "Absen 7", "foto": "assets/images/img-12.jpg"},
      {"nama": "Ifan Andika Putra", "absen": "Absen 8", "foto": "assets/images/img-12.jpg"},
      {"nama": "M. Nazriel Irlham", "absen": "Absen 9", "foto": "assets/images/img-12.jpg"},
      {"nama": "Mochammad Refan Maluana E.", "absen": "Absen 10", "foto": "assets/images/img-12.jpg"},
      {"nama": "Mochammad Alvian Firdaus", "absen": "Absen 11", "foto": "assets/images/img-12.jpg"},
      {"nama": "Mochammad Rafikhul Ardiansyah", "absen": "Absen 12", "foto": "assets/images/img-12.jpg"},
      {"nama": "Muhammad Bagas Maulana", "absen": "Absen 13", "foto": "assets/images/img-12.jpg"},
      {"nama": "Muhammad Imron Hidayatullah", "absen": "Absen 14", "foto": "assets/images/img-12.jpg"},
      {"nama": "Radinal Muhdor", "absen": "Absen 15", "foto": "assets/images/img-12.jpg"},
      {"nama": "Rafi Abdillah Fairuz", "absen": "Absen 16", "foto": "assets/images/img-12.jpg"},
      {"nama": "Rehan Ramadhansyah", "absen": "Absen 17", "foto": "assets/images/img-12.jpg"},
      {"nama": "Septiyan Bintang Ramadhan Putra", "absen": "Absen 18", "foto": "assets/images/img-12.jpg"},
      {"nama": "Siti Aizatul Arifah", "absen": "Absen 19", "foto": "assets/images/img-12.jpg"},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        title: const Text(
          "Siswa Siswi Tercinta 11 RPL 2",
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF6A11CB),
                Color(0xFF2575FC),
              ],
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1A1A1A),
              Color(0xFF0A0A0A),
            ],
          ),
        ),
        child: ListView.builder(
          itemCount: siswa.length,
          itemBuilder: (context, index) {
            final data = siswa[index];
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    Color(0xFF1E1E1E),
                    Color(0xFF2D2D2D),
                  ],
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                leading: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF8A2BE2),
                      width: 2,
                    ),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xFF6A11CB),
                        Color(0xFF2575FC),
                      ],
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: AssetImage(data["foto"]!),
                    radius: 22,
                  ),
                ),
                title: Text(
                  data["nama"]!,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
                subtitle: Text(
                  data["absen"]!,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                  ),
                ),
                trailing: Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFF6A11CB),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    size: 16,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  // aksi kalau item diklik, misalnya ke detail siswa
                },
              ),
            );
          },
        ),
      ),
    );
  }
}