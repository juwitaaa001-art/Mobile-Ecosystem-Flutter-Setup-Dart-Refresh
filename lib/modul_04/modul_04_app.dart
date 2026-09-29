import 'package:flutter/material.dart';

import 'widgets/announcement_list_screen.dart';

class Modul04App extends StatelessWidget {
  const Modul04App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Portal Pengumuman TRPL',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const AnnouncementListScreen(),
    );
  }
}
