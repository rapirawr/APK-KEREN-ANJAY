import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Pelajaran {
  final String nama;
  final String guru;
  final String jam;

  const Pelajaran({required this.nama, required this.guru, required this.jam});
}

abstract class JadwalPage extends StatelessWidget {
  final String hari;
  final List<Pelajaran> jadwalPelajaran;

  const JadwalPage({super.key, required this.hari, required this.jadwalPelajaran});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Jadwal Hari $hari"),
        // Menggunakan tema untuk warna AppBar
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: ListView.builder(
        itemCount: jadwalPelajaran.length,
        itemBuilder: (context, index) {
          final pelajaran = jadwalPelajaran[index];

          if (pelajaran.nama.toLowerCase() == 'libur') {
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.grey[200],
              child: const ListTile(
                title: Center(
                  child: Text(
                    "Libur Tolol",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            );
          }

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: theme.colorScheme.primary,
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white),
                ),
              ),
              title: Text(
                pelajaran.nama,
                style: const TextStyle(fontWeight: FontWeight.bold, fontFamily: "Poppins"),
              ),
              subtitle: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.person_outline, size: 16, color: theme.colorScheme.onSurface.withOpacity(0.7)),
                        const SizedBox(width: 8),
                        Text(pelajaran.guru),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(Icons.access_time_outlined, size: 16, color: theme.colorScheme.onSurface.withOpacity(0.7)),
                        const SizedBox(width: 8),
                        Text(pelajaran.jam),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      backgroundColor: theme.colorScheme.background,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final jadwalText = jadwalPelajaran.map((p) {
            if (p.nama.toLowerCase() == 'libur') return "Libur";
            return "${p.nama} (${p.guru}) - ${p.jam}";
          }).join('\n');

          Clipboard.setData(ClipboardData(text: jadwalText)).then((_) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Jadwal berhasil disalin!')),
            );
          });
        },
        backgroundColor: theme.colorScheme.primary,
        child: const Icon(Icons.copy_all),
      ),
    );
  }
}

class Senin extends JadwalPage {
  const Senin({super.key})
      : super(
          hari: "Senin",
          jadwalPelajaran: const [
            Pelajaran(nama: 'Upacara', guru: 'Pembina OSIS', jam: '07:00 - 07:30'),
            Pelajaran(nama: 'PJOK', guru: 'P. Didik', jam: '07:30 - 09:30'),
            Pelajaran(nama: 'Sejarah', guru: 'B. Efi', jam: '09:30 - 11:30'),
            Pelajaran(nama: 'PKN', guru: 'P. Heri', jam: '11:30 - 13:30'),
            Pelajaran(nama: 'Basis Data', guru: 'P. Hendro', jam: '13:30 - 15:30'),
          ],
        );
}

class Selasa extends JadwalPage {
  const Selasa({super.key})
      : super(
          hari: "Selasa",
          jadwalPelajaran: const [
            Pelajaran(nama: 'Sholat Dhuha', guru: 'Guru PAI', jam: '07:00 - 07:30'),
            Pelajaran(nama: 'Matematika', guru: 'B. Prabandari', jam: '07:30 - 10:30'),
            Pelajaran(nama: 'BK', guru: 'B. Kiki', jam: '10:30 - 11:30'),
            Pelajaran(nama: 'Pemrograman Web', guru: 'P. Nutriyo', jam: '11:30 - 15:30'),
          ],
        );
}

class Rabu extends JadwalPage {
  const Rabu({super.key})
      : super(
          hari: "Rabu",
          jadwalPelajaran: const [
            Pelajaran(nama: 'Upacara', guru: 'Pembina OSIS', jam: '07:00 - 07:30'),
            Pelajaran(nama: 'PJOK', guru: 'P. Didik', jam: '07:30 - 09:30'),
            Pelajaran(nama: 'Sejarah', guru: 'B. Efi', jam: '09:30 - 11:30'),
            Pelajaran(nama: 'PKN', guru: 'P. Heri', jam: '11:30 - 13:30'),
            Pelajaran(nama: 'Basis Data', guru: 'P. Hendro', jam: '13:30 - 15:30'),
          ],
        );
}

class Kamis extends JadwalPage {
  const Kamis({super.key})
      : super(
          hari: "Kamis",
          jadwalPelajaran: const [
            Pelajaran(nama: 'PBTGM', guru: 'P. Hendro', jam: '07:00 - 11:00'),
            Pelajaran(nama: 'Bahasa Daerah', guru: 'P. Ridwan', jam: '11:00 - 13:00'),
            Pelajaran(nama: 'Cloud Computing', guru: 'P. Iqbal', jam: '13:00 - 15:00'),
          ],
        );
}

class Jumat extends JadwalPage {
  const Jumat({super.key})
      : super(
          hari: "Jumat",
          jadwalPelajaran: const [
            Pelajaran(nama: 'PPB', guru: 'P. Iqbal', jam: '07:00 - 09:00'),
            Pelajaran(nama: 'Bahasa Inggris', guru: 'P. Arif', jam: '09:00 - 11:00'),
            Pelajaran(nama: 'KIK', guru: 'P. Hendra', jam: '11:00 - 14:30'),
          ],
        );
}

class Sabtu extends JadwalPage {
  const Sabtu({super.key})
      : super(
            hari: "Sabtu",
            jadwalPelajaran: const [
              Pelajaran(nama: 'libur', guru: '', jam: '-'),
            ]);
}

class Minggu extends JadwalPage {
  const Minggu({super.key})
      : super(
            hari: "Minggu",
            jadwalPelajaran: const [
              Pelajaran(nama: 'libur', guru: '', jam: '-'),
            ]);
}

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Jadwal'),
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
      ),
      body: ListView(
        children: [
          _buildDayCard(context, 'Senin', const Senin()),
          _buildDayCard(context, 'Selasa', const Selasa()),
          _buildDayCard(context, 'Rabu', const Rabu()),
          _buildDayCard(context, 'Kamis', const Kamis()),
          _buildDayCard(context, 'Jumat', const Jumat()),
          _buildDayCard(context, 'Sabtu', const Sabtu(), isWeekend: true),
          _buildDayCard(context, 'Minggu', const Minggu(), isWeekend: true),
        ],
      ),
    );
  }

  Widget _buildDayCard(BuildContext context, String day, Widget page, {bool isWeekend = false}) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => page));
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: isWeekend
                  ? [Colors.grey.shade700, Colors.grey.shade900]
                  : [theme.colorScheme.primary.withOpacity(0.8), theme.colorScheme.primary],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Icon(
                  isWeekend ? Icons.weekend_rounded : Icons.calendar_today_rounded,
                  color: Colors.white,
                  size: 30,
                ),
                const SizedBox(width: 16),
                Text(
                  day,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const Spacer(),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}