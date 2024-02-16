import 'package:flutter/material.dart';
import '../models/discovery_item.dart';

class DiscoveryCard extends StatelessWidget {
  final DiscoveryItem item;

  const DiscoveryCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    List<Color> lightColors = [
      Colors.lightBlue,
      const Color(0xFFf6a530),
      const Color(0xFFf1a5a5),
    ];

    List<Color> darkColors = [
      const Color(0xFF282828),
    ];

    ThemeData currentTheme = Theme.of(context);
    List<Color> containerColors =
    currentTheme.brightness == Brightness.light ? lightColors : darkColors;
    int petId = item.id;
    Color selectedColor = containerColors[petId % containerColors.length];

    Color borderColor =
    currentTheme.brightness == Brightness.light ? Colors.white : Colors.teal;
    return Padding(

      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: selectedColor,
          child: Center(
            child: ListTile(
              title: Text(
                item.title,
                style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                item.description,
                style: const TextStyle(color: Colors.white),
              ),
              leading: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border.all(
                      color: Colors.white,
                      width: 5.0,
                    ),
                  ),
                  child: Image.network(
                    item.imageUrl,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),
        ),
    );
  }
}
