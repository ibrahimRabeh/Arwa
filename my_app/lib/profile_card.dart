// profile_card.dart
import 'package:flutter/material.dart';
import 'colors.dart';

class ProfileCard extends StatelessWidget {
  final String name;
  final double rating;
  final String? distance; // Nullable distance

  const ProfileCard({
    Key? key,
    required this.name,
    required this.rating,
    this.distance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(
          '/details',
          arguments: {
            'name': name,
            'rating': rating,
          },
        ); // Define the route in each page
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 12.0),
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: AppColors().backgroundColors,
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(color: Colors.grey[800]!, width: 1.5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Arrow icon on the left
            Row(
              children: [
                const Icon(Icons.arrow_back_ios_new),
                if (distance != null) const SizedBox(width: 10.0),
                if (distance != null)
                  Text(
                    distance!,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black54,
                    ),
                  ),
              ],
            ),
            // Profile details on the right
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 4.0),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange[600], size: 18),
                    const SizedBox(width: 4.0),
                    Text(
                      "$rating",
                      style:
                          const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
