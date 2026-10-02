import 'package:flutter/material.dart';
import '../../../../core/core.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  final Debouncer _debouncer = Debouncer(milliseconds: 300);
  final List<String> _recentSearches = [
    'Summer Dress',
    'Pullover',
    'T-Shirt',
    'Jeans',
    'Sneakers',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: AppTextField(
          controller: _searchController,
          hint: 'Search products, brands...',
          prefixIcon: Icons.search_rounded,
          onChanged: (query) {
            _debouncer.run(() {
              // Trigger live search
            });
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear_rounded),
            onPressed: () {
              AppHaptics.selection();
              _searchController.clear();
            },
          ),
        ],
      ),
      body: ResponsiveContainer(
        maxWidth: 800,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AppText.subtitle(
                'Recent Searches',
                fontWeight: FontWeight.bold,
                isMuted: true,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: _recentSearches.map((query) {
                  return ActionChip(
                    backgroundColor: colorScheme.surfaceContainerHighest
                        .withValues(alpha: 0.5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    label: AppText.body(query),
                    onPressed: () {
                      AppHaptics.selection();
                      _searchController.text = query;
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
