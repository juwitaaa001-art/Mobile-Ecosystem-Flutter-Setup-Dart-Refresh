import 'package:flutter/material.dart';

import '../models/krs_course.dart';

class AddKrsScreen extends StatefulWidget {
  const AddKrsScreen({super.key});

  @override
  State<AddKrsScreen> createState() => _AddKrsScreenState();
}

class _AddKrsScreenState extends State<AddKrsScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lecturerController = TextEditingController();
  final TextEditingController _sksController = TextEditingController(text: '3');

  @override
  void dispose() {
    _codeController.dispose();
    _nameController.dispose();
    _lecturerController.dispose();
    _sksController.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }

    final KrsCourse courseBaru = KrsCourse(
      code: _codeController.text.trim().toUpperCase(),
      name: _nameController.text.trim(),
      lecturer: _lecturerController.text.trim(),
      sks: int.tryParse(_sksController.text.trim()) ?? 3,
    );

    Navigator.pop(context, courseBaru);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Mata Kuliah'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'Kode Mata Kuliah *',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: _codeController,
                decoration: const InputDecoration(
                  hintText: 'Contoh: TRPL504',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Kode mata kuliah wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              const Text(
                'Nama Mata Kuliah *',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Contoh: Pemrograman Framework',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Nama mata kuliah wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              const Text(
                'Dosen Pengampu *',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: _lecturerController,
                decoration: const InputDecoration(
                  hintText: 'Contoh: Tim Dosen TRPL',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Dosen pengampu wajib diisi';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              const Text(
                'Bobot SKS (1–6) *',
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),

              TextFormField(
                controller: _sksController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'Contoh: 3',
                  border: OutlineInputBorder(),
                ),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Bobot SKS wajib diisi';
                  }

                  final int? sks = int.tryParse(value.trim());

                  if (sks == null) {
                    return 'SKS harus berupa angka';
                  }

                  if (sks < 1 || sks > 6) {
                    return 'SKS harus antara 1 sampai 6';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _simpan,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: const Text(
                    'Simpan ke Rencana Studi',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
