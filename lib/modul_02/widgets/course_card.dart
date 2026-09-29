import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({
    super.key,
    required this.course,
  });

  Color statusColor() {
    switch (course.status) {
      case "Berlangsung":
        return Colors.green;

      case "Akan datang":
        return Colors.blue;

      case "Selesai":
        return Colors.grey;

      case "Tersedia":
        return Colors.teal;

      default:
        return Colors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 70,
            height: 70,
            decoration: BoxDecoration(
              color: const Color(0xffEAF3FF),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(
              course.icon,
              color: const Color(0xff2F80ED),
              size: 36,
            ),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor().withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    course.status,
                    style: TextStyle(
                      color: statusColor(),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                Text(
                  course.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff173B72),
                  ),
                ),

                const SizedBox(height: 8),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      course.lab,
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                if (course.assistant.isNotEmpty)
                  Row(
                    children: [
                      const Icon(
                        Icons.people,
                        size: 16,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        course.assistant,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),

          if (course.time.isNotEmpty)
            Align(
              alignment: Alignment.topRight,
              child: Text(
                course.time,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Color(0xff667085),
                ),
              ),
            ),
        ],
      ),
    );
  }
}