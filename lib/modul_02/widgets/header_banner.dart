import 'package:flutter/material.dart';

class HeaderBanner extends StatelessWidget {
  const HeaderBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Ruang Praktikum Hari Ini",
              style: TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.w700,
                color: Color(0xff173B72),
              ),
            ),
            SizedBox(height: 8),
            Text(
              "Jadwal dan status penggunaan laboratorium",
              style: TextStyle(
                fontSize: 18,
                color: Color(0xff667085),
              ),
            ),
          ],
        ),

        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: const Color(0xffE5EAF3),
            ),
          ),
          child: const Row(
            children: [
              Icon(
                Icons.calendar_month,
                color: Color(0xff173B72),
              ),
              SizedBox(width: 10),
              Text(
                "Senin, 21 Apr 2025",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}