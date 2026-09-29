import 'package:flutter/material.dart';

import '../models/announcement.dart';
import '../services/announcement_api.dart';
import '../widgets/announcement_card.dart';
import 'announcement_detail_screen.dart';

class AnnouncementListScreen extends StatefulWidget {
  const AnnouncementListScreen({super.key, this.api});

  /// Bisa digunakan untuk widget test atau mode simulasi.
  final AnnouncementApi? api;

  @override
  State<AnnouncementListScreen> createState() => _AnnouncementListScreenState();
}

class _AnnouncementListScreenState extends State<AnnouncementListScreen> {
  bool _simulasiError = false;

  static const List<String> _kategori = <String>[
    'Semua',
    'Akademik',
    'Beasiswa',
    'Kegiatan',
    'Prestasi',
  ];

  late final AnnouncementApi _api =
      widget.api ?? AnnouncementApi(modeSimulasi: true);

  late Future<List<Announcement>> _futurePengumuman;

  String _kategoriTerpilih = 'Semua';

  @override
  void initState() {
    super.initState();

    _futurePengumuman = _api.ambilPengumuman();
  }

  @override
  void dispose() {
    _api.tutup();
    super.dispose();
  }

  // REFRESH DATA

  Future<void> _muatUlang() async {
    final Future<List<Announcement>> futureBaru = _api.ambilPengumuman();

    setState(() {
      _futurePengumuman = futureBaru;
    });

    try {
      await futureBaru;
    } catch (_) {
      // Error ditangani oleh FutureBuilder.
    }
  }

  // PILIH KATEGORI

  void _pilihKategori(String kategori) {
    if (kategori == _kategoriTerpilih) {
      return;
    }

    setState(() {
      _kategoriTerpilih = kategori;
    });
  }

  // BUKA DETAIL

  void _bukaDetail(Announcement announcement) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (_) => AnnouncementDetailScreen(announcement: announcement),
      ),
    );
  }

  // BUILD UTAMA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Portal Pengumuman TRPL'),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.refresh),
            tooltip: 'Segarkan Data',
            onPressed: _muatUlang,
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          _buildBarisFilter(),

          const Divider(height: 1),

          Expanded(
            child: FutureBuilder<List<Announcement>>(
              future: _futurePengumuman,
              builder: (context, snapshot) {
                // KEADAAN 1: LOADING

                if (snapshot.connectionState != ConnectionState.done) {
                  return _buildMemuat();
                }

                // KEADAAN 2: ERROR

                if (snapshot.hasError) {
                  return _buildGagal(snapshot.error!);
                }

                // KEADAAN 3 & 4: KOSONG / BERHASIL

                final List<Announcement> semua =
                    snapshot.data ?? const <Announcement>[];

                final List<Announcement> tampil = _kategoriTerpilih == 'Semua'
                    ? semua
                    : semua
                          .where(
                            (Announcement item) =>
                                item.category.toLowerCase() ==
                                _kategoriTerpilih.toLowerCase(),
                          )
                          .toList(growable: false);

                if (tampil.isEmpty) {
                  return _buildKosong();
                }

                return _buildDaftar(tampil);
              },
            ),
          ),
        ],
      ),
    );
  }

  // FILTER KATEGORI

  Widget _buildBarisFilter() {
    return SizedBox(
      height: 58,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        itemCount: _kategori.length,
        itemBuilder: (context, index) {
          final String kategori = _kategori[index];

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(kategori),
              selected: _kategoriTerpilih == kategori,
              onSelected: (_) {
                _pilihKategori(kategori);
              },
            ),
          );
        },
      ),
    );
  }

  // LOADING
  Widget _buildMemuat() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF0D2B45),
            border: Border.all(color: const Color(0xFF29B6F6), width: 3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Judul loading
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF24506F), width: 1),
                  ),
                ),
                child: const Text(
                  '1. LOADING — data belum tiba',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // Loading indicator
              const SizedBox(
                width: 55,
                height: 55,
                child: CircularProgressIndicator(
                  strokeWidth: 5,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF29B6F6)),
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                'Memuat pengumuman dari server...',
                style: TextStyle(color: Colors.white, fontSize: 14),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              const Text(
                'CircularProgressIndicator, bukan layar putih',
                style: TextStyle(color: Color(0xFFB0BEC5), fontSize: 13),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 15),

              const Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 18),
                child: Text(
                  'Memicu: buka layar lalu tangkap sebelum data tiba',
                  style: TextStyle(color: Color(0xFF29B6F6), fontSize: 13),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ERROR
  Widget _buildGagal(Object error) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(0xFF421719),
            border: Border.all(color: const Color(0xFFFF6B6B), width: 3),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              // Judul error
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Color(0xFF6B292C), width: 1),
                  ),
                ),
                child: const Text(
                  '2. ERROR — permintaan gagal',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 35),

              // Icon error
              const Icon(
                Icons.block_outlined,
                size: 58,
                color: Color(0xFFFF6B6B),
              ),

              const SizedBox(height: 20),

              const Text(
                'Gagal Memuat Data',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 6),

              const Text(
                'Gagal terhubung ke server.',
                style: TextStyle(color: Color(0xFFFFB3B3), fontSize: 13),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              // Tombol retry
              SizedBox(
                width: 155,
                height: 38,
                child: ElevatedButton(
                  onPressed: _muatUlang,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF6B6B),
                    foregroundColor: Colors.black,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                  child: const Text(
                    'Coba Lagi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  // DATA KOSONG
  Widget _buildKosong() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(Icons.inbox_outlined, size: 64),
          SizedBox(height: 16),
          Text(
            'Tidak ada pengumuman',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text('Belum ada pengumuman pada kategori ini.'),
        ],
      ),
    );
  }

  // DAFTAR PENGUMUMAN
  Widget _buildDaftar(List<Announcement> daftar) {
    return RefreshIndicator(
      onRefresh: _muatUlang,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(12),
        itemCount: daftar.length,
        itemBuilder: (context, index) {
          final Announcement announcement = daftar[index];

          return AnnouncementCard(
            announcement: announcement,
            onTap: () {
              _bukaDetail(announcement);
            },
          );
        },
      ),
    );
  }
}
