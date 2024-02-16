import 'package:flutter/material.dart';
import '../api/discovery_api.dart';
import '../models/discovery_item.dart';
import '../widgets/discovery_card.dart';

class DiscoveryPage extends StatefulWidget {
  @override
  _DiscoveryPageState createState() => _DiscoveryPageState();
}

class _DiscoveryPageState extends State<DiscoveryPage> {
  final DiscoveryApi _api = DiscoveryApi();
  final TextEditingController _searchController = TextEditingController();
  List<DiscoveryItem> _items = [];
  int _page = 1;
  final int _limit = 10;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      final List<DiscoveryItem> newItems = await _api.fetchItems(_page, _limit);

      setState(() {
        _items.addAll(newItems);
        _page++;
      });
    } catch (e) {
      // Handle errors gracefully
      print('Error: $e');
    }
  }

  void _loadMore() {
    _loadData();
  }

  void _searchItems(String query) {
    setState(() {
      _items = _items.where((item) {
        final titleLowerCase = item.title.toLowerCase();
        final descriptionLowerCase = item.description.toLowerCase();
        final searchLowerCase = query.toLowerCase();
        return titleLowerCase.contains(searchLowerCase) ||
            descriptionLowerCase.contains(searchLowerCase);
      }).toList();
    });
  }

  void _clearSearch() {
    setState(() {
      _searchController.clear();
      _loadData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Discovery Page', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.deepOrange)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _searchItems,
              decoration: InputDecoration(
                hintText: 'Search Item',
                filled: true,
                fillColor: Theme.of(context).brightness == Brightness.light
                    ? const Color(0xFFf6f6f6)
                    : const Color(0xFF282828),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0),
                prefixIcon:
                const Icon(Icons.search, color: Colors.grey),
                suffixIcon: GestureDetector(
                  onTap: () {
                    _clearSearch();
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.clear, color: Colors.grey),
                  )
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _items.length,
              itemBuilder: (context, index) => DiscoveryCard(item: _items[index]),
            ),
          ),
          ElevatedButton(
            onPressed: _loadMore,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.cyan.shade700,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10), // Button border radius
              ),
            ),
            child: const Text('Load More', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
