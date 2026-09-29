class Announcement {
  const Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.author,
    required this.category,
    required this.date,
    required this.readCount,
  });

  final int id;
  final String title;
  final String content;
  final String author;
  final String category;
  final String date;
  final int readCount;

  factory Announcement.fromJson(Map<String, dynamic> json) {
    return Announcement(
      id: json['id'] as int,
      title: json['title'] as String,
      content: json['content'] as String,
      author: json['author'] as String,
      category: json['category'] as String,
      date: json['date'] as String,
      readCount: json['readCount'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'content': content,
      'author': author,
      'category': category,
      'date': date,
      'readCount': readCount,
    };
  }

  static List<Announcement> getSampleAnnouncements() {
    return <Announcement>[
      const Announcement(
        id: 1,
        title: 'Jadwal Pengisian KRS',
        content: 'Pengisian KRS semester berikutnya dapat dilakukan sesuai jadwal yang telah ditentukan.',
        author: 'Bagian Akademik Poliwangi',
        category: 'Akademik',
        date: '2026-09-01',
        readCount: 120,
      ),
      const Announcement(
        id: 2,
        title: 'Sosialisasi Beasiswa Unggulan',
        content: 'Sosialisasi program beasiswa unggulan akan dilaksanakan untuk mahasiswa yang memenuhi persyaratan.',
        author: 'Kemahasiswaan Poliwangi',
        category: 'Beasiswa',
        date: '2026-08-28',
        readCount: 95,
      ),
      const Announcement(
        id: 3,
        title: 'Pendaftaran Magang Batch 7',
        content: 'Pendaftaran program magang Batch 7 telah dibuka bagi mahasiswa TRPL.',
        author: 'Koordinator Magang TRPL',
        category: 'Kegiatan',
        date: '2026-09-02',
        readCount: 78,
      ),
    ];
  }
}
