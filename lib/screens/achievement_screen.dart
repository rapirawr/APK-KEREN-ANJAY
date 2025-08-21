import 'package:flutter/material.dart';

class AchievementScreen extends StatefulWidget {
  const AchievementScreen({super.key});

  @override
  State<AchievementScreen> createState() => _AchievementScreenState();
}

class _AchievementScreenState extends State<AchievementScreen> {
  final List<Map<String, dynamic>> achievements = [
    {
      'title': 'Juara 1 Lomba Coding',
      'description': 'Memenangkan kompetisi coding tingkat sekolah',
      'date': '12 Januari 2024',
      'icon': Icons.code,
      'color': Colors.blue,
    },
    {
      'title': 'Juara 2 Web Design',
      'description': 'Meraih peringkat kedua dalam lomba desain web',
      'date': '28 Februari 2024',
      'icon': Icons.web,
      'color': Colors.green,
    },
    {
      'title': 'Juara Harapan Robotik',
      'description': 'Partisipasi dalam kompetisi robotik daerah',
      'date': '15 Maret 2024',
      'icon': Icons.smart_toy,
      'color': Colors.orange,
    },
    {
      'title': 'Sertifikasi Java',
      'description': '20 siswa mendapatkan sertifikasi Java dasar',
      'date': '5 April 2024',
      'icon': Icons.card_membership,
      'color': Colors.purple,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prestasi Kelas'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: achievements.length,
        itemBuilder: (context, index) {
          final achievement = achievements[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              leading: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: achievement['color'].withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(achievement['icon'], color: achievement['color']),
              ),
              title: Text(
                achievement['title'],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(achievement['description']),
                  const SizedBox(height: 8),
                  Text(
                    achievement['date'],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                // Aksi ketika item prestasi diklik
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Aksi untuk menambah prestasi
        },
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.add),
      ),
    );
  }
}