import 'package:flutter/material.dart';

import '../models/krs_course.dart';
import 'add_krs_screen.dart';
import 'course_detail_screen.dart';

class KrsListScreen extends StatefulWidget {
  const KrsListScreen({super.key});

  @override
  State<KrsListScreen> createState() => _KrsListScreenState();
}

class _KrsListScreenState extends State<KrsListScreen> {
  late List<KrsCourse> _krsList;

  @override
  void initState() {
    super.initState();

    _krsList = KrsCourse.getInitialCourses();
  }

  int get _totalSks {
    int total = 0;

    for (final course in _krsList) {
      total += course.sks;
    }

    return total;
  }

  Future<void> _tambahMataKuliah() async {
    final KrsCourse? courseBaru = await Navigator.push<KrsCourse>(
      context,
      MaterialPageRoute<KrsCourse>(builder: (context) => const AddKrsScreen()),
    );

    if (courseBaru != null) {
      setState(() {
        _krsList.add(courseBaru);
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${courseBaru.name} berhasil ditambahkan.'),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _bukaDetail(KrsCourse course) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(
        builder: (context) => CourseDetailScreen(course: course),
      ),
    );
  }

  void _hapusMataKuliah(KrsCourse course) {
    showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Hapus Mata Kuliah?'),
          content: Text(
            'Yakin ingin membatalkan pengambilan '
            '"${course.name}" (${course.sks} SKS)?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text('Batal'),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  _krsList.removeWhere((item) => item.code == course.code);
                });

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Mata kuliah ${course.name} berhasil dihapus.',
                    ),
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              },
              child: const Text('Hapus'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rencana Studi (KRS) TRPL'),
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: _totalSks >= 21
                  ? Colors.orange.withValues(alpha: 0.35)
                  : Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: Text(
              '$_totalSks / 24 SKS',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
            ),
          ),
        ],
      ),
      body: _krsList.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _krsList.length,
              itemBuilder: (context, index) {
                final KrsCourse course = _krsList[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: const Color(0xFFE0F2FE),
                      foregroundColor: const Color(0xFF0284C7),
                      child: Text(
                        '${course.sks}',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    title: Text(
                      course.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text('${course.code} • ${course.lecturer}'),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_outline,
                        color: Colors.redAccent,
                      ),
                      onPressed: () {
                        _hapusMataKuliah(course);
                      },
                    ),
                    onTap: () {
                      _bukaDetail(course);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _tambahMataKuliah,
        backgroundColor: const Color(0xFF0284C7),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Tambah MK'),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.school_outlined, size: 64, color: Color(0xFF94A3B8)),
          const SizedBox(height: 16),
          const Text(
            'Belum Ada Mata Kuliah Terpilih',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF334155),
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Silakan tambahkan mata kuliah '
            'ke kartu rencana studi Anda.',
            style: TextStyle(color: Color(0xFF64748B), fontSize: 13),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: _tambahMataKuliah,
            icon: const Icon(Icons.add),
            label: const Text('Tambah Mata Kuliah'),
          ),
        ],
      ),
    );
  }
}
