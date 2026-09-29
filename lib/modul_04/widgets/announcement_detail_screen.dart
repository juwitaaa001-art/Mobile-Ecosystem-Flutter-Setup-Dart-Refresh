import 'package:flutter/material.dart';

import '../models/announcement.dart';

class AnnouncementDetailScreen extends StatelessWidget {
  const AnnouncementDetailScreen({super.key, required this.announcement});

  final Announcement announcement;

  @override
  Widget build(BuildContext context) {
    final ColorScheme warna = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: const Text('Detail Pengumuman'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Kategori dan tanggal
            Row(
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: warna.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    announcement.category,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const Spacer(),
                Text(
                  announcement.date,
                  style: TextStyle(color: warna.onSurfaceVariant, fontSize: 13),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Judul
            Text(
              announcement.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            // Penulis
            Row(
              children: <Widget>[
                Icon(Icons.person_outline, size: 20, color: warna.primary),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    announcement.author,
                    style: TextStyle(
                      color: warna.onSurfaceVariant,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            const Divider(),

            const SizedBox(height: 20),

            // Isi pengumuman
            const Text(
              'Isi Pengumuman',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            Text(
              announcement.content,
              style: const TextStyle(fontSize: 16, height: 1.6),
            ),

            const SizedBox(height: 30),

            // Jumlah dibaca
            Row(
              children: <Widget>[
                Icon(Icons.visibility_outlined, size: 20, color: warna.primary),
                const SizedBox(width: 8),
                Text(
                  '${announcement.readCount} kali dibaca',
                  style: TextStyle(color: warna.onSurfaceVariant, fontSize: 13),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // Tombol kembali
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.arrow_back),
                label: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
