import 'package:flutter/material.dart';

import 'models/course.dart';
import 'widgets/course_card.dart';
import 'widgets/header_banner.dart';

class AcademicDashboardScreen extends StatelessWidget {
  AcademicDashboardScreen({super.key});

  final List<Course> courses = const [
    Course(
      title: "Mobile Programming",
      lab: "Lab 1",
      time: "08:00 - 10:00",
      status: "Berlangsung",
      assistant: "Asisten: 2 orang",
      icon: Icons.computer,
    ),
    Course(
      title: "Rekayasa Perangkat Lunak",
      lab: "Lab 2",
      time: "10:00 - 12:00",
      status: "Akan datang",
      assistant: "Asisten: 2 orang",
      icon: Icons.settings,
    ),
    Course(
      title: "Basis Data",
      lab: "Lab 3",
      time: "13:00 - 15:00",
      status: "Selesai",
      assistant: "Asisten: 2 orang",
      icon: Icons.storage,
    ),
    Course(
      title: "Lab 2",
      lab: "Ruang tersedia",
      time: "",
      status: "Tersedia",
      assistant: "",
      icon: Icons.meeting_room,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7FAFF),
      body: Row(
        children: [
          buildSidebar(),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HeaderBanner(),

                  const SizedBox(height: 30),

                  Row(
                    children: [
                      Expanded(
                        child: statCard(
                          Icons.calendar_month,
                          "3 sesi",
                          "Hari ini",
                        ),
                      ),

                      const SizedBox(width: 20),

                      Expanded(
                        child: statCard(
                          Icons.meeting_room,
                          "1 ruang tersedia",
                          "dari 3 ruang",
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 25),

                  Wrap(
                    spacing: 10,
                    children: [
                      filterChip("Semua", true),
                      filterChip("Berlangsung", false),
                      filterChip("Akan datang", false),
                      filterChip("Selesai", false),
                      filterChip("Tersedia", false),
                    ],
                  ),

                  const SizedBox(height: 25),

                  GridView.builder(
                    shrinkWrap: true,
                    physics:
                        const NeverScrollableScrollPhysics(),
                    itemCount: courses.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      childAspectRatio: 2.3,
                    ),
                    itemBuilder: (context, index) {
                      return CourseCard(
                        course: courses[index],
                      );
                    },
                  ),

                  const SizedBox(height: 30),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: const Color(0xffEAF3FF),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Text(
                            "Laboratorium yang terjadwal dengan baik akan mendukung proses belajar yang lebih efektif dan nyaman.",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSidebar() {
    return Container(
      width: 250,
      color: Colors.white,
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const SizedBox(height: 60),

          menuItem(Icons.home, "Beranda", true),
          menuItem(Icons.calendar_month, "Jadwal", false),
          menuItem(Icons.meeting_room, "Ruang", false),
          menuItem(Icons.more_horiz, "Lainnya", false),

          const Spacer(),

          const Icon(
            Icons.calendar_month,
            color: Color(0xff2F80ED),
            size: 50,
          ),

          const SizedBox(height: 15),

          const Text(
            "Praktikum\nLebih Teratur\nHasil Lebih Baik",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Color(0xff173B72),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget menuItem(
    IconData icon,
    String title,
    bool active,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: active
            ? const Color(0xffEAF3FF)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: active
              ? const Color(0xff2F80ED)
              : Colors.black54,
        ),
        title: Text(
          title,
          style: TextStyle(
            color: active
                ? const Color(0xff2F80ED)
                : Colors.black87,
            fontWeight: active
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget statCard(
    IconData icon,
    String title,
    String subtitle,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.blue,
            size: 35,
          ),

          const SizedBox(width: 15),

          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(subtitle),
            ],
          ),
        ],
      ),
    );
  }

  Widget filterChip(
    String text,
    bool active,
  ) {
    return Chip(
      label: Text(text),
      backgroundColor:
          active ? Colors.blue : Colors.white,
      labelStyle: TextStyle(
        color:
            active ? Colors.white : Colors.black,
      ),
    );
  }
}