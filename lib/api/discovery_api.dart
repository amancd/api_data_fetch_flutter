import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/discovery_item.dart';

class DiscoveryApi {
  static const baseUrl = 'https://api-stg.together.buzz/mocks/discovery';

  Future<List<DiscoveryItem>> fetchItems(int page, int limit) async {
    try {
      final response = await http.get(Uri.parse('$baseUrl?page=$page&limit=$limit'));

      if (response.statusCode == 200) {
        final dynamic data = json.decode(response.body);

        // Check if 'data' key exists and its value is not null
        if (data != null && data['data'] != null) {
          // Use 'as List<dynamic>' to handle dynamic data
          final List<dynamic> itemsList = data['data'] as List<dynamic>;

          // Map items and convert them to DiscoveryItem
          final List<DiscoveryItem> items = itemsList.map((item) => DiscoveryItem(
            id: item['id'],
            title: item['title'],
            description: item['description'],
            imageUrl: item['image_url'],
          )).toList();

          return items;
        } else {
          // Handle the case where 'data' key is null or doesn't exist
          return [];
        }
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      // Handle other exceptions
      print('Error: $e');
      throw Exception('Failed to load items');
    }
  }
}

