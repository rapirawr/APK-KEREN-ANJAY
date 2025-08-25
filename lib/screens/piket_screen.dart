import 'package:flutter/material.dart';

class PiketScreen extends StatelessWidget {
  const PiketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    // Data dummy untuk jadwal piket
    final List<Map<String, String>> jadwalPiket = [
      {'hari': 'Senin', 'nama': 'Cholel,Bagas,Icha,Vian'},
      {'hari': 'Selasa', 'nama': 'Rehan,Tiar,Angel,Fiyo'},
      {'hari': 'Rabu', 'nama': 'Dika,Fais,Ariel,Cece'},
      {'hari': 'Kamis', 'nama': 'Imron,Radin,Rafi,Refan'},
      {'hari': 'Jumat', 'nama': 'Rafikhul,Ifan,Ebin'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Jadwal Piket'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: jadwalPiket.length,
        itemBuilder: (context, index) {
          final jadwal = jadwalPiket[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 4,
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: Text(
                  jadwal['hari']![0], // Ambil huruf pertama dari nama hari
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              title: Text(
                'Hari ${jadwal['hari']}',
                style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  jadwal['nama']!,
                  style: theme.textTheme.bodyLarge?.copyWith(color: theme.colorScheme.onSurface.withOpacity(0.7)),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}