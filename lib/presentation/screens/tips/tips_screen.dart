import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pool_solution/core/widgets/common/common.dart';
import 'package:pool_solution/l10n/app_localizations.dart';
import 'package:pool_solution/presentation/providers/tips_provider.dart';

class TipsScreen extends ConsumerStatefulWidget {
  const TipsScreen({super.key});

  @override
  ConsumerState<TipsScreen> createState() => _TipsScreenState();
}

class _TipsScreenState extends ConsumerState<TipsScreen> {
  String? _selectedCategory;
  String? _selectedPoolType;
  String? _selectedFilterType;
  String? _selectedChemicalType;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    // Get filtered tips based on current selections
    final tips = ref.watch(filteredTipsProvider({
      'poolType': _selectedPoolType,
      'filterType': _selectedFilterType,
      'chemicalType': _selectedChemicalType,
    })).where((tip) {
      // Additional category filter
      if (_selectedCategory != null && _selectedCategory != 'all') {
        return tip.category == _selectedCategory;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.homeTips),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => _showFilterDialog(context),
          ),
        ],
      ),
      drawer: LateralMenu(),
      body: SafeArea(
        child: Column(
          children: [
            // Active filters indicator
            if (_hasActiveFilters())
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                color: Theme.of(context).colorScheme.primaryContainer.withAlpha(50),
                child: Row(
                  children: [
                    Icon(
                      Icons.filter_list,
                      size: 16,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        _getActiveFiltersText(l10n),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: _resetFilters,
                      child: Text(
                        l10n.resetFilters,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            // Tips list
            Expanded(
              child: tips.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 64,
                            color: Colors.grey[400],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.noTipsFound,
                            style: Theme.of(context).textTheme.bodyLarge,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(12),
                      itemCount: tips.length,
                      itemBuilder: (context, index) {
                        final tip = tips[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: InfoCard(
                            icon: _getIconForCategory(tip.category),
                            iconColor: _getColorForCategory(tip.category),
                            title: tip.getTitle(context),
                            description: tip.getDescription(context),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  bool _hasActiveFilters() {
    return _selectedCategory != null ||
           _selectedPoolType != null ||
           _selectedFilterType != null ||
           _selectedChemicalType != null;
  }

  String _getActiveFiltersText(AppLocalizations l10n) {
    final filters = <String>[];

    if (_selectedCategory != null && _selectedCategory != 'all') {
      filters.add(_getCategoryDisplayName(l10n, _selectedCategory!));
    }
    if (_selectedPoolType != null && _selectedPoolType != 'all') {
      filters.add(_getPoolTypeDisplayName(l10n, _selectedPoolType!));
    }
    if (_selectedFilterType != null && _selectedFilterType != 'all') {
      filters.add(_getFilterTypeDisplayName(l10n, _selectedFilterType!));
    }
    if (_selectedChemicalType != null && _selectedChemicalType != 'all') {
      filters.add(_getChemicalTypeDisplayName(l10n, _selectedChemicalType!));
    }

    return filters.join(', ');
  }

  void _resetFilters() {
    setState(() {
      _selectedCategory = null;
      _selectedPoolType = null;
      _selectedFilterType = null;
      _selectedChemicalType = null;
    });
  }

  void _showFilterDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(l10n.homeTips),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Pool type filter
                    Text(
                      l10n.filterByPoolType,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          label: Text(l10n.poolTypeAll),
                          selected: _selectedPoolType == null || _selectedPoolType == 'all',
                          onSelected: (selected) {
                            setState(() {
                              _selectedPoolType = selected ? 'all' : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text(l10n.poolTypeLona),
                          selected: _selectedPoolType == 'lona',
                          onSelected: (selected) {
                            setState(() {
                              _selectedPoolType = selected ? 'lona' : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text(l10n.poolTypeObra),
                          selected: _selectedPoolType == 'obra',
                          onSelected: (selected) {
                            setState(() {
                              _selectedPoolType = selected ? 'obra' : null;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Filter type filter
                    Text(
                      l10n.filterByFilterType,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          label: Text(l10n.filterTypeAll),
                          selected: _selectedFilterType == null || _selectedFilterType == 'all',
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilterType = selected ? 'all' : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text(l10n.filterTypeArena),
                          selected: _selectedFilterType == 'arena',
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilterType = selected ? 'arena' : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text(l10n.filterTypeCartucho),
                          selected: _selectedFilterType == 'cartucho',
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilterType = selected ? 'cartucho' : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text(l10n.filterTypeDiatomea),
                          selected: _selectedFilterType == 'diatomea',
                          onSelected: (selected) {
                            setState(() {
                              _selectedFilterType = selected ? 'diatomea' : null;
                            });
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    // Chemical type filter
                    Text(
                      l10n.filterByChemicalType,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        FilterChip(
                          label: Text(l10n.chemicalTypeAll),
                          selected: _selectedChemicalType == null || _selectedChemicalType == 'all',
                          onSelected: (selected) {
                            setState(() {
                              _selectedChemicalType = selected ? 'all' : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text(l10n.chemicalTypeCloro),
                          selected: _selectedChemicalType == 'cloro',
                          onSelected: (selected) {
                            setState(() {
                              _selectedChemicalType = selected ? 'cloro' : null;
                            });
                          },
                        ),
                        FilterChip(
                          label: Text(l10n.chemicalTypeSalina),
                          selected: _selectedChemicalType == 'salina',
                          onSelected: (selected) {
                            setState(() {
                              _selectedChemicalType = selected ? 'salina' : null;
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(l10n.cancel),
                ),
                TextButton(
                  onPressed: () {
                    // Apply filters to main state
                    this.setState(() {});
                    Navigator.of(context).pop();
                  },
                  child: Text(l10n.apply),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _getCategoryDisplayName(AppLocalizations l10n, String category) {
    switch (category) {
      case 'general': return l10n.filterGeneralTips;
      case 'lona': return l10n.filterLonaTips;
      case 'obra': return l10n.filterObraTips;
      case 'cloro': return l10n.filterChlorineTips;
      case 'filtro': return l10n.filterFilterTips;
      default: return category;
    }
  }

  String _getPoolTypeDisplayName(AppLocalizations l10n, String poolType) {
    switch (poolType) {
      case 'lona': return l10n.poolTypeLona;
      case 'obra': return l10n.poolTypeObra;
      default: return poolType;
    }
  }

  String _getFilterTypeDisplayName(AppLocalizations l10n, String filterType) {
    switch (filterType) {
      case 'arena': return l10n.filterTypeArena;
      case 'cartucho': return l10n.filterTypeCartucho;
      case 'diatomea': return l10n.filterTypeDiatomea;
      default: return filterType;
    }
  }

  String _getChemicalTypeDisplayName(AppLocalizations l10n, String chemicalType) {
    switch (chemicalType) {
      case 'cloro': return l10n.chemicalTypeCloro;
      case 'salina': return l10n.chemicalTypeSalina;
      default: return chemicalType;
    }
  }

  /// Get icon based on tip category
  IconData _getIconForCategory(String category) {
    switch (category) {
      case 'general':
        return Icons.lightbulb_outline;
      case 'lona':
        return Icons.layers;
      case 'obra':
        return Icons.construction;
      case 'cloro':
        return Icons.science;
      case 'filtro':
        return Icons.filter_alt_rounded;
      default:
        return Icons.info_outline;
    }
  }

  /// Get color based on tip category
  Color _getColorForCategory(String category) {
    switch (category) {
      case 'general':
        return Colors.blue;
      case 'lona':
        return Colors.purple;
      case 'obra':
        return Colors.orange;
      case 'cloro':
        return Colors.green;
      case 'filtro':
        return Colors.indigo;
      default:
        return Colors.blue;
    }
  }
}
